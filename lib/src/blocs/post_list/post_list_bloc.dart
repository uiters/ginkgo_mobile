import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'post_list_event.dart';
part 'post_list_state.dart';

class PostListBloc extends Bloc<PostListEvent, PostListState> {
  final Repository _repository = Repository();
  final int pageSize;
  final int userId;

  Pagination<Post> _postList = Pagination<Post>();

  Pagination<Post> get postList => _postList;

  PostListBloc(this.pageSize, {this.userId});

  @override
  PostListState get initialState => PostListInitial();

  @override
  Stream<PostListState> mapEventToState(PostListEvent event) async* {
    try {
      if (event is PostListEventFetch &&
          _postList.canLoadmore &&
          (this.state is! PostListStateFailure || event.force)) {
        yield PostListStateLoading();

        int _nextPage = _postList.pagination.currentPage + 1;

        _postList.add(
          userId != null
              ? await _repository.post.getUserPosts(
                  userId: userId,
                  page: _nextPage,
                  pageSize: pageSize,
                )
              : await _repository.post.getList(
                  pageSize: pageSize,
                  page: _nextPage,
                ),
        );

        yield PostListStateSuccess(_postList);
      }
    } catch (e) {
      yield PostListStateFailure(e);
    }
  }
}
