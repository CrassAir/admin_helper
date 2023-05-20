import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

const notificationDuration = Duration(seconds: 3);
late Timer timer;

void loadingSnack() {
  if (Get.isSnackbarOpen) {
    return;
  }
  Future.delayed(Duration.zero, () {
    Get.snackbar('', '',
        titleText: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Loading...',
              style: TextStyle(fontSize: 28),
            ),
            CircularProgressIndicator()
          ],
        ),
        animationDuration: const Duration(milliseconds: 500),
        duration: const Duration(minutes: 1));
  });
}

void messageSnack({required String title, bool isSuccess = true, String? sub}) {
  Get.snackbar(
    title,
    sub ?? '',
    animationDuration: const Duration(milliseconds: 500),
    backgroundColor: isSuccess ? Colors.green : Colors.red,
    dismissDirection: DismissDirection.startToEnd,
    duration: notificationDuration,
  );
}


