import 'package:ginkgo_mobile/src/models/comment.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/models/tour.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';

class Post {
  final String id;
  final User author;
  final DateTime createAt;
  final String content;
  final List<String> images;
  final int totalLike;
  final int totalComment;
  final List<Comment> featuredComments;
  final double rating;
  final SimpleTour tour;

  PostType get type {
    if (rating != null && tour != null) {
      return PostType.rating;
    } else if (tour != null) {
      if (createAt.difference(DateTime.now()).inMinutes < 1) {
        return PostType.tourJustCreated;
      } else {
        return PostType.tourCreated;
      }
    } else if (images.length > 1) {
      return PostType.images;
    } else if (images.length == 1) {
      return PostType.image;
    }

    return PostType.normal;
  }

  String get icon {
    if(type == PostType.image || type == PostType.images) {
      return Assets.icons.activityTypePhotography;
    } else if (type == PostType.rating) {
      return Assets.icons.activityTypeReview;
    }
    return Assets.icons.activityTypePost;
  }

  Post({
    this.id,
    this.author,
    this.createAt,
    this.content,
    this.images,
    this.totalLike,
    this.totalComment,
    this.featuredComments,
    this.rating,
    this.tour,
  });
}

enum PostType { normal, image, images, tourJustCreated, tourCreated, rating }
