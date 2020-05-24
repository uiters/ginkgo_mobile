library screens;

import 'dart:async';

import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/blocs/auth/auth_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/authScreen/auth_screen_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/currentUser/current_user_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/user/user_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/models/user.dart';
import 'package:ginkgo_mobile/src/navigators.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/homePage/homePage.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/homeProvider.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/profilePage/widgets/aboutBox.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/profilePage/widgets/activityBox.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/profilePage/widgets/avatarWidget.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/profilePage/widgets/edit_slogan_bottom_sheet.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/profilePage/widgets/friendList.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/profilePage/widgets/infoBox.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/profilePage/widgets/ownerNav.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/profilePage/widgets/tourListWidget.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/heroKeys.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/utils/validator.dart';
import 'package:ginkgo_mobile/src/widgets/LoadingManager.dart';
import 'package:ginkgo_mobile/src/widgets/buttons/commonOutlineButton.dart';
import 'package:ginkgo_mobile/src/widgets/customs/toast.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/errorIndicator.dart';
import 'package:ginkgo_mobile/src/widgets/logoWidget.dart';
import 'package:ginkgo_mobile/src/widgets/spacingColumn.dart';
import 'package:ginkgo_mobile/src/widgets/trip/tripItem.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../app.dart';

part 'emailScreen/emailScreen.dart';
part 'homeScreen/homeScreen.dart';
part 'homeScreen/profilePage/profileListTourScreen.dart';
part 'homeScreen/profilePage/profilePage.dart';
part 'homeScreen/profilePage/profileScreen.dart';
part 'homeScreen/profilePage/userScreen.dart';
part 'loginScreen/loginScreen.dart';
part 'registerScreen/registerScreen.dart';
part 'splashScreen/splashScreen.dart';