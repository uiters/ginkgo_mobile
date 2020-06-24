part of '../screens.dart';

class HomeScreenArgs {
  final int tabIndex;

  const HomeScreenArgs({this.tabIndex = 0});
}

class HomeScreen extends StatefulWidget {
  final HomeScreenArgs args;

  const HomeScreen({Key key, HomeScreenArgs args})
      : this.args = args ?? const HomeScreenArgs(),
        super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final List<_BottomNavigationBarItemData> items = [
    _BottomNavigationBarItemData(
      title: Strings.bottomNavigator.home,
      svgIconDisable: Assets.icons.homeOutline,
      svgIconEnable: Assets.icons.homeFull,
    ),
    _BottomNavigationBarItemData(
      title: Strings.bottomNavigator.tour,
      svgIconDisable: Assets.icons.tripOutline,
      svgIconEnable: Assets.icons.tripFull,
    ),
    _BottomNavigationBarItemData(
      title: Strings.bottomNavigator.notification,
      svgIconDisable: Assets.icons.notiOutline,
      svgIconEnable: Assets.icons.notiFull,
    ),
    _BottomNavigationBarItemData(
      title: Strings.bottomNavigator.profile,
      svgIconDisable: Assets.icons.meOutline,
      svgIconEnable: Assets.icons.meFull,
    ),
  ];

  int _cIndex;
  TabController _tabController;

  final _pages = [
    HomePage(),
    ManageTourScreen(),
    NotificationScreen(),
    ProfilePage(key: GlobalKey()),
  ];

  _onChangeTab(int index) {
    setState(() {
      _cIndex = index;
      _tabController.animateTo(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _cIndex = widget.args.tabIndex;
    _tabController = TabController(
        initialIndex: _cIndex, length: _pages.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _cIndex = _tabController.index;
      });
    });

    CurrentUserBloc().listen((state) {
      if (state is CurrentUserStateLoading) {
        if (LoadingManager().showCount == 0) {
          LoadingManager().show(context);
        }
      } else {
        LoadingManager().hide(context);

        if (state is CurrentUserStateFailure) {
          AwesomeDialog(
            context: context,
            dismissOnTouchOutside: false,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            title: 'Lỗi khi tải thông tin cá nhân.',
            desc: 'Vui lòng thử lại hoặc đăng xuất.',
            btnCancelOnPress: () {
              // Navigator.pop(context);
              AuthBloc().add(AuthEventLogout());
            },
            btnCancelText: 'ĐĂNG XUẤT',
            btnOkOnPress: () {
              // Navigator.pop(context);
              CurrentUserBloc().add(CurrentUserEventFetch());
            },
            btnOkText: 'TẢI LẠI',
          )..show();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      // bottomNavigationBar: _buildBottomNavigator(context),
      body: SpinCircleBottomBarHolder(
        bottomNavigationBar: SCBottomBarDetails(
          bnbHeight: 56,
          circleColors: [
            Colors.white,
            context.colorScheme.secondary,
            context.colorScheme.primary
          ],
          iconTheme: IconThemeData(color: Colors.black45, size: 20),
          activeIconTheme:
              IconThemeData(color: context.colorScheme.primary, size: 20),
          backgroundColor: Colors.white,
          titleStyle: TextStyle(color: Colors.black45, fontSize: 12),
          activeTitleStyle: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
          actionButtonDetails: SCActionButtonDetails(
              color: Colors.redAccent,
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              elevation: 2),
          elevation: 2.0,
          items: items
              .asMap()
              .map(
                (i, e) => MapEntry(
                  i,
                  SCBottomBarItem(
                      svgIcon: e.svgIconDisable,
                      svgActiveIcon: e.svgIconEnable,
                      title: e.title,
                      onPressed: () {
                        _onChangeTab(i);
                      }),
                ),
              )
              .values
              .toList(),
          circleItems: [
            SCItem(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigators.appNavigator.currentState
                      .pushNamed(Routes.createPost);
                }),
            SCItem(icon: Icon(Icons.camera_enhance), onPressed: () {}),
            SCItem(icon: Icon(Icons.add_comment), onPressed: () {}),
          ],
        ),
        child: HomeProvider(
          context,
          child: ExtendedTabBarView(
            cacheExtent: 4,
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: _pages,
          ),
        ),
      ),
    );
  }

  // Default bottom navigator
  // _buildBottomNavigator(BuildContext context) {
  //   final colorScheme = context.colorScheme;
  //   final textStyle = TextStyle(fontSize: 12);
  //   return BottomNavigationBar(
  //     backgroundColor: colorScheme.background,
  //     elevation: 10,
  //     onTap: _onChangeTab,
  //     currentIndex: _cIndex,
  //     type: BottomNavigationBarType.fixed,
  //     items: items
  //         .map(
  //           (e) => BottomNavigationBarItem(
  //             icon: SvgPicture.asset(
  //               e.svgIconDisable,
  //               color: colorScheme.onBackground,
  //               height: 24,
  //             ),
  //             title: Text(
  //               e.title,
  //               style: textStyle,
  //             ),
  //             activeIcon: SvgPicture.asset(
  //               e.svgIconEnable,
  //               color: colorScheme.primary,
  //               height: 24,
  //             ),
  //           ),
  //         )
  //         .toList(),
  //   );
  // }
}

class _BottomNavigationBarItemData {
  final String svgIconDisable;
  final String svgIconEnable;
  final String title;

  _BottomNavigationBarItemData(
      {this.svgIconDisable, this.svgIconEnable, this.title});
}
