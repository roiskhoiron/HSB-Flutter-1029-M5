import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_planner/core/logging/app_logger.dart';
import 'package:travel_planner/core/result/result.dart';

class ResultHandler {
  ResultHandler._();

  static void handleResult(BuildContext context, Result result) {
    if (result.isFailure) {
      final error = result.error!;
      var backgroundColor = Colors.red;
      var textColor = Colors.white;

      if (error is ValidationError) {
        backgroundColor = Colors.orange;
        textColor = Colors.black;
      } else if (error is AuthenticationError) {
        backgroundColor = Colors.red;
        textColor = Colors.white;
      } else if (error is NotFoundError) {
        backgroundColor = Colors.orange;
        textColor = Colors.black;
      } else if (error is DataError) {
        backgroundColor = Colors.red;
        textColor = Colors.white;
      } else if (error is NetworkError) {
        backgroundColor = Colors.red;
        textColor = Colors.white;
      } else if (error is ServerError) {
        backgroundColor = Colors.red;
        textColor = Colors.white;
      }

      AppLogger.getLogger(
        'ResultHandler',
      ).severe('Failure: ${error.message} (${error.code})');

      Fluttertoast.showToast(
        msg: error.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: backgroundColor,
        textColor: textColor,
      );
    }
  }

  static void handleError(BuildContext context, String error) {
    AppLogger.getLogger('ResultHandler').severe('Error: $error');
    Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  static void showSuccessToast(BuildContext context, String message) {
    AppLogger.getLogger('ResultHandler').info('Success: $message');
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  static void showErrorToast(BuildContext context, String message) {
    AppLogger.getLogger('ResultHandler').severe('Error Toast: $message');
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  static void showWarningToast(BuildContext context, String message) {
    AppLogger.getLogger('ResultHandler').warning('Warning: $message');
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.orange,
      textColor: Colors.black,
    );
  }

  static void showInfoToast(BuildContext context, String message) {
    AppLogger.getLogger('ResultHandler').info('Info: $message');
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }
}
