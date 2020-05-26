import 'dart:ui';

import 'package:base/base.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/timeline_detail.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/customs/toast.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class TimelineDetailWidget extends StatelessWidget {
  final TimelineDetail timelineDetail;
  final bool isRightImage;

  const TimelineDetailWidget(
      {Key key, this.timelineDetail, this.isRightImage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> textAroundPlace =
        (timelineDetail.detail ?? '').split('{{place}}');
    final TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        // Navigate to place screen
        Toast.show(Strings.common.developingFeature, context);
      };

    return SpacingRow(
      reverse: isRightImage,
      spacing: 10,
      children: <Widget>[
        if (timelineDetail?.place?.images != null &&
            timelineDetail.place.images.length > 0)
          ImageWidget(
            timelineDetail.place.images[0],
            height: 50,
            width: 80,
            withShadow: true,
          ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: context.textTheme.caption
                  .copyWith(color: context.colorScheme.onBackground),
              text: '- ' +
                  (timelineDetail.time != null
                      ? timelineDetail.time + ': '
                      : ''),
              children: textAroundPlace
                  .map((e) => TextSpan(text: e))
                  .toList()
                  .addBetweenEvery(
                    timelineDetail.place != null
                        ? TextSpan(
                            text: ' ${timelineDetail.place.name}',
                            style: TextStyle(
                              color: DesignColor.cta,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: tapGestureRecognizer,
                          )
                        : TextSpan(),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
