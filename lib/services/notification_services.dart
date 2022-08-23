// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:local_notifaiction/models/task.dart';
import 'package:local_notifaiction/ui/notified_page.dart';
import 'package:local_notifaiction/ui/theme.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeNotification() async {
    _configureLocalTimezone();
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
      "app_icon",
    );

    //--------------------------------------------------

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  //--------------------------------------------------

  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'repeating description',
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
      icon: 'app_icon',
      color: primaryClr,
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

    //--------------------------------------------------
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      //this is push one notification
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: title,
    );
  }

  //--------------------------------------------------

  scheduledNotification(int hour, int minutes, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        //this is push a lot notification
        task.id!.toInt(),
        task.title,
        task.date,
        _convertTime(hour, minutes),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id', 'your channel name',
              channelDescription: 'your channel description',
              playSound: true,
              priority: Priority.high,
              importance: Importance.high,
              icon: 'app_icon',
       color: primaryClr,
       largeIcon: DrawableResourceAndroidBitmap('app_icon'),)),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,



        payload: '${task.title}|' '${task.note}|');
  } //this is for convert Time

  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.minute, now.day, hour, minutes);
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  //--------------------------------------------------

  void requestIOSPermissions() {
    /* this is for IOS */
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  //--------------------------------------------------

  Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    if (payload == 'Theme Changed') {
      print('Nothing novigater to');
    } else {
      Get.to(() => NotifidePage(lable: payload));
    }
  }

  //--------------------------------------------------

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // showDialog(
    //   //context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );

    Get.dialog(const Text('Welcome to flutter'));
  }
}
