import 'package:base/base.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/fakeData.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/homePage/widgets/homeSliverAppBar.dart';
import 'package:ginkgo_mobile/src/screens/profileScreen/widgets/activityBox.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:ginkgo_mobile/src/widgets/tourItem.dart';
import 'package:ginkgo_mobile/src/widgets/userWidgets/circleUser.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final tabList = ['Khám phá', 'Bảng tin'];
  TabController _tabController;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabList.length);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, _) {
          return [
            SliverPersistentHeader(
              floating: false,
              pinned: true,
              delegate: HomeSliverAppBarDelegate(
                  expandedHeight: 206,
                  bottom: PreferredSize(
                      child: Center(
                        child: TabBar(
                          controller: _tabController,
                          tabs: tabList.map((item) {
                            return Tab(
                              text: item,
                            );
                          }).toList(),
                          onTap: (i) {
                            _tabController.animateTo(i);
                          },
                          indicatorColor: context.colorScheme.primary,
                          labelColor: context.colorScheme.onBackground,
                          labelStyle: context.textTheme.caption
                              .copyWith(fontWeight: FontWeight.bold),
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorWeight: 2,
                          isScrollable: true,
                          indicator: UnderlineTabIndicator(
                            insets: EdgeInsets.only(bottom: 10),
                            borderSide: BorderSide(
                                width: 2, color: context.colorScheme.primary),
                          ),
                        ),
                      ),
                      preferredSize: Size.fromHeight(50))),
            )
          ];
        },
        body: ExtendedTabBarView(
          controller: _tabController,
          linkWithAncestor: true,
          children: [
            CustomScrollView(
              key: GlobalKey(),
              slivers: <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate([
                  BorderContainer(
                    title: 'Kết nối người tạo nên những chuyến đi',
                    icon: Assets.icons.contributor,
                    childPadding: EdgeInsets.only(bottom: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: IntrinsicHeight(
                        child: SpacingRow(
                          spacing: 10,
                          children: List.generate(10, (_) => FakeData.currentUser)
                              .map(
                                (e) => CircleUser(),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  BorderContainer(
                    title: 'Các chuyến đi',
                    icon: Assets.icons.tour,
                    childPadding: EdgeInsets.only(bottom: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: IntrinsicHeight(
                        child: SpacingRow(
                          spacing: 10,
                          children: List.generate(10, (_) => FakeData.simpleTour)
                              .map(
                                (e) => TourItem(tour: FakeData.simpleTour),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ]))
              ],
            ),
            CustomScrollView(
              key: GlobalKey(),
              slivers: <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate([
                  ActivityBox(),
                  ActivityBox(),
                  ActivityBox(),
                  ActivityBox(),
                  ActivityBox(),
                  ActivityBox(),
                  ActivityBox(),
                  ActivityBox(),
                  ActivityBox(),
                  ActivityBox(),
                ]))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
