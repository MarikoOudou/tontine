// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;

// class NotificationService {
//   static final NotificationService _notificationService =
//       NotificationService._internal();

//   factory NotificationService() {
//     return _notificationService;
//   }

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   NotificationService._internal();

//   Future<void> initNotification() async {
//     final AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@drawable/ic_flutternotification');

//     // final IOSInitializationSettings initializationSettingsIOS =
//     //     IOSInitializationSettings(
//     //   requestAlertPermission: false,
//     //   requestBadgePermission: false,
//     //   requestSoundPermission: false,
//     // );

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       // iOS: initializationSettingsIOS
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future<void> showNotification(
//       int id, String title, String body, int seconds) async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
//       const NotificationDetails(
//         android: AndroidNotificationDetails('main_channel', 'Main Channel',
//             importance: Importance.max,
//             priority: Priority.max,
//             icon: '@drawable/android12splash.png'),
//         // iOS: IOSNotificationDetails(
//         //   sound: 'default.wav',
//         //   presentAlert: true,
//         //   presentBadge: true,
//         //   presentSound: true,
//         // ),
//       ),
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       androidAllowWhileIdle: true,
//     );
//   }

//   Future<void> cancelAllNotifications() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }
// }

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Noti {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        new AndroidInitializationSettings('mipmap/ic_launcher');
    // var iOSInitialize = new IOSInitializationSettings();
    var initializationsSettings = new InitializationSettings(
      android: androidInitialize,
      // iOS: iOSInitialize
    );
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future showBigTextNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('main_channel', 'Main Channel',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/splash');

    var not = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOS: IOSNotificationDetail()
    );
    await fln.show(0, title, body, not);
  }
}
