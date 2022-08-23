import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifidePage extends StatelessWidget {
  final String? lable;
  const NotifidePage({
    Key? key,
    required this.lable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.grey[600] : Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.white : Colors.grey,
          ),
        ),
        title: Text(
          this.lable.toString().split("|")[0],
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Get.isDarkMode ? Colors.white : Colors.grey[400]),
          child: Center(
            child: Text(
              this.lable.toString().split("|")[1],
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.black : Colors.white,
                  fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
