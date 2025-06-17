// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:moonrig/controllers/profile_controller.dart';
// import 'package:moonrig/helpers/local_storage_helper.dart';

// class NotificationHelper {
//   static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static initNotifications() async {
//     await firebaseMessaging.requestPermission(
//         sound: true,
//         badge: true,
//         alert: true,
//         provisional: false,
//         announcement: true);
//     await getFCMToken();
//     await initLocalNotifications();

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (message.notification != null) {
//         showLocalNotification(message.notification!);
//         LocalStorage.write(
//           key: LocalStorageKeys.notificationCount,
//           data: (LocalStorage.read(key: LocalStorageKeys.notificationCount) ??
//                   0) +
//               1,
//         );
//         if (message.data["isAlert"] == "1") {
//           LocalStorage.write(
//             key: LocalStorageKeys.alertCoinCount,
//             data:
//                 (LocalStorage.read(key: LocalStorageKeys.alertCoinCount) ?? 0) +
//                     1,
//           );
//         }
//       }
//     });
//   }

 

//   static Future<void> backgroundHandler(RemoteMessage message) async {
//     await GetStorage.init();
//     if (message.notification != null) {
//       LocalStorage.write(
//         key: LocalStorageKeys.notificationCount,
//         data:
//             (LocalStorage.read(key: LocalStorageKeys.notificationCount) ?? 0) +
//                 1,
//       );
//       if (message.data["isAlert"] == "1") {
//         LocalStorage.write(
//           key: LocalStorageKeys.alertCoinCount,
//           data: (LocalStorage.read(key: LocalStorageKeys.alertCoinCount) ?? 0) +
//               1,
//         );
//       }
//     }
//   }

//   static getFCMToken() async {
//     String? token = await firebaseMessaging.getToken();
//     if (LocalStorage.read(key: LocalStorageKeys.userId) != null &&
//         token != LocalStorage.read(key: LocalStorageKeys.fcmToken)) {
//       ProfileController().updateFCMToken(
//           LocalStorage.read(key: LocalStorageKeys.fcmToken), token);
//     }
//     LocalStorage.write(key: LocalStorageKeys.fcmToken, data: token);
//   }

//   static initLocalNotifications() async {
//     var initializationSettingsAndroid =
//         const AndroidInitializationSettings('@drawable/ic_stat_name');

//     var initializationSettingsIOS = const DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     var initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   static showLocalNotification(RemoteNotification message) async {
//     var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//       'com.app.moonrig.io', 'Moonrig',
//       channelDescription: 'A notification from the Moonrig app',
//       importance: Importance.max,
//       priority: Priority.high,
//       setAsGroupSummary: true,
//       // icon: '@mipmap/ic_launcher_foreground',
//     );

//     var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );

//     var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );

//     await flutterLocalNotificationsPlugin.show(
//       message.hashCode,
//       message.title,
//       message.body,
//       platformChannelSpecifics,
//       payload: 'Default_Sound',
//     );
//   }
//    static getDeviceToken()async{
//     return await firebaseMessaging.getToken();
//   }
// }