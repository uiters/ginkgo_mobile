library widget;

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' show lerpDouble;

import 'package:base/base.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/app.dart';
import 'package:ginkgo_mobile/src/blocs/auth/auth_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/comment_list/comment_list_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/currentUser/current_user_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/place_list/place_list_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/post_comment/post_comment_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/navigators.dart';
import 'package:ginkgo_mobile/src/screens/screens.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/constrains.dart';
import 'package:ginkgo_mobile/src/utils/debouncer.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/gradientColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/errorIndicator.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/not_found_widget.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/showErrorMessage.dart';
import 'package:ginkgo_mobile/src/widgets/galleryItem.dart';
import 'package:ginkgo_mobile/src/widgets/gradientOutlineBorder.dart';
import 'package:ginkgo_mobile/src/widgets/spacingColumn.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:ginkgo_mobile/src/widgets/spincircle_bottom_bar/spincircle_bottom_bar.dart';
import 'package:ginkgo_mobile/src/widgets/tourWidgets/widgets/tourDetailWidget.dart';
import 'package:ginkgo_mobile/src/widgets/tourWidgets/widgets/tourInfoDetailWidget.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:timeago/timeago.dart' as timeAgo;

export 'userWidgets/user_widgets.dart';

part 'addCommentWidget.dart';
part 'appBars/backAppBar.dart';
part 'avatar.dart';
part 'buttons/primaryButton.dart';
part 'containers/borderContainer.dart';
part 'containers/collapse_container.dart';
part 'customs/image_widget.dart';
part 'dialogs/photo_view_dialog.dart';
part 'gradientTextFormField.dart';
part 'gradientUnderlineBorder.dart';
part 'hiddenText.dart';
part 'loadingDotIndicator.dart';
part 'loadingIndicator.dart';
part 'placeWidgets/opacityPlace.dart';
part 'placeWidgets/place_bottom_sheet.dart';
part 'primaryScaffold.dart';
part 'rating.dart';
part 'skeleton.dart';
part 'tourWidgets/blackOpacityTour.dart';
part 'tourWidgets/tourItem.dart';
part 'actionSheets/pick_image_action_sheet.dart';
part 'dialogs/common_dialog.dart';
part 'comment_widgets/comment_bottom_sheet.dart';
part 'comment_widgets/comment_item.dart';
