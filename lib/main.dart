import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mr_ambarisha_frontend_new/core/bindings/initial_bindings.dart';
import 'package:mr_ambarisha_frontend_new/core/common/db/local_db.dart';
import 'package:mr_ambarisha_frontend_new/core/services/notification/notification_service.dart';
import 'package:mr_ambarisha_frontend_new/core/services/permission/permission_handler.dart';

import 'package:mr_ambarisha_frontend_new/views/splash_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseBoxes.init();
  PermissionHandlerServices.askShowNotificationPermission();
  NotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      // designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          initialBinding: InitialBindings(),

          home: child,
        );
      },
      child: SplashView(),
    );
  }
}
