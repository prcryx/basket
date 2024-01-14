import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerServices {
  static void askShowNotificationPermission() async{
      await Permission.notification.isDenied.then((value) {
        if (value) {
          Permission.notification.request();
        }
      });
  }
}
