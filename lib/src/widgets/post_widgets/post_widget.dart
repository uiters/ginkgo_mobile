library post_widgets;

import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/blocs/currentUser/current_user_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/galleryItem.dart';
import 'package:ginkgo_mobile/src/widgets/spacingColumn.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:like_button/like_button.dart';

part 'widgets/post_like_button.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final Function(Post) onMenuPressed;
  final bool showAuthorAvatar;
  final bool isCollapse;

  const PostWidget({
    Key key,
    this.post,
    this.onMenuPressed,
    this.showAuthorAvatar = false,
    this.isCollapse = true,
  }) : super(key: key);

  _openListCommnent(BuildContext context) {
    CommentBottomSheet(context, postId: post?.id, totalLike: post?.totalLike)
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      enabled: post == null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                  color: context.colorScheme.background,
                  borderRadius: BorderRadius.circular(90)),
              child: !showAuthorAvatar
                  ? SvgPicture.asset(post?.icon ?? '', height: 24)
                  : AspectRatio(
                      aspectRatio: 1,
                      child: Avatar(
                        imageUrl: post?.author?.avatar?.smallThumb ?? '',
                        size: 40,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            flex: 9,
            child: ListView(
              itemExtent: null,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: <Widget>[
                SkeletonItem(
                  child: _buildTop(
                    context,
                    author: post?.author,
                    totalImage: post?.images?.length ?? 0,
                  ),
                ),
                SkeletonItem(child: _buildTime(context, post?.createAt)),
                const SizedBox(height: 5),
                if (post?.type == PostType.rating) Rating(rating: post?.rating),
                SkeletonItem(
                  child: isCollapse
                      ? HiddenText(post?.content ?? '')
                      : Text(post?.content),
                ),
                const SizedBox(height: 5),
                if (post?.images != null && post.images.length > 0) ...[
                  GalleryItem(
                    images:
                        post?.images?.map((e) => e.original)?.toList() ?? [],
                    borderRadius: BorderRadius.circular(0),
                    onPressed: () {
                      PhotoViewDialog(
                        context,
                        images: post?.images,
                        descriptions: List.generate(
                          post.images.length,
                          (index) => PhotoViewDescription(
                            title: post?.author?.displayName,
                            content: post?.content,
                            subTitle:
                                post?.createAt?.toVietNamese(withTime: true),
                          ),
                        ),
                      ).show();
                    },
                  ),
                  const SizedBox(height: 5)
                ],
                if (post != null) ...[
                  PostLikeCommentButton(
                    post: post,
                    onCommentPressed: () => _openListCommnent(context),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () => _openListCommnent(context),
                    child: _buildCommentList(
                      context,
                      totalComment: post?.totalComment,
                      comment: post?.featuredComment,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTop(BuildContext context,
      {int totalImage, @required SimpleUser author}) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _buildPostTitle(context, post),
        ),
        CupertinoButton(
          minSize: 0,
          padding: EdgeInsets.zero,
          child: Icon(
            Icons.more_horiz,
            color: context.colorScheme.onBackground,
          ),
          onPressed: () => onMenuPressed?.call(post),
        )
      ],
    );
  }

  Widget _buildPostTitle(BuildContext context, Post post) {
    List<TextSpan> textSpans = [];
    bool isJust = post?.createAt != null
        ? DateTime.now()
                .difference(post?.createAt)
                .compareTo(Duration(minutes: 1)) <
            0
        : false;
    final authorName = post?.author?.displayName ?? '';

    switch (post?.type) {
      case PostType.normal:
        textSpans = [
          TextSpan(text: authorName),
          TextSpan(
            text: Strings.post?.postAPost(isJust: isJust),
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ];
        break;
      case PostType.image:
        textSpans = [
          TextSpan(text: authorName),
          TextSpan(
            text: Strings.post?.postAImage(isJust: isJust),
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ];
        break;
      case PostType.images:
        textSpans = [
          TextSpan(text: authorName),
          TextSpan(
            text: Strings.post?.postImages(isJust: isJust),
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ];
        break;
      case PostType.tourJustCreated:
        textSpans = [
          TextSpan(text: authorName),
          TextSpan(
            text: Strings.post?.createATour(isJust: isJust),
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ];
        break;
      case PostType.tourCreated:
        textSpans = [
          TextSpan(text: authorName),
          TextSpan(
            text: Strings.post?.createATour(),
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ];
        break;
      case PostType.rating:
        textSpans = [
          TextSpan(text: authorName),
          TextSpan(
            text: Strings.post?.reviewTitle,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          TextSpan(
            text: post?.tour?.name ?? '',
          ),
          TextSpan(
            text: ' của ',
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          TextSpan(
            text: post?.tour?.host?.name ?? '',
          ),
        ];
        break;
    }

    return RichText(
      text: TextSpan(
        style:
            context.textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold),
        children: textSpans,
      ),
    );
  }

  Widget _buildTime(BuildContext context, DateTime createAt) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(
          Assets.icons.datetime,
          color: DesignColor.tinyItems,
          height: 10,
        ),
        const SizedBox(width: 5),
        Text(
          createAt?.toVietNamese(withTime: true) ?? '',
          style: TextStyle(fontSize: 10, color: DesignColor.tinyItems),
        ),
      ],
    );
  }

  Widget _buildCommentList(BuildContext context,
      {@required int totalComment, @required Comment comment}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (totalComment > 1) ...[
          Text(
            Strings.post?.viewAllComment(totalComment),
            style: context.textTheme.overline.copyWith(
              color: DesignColor.tinyItems,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8)
        ],
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SpacingColumn(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (comment != null) _buildComment(context, comment),
              AddCommentWidget(
                  avatar: CurrentUserBloc().currentUser.avatar.smallSquare),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildComment(BuildContext context, Comment comment) {
    return Row(
      children: <Widget>[
        Avatar(imageUrl: comment.author.avatar.smallThumb),
        const SizedBox(width: 6),
        Text(
          comment.author.displayName,
          style: context.textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onBackground,
          ),
        ),
        Expanded(
          child: Text(
            ' ${comment.content}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodyText2.copyWith(
              color: context.colorScheme.onBackground,
            ),
          ),
        ),
      ],
    );
  }
}
