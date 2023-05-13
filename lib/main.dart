import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/Network/local/Chache_Helper.dart';
import 'package:shop_app/Network/remote/Dio_Helper.dart';
import 'package:shop_app/modules/on_boarding/onboarding_Screen.dart';
import 'package:shop_app/modules/shop_home/Home_Layout.dart';
import 'package:shop_app/style/color.dart';
import 'Network/remote/bloc_observer.dart';
import 'const.dart';
import 'modules/shop_app_login/shop_login_screen.dart';
import 'modules/shop_register/shop_register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Cache_Helper.init();
  MyBlocObserver();
  DioHelper.init();

  bool? onBoarding = Cache_Helper.getDataFromSharedPref(key: 'onboarding');
  // print(onBoarding);
  token = Cache_Helper.getDataFromSharedPref(key: 'token');
  print(token);
  Widget? widget;

  if (onBoarding == null) {
    widget = OnBoardingScreen();
  } else {
    if (token != null)
      widget = Home_Layout();
    else
      widget = LoginScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
  // runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  final Widget startWidget;

  const MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Janna',
        primarySwatch: defaultColor,
        appBarTheme: const AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(color: defaultColor),
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            )),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: startWidget,
      debugShowCheckedModeBanner: false,
    );
  }
}
