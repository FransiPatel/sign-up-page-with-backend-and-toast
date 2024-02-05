import 'package:dummy/format.dart';
import 'package:dummy/login_page.dart';
import 'package:dummy/otp_page.dart';
import 'package:dummy/service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
// import 'package:toast/toast.dart';
import 'package:fluttertoast/fluttertoast.dart';

Logger logger = Logger();
Service service = Service();

Future<void> validateAndOtpPage(Format data, BuildContext context) async {
  // Validation
  // If user exists
  // If password correct
  // Go to otp page

  logger.i(data.username);
  logger.i(data.password);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const OtpPage(),
    ),
  );
}

Future<void> newUser(
    {required Format data, required BuildContext context}) async {
  // If password correct
  // First, check whether the password and confirm password are the same or not because we don't need the database for it
  if (data.password != data.confirmPassword) {
    logger.i("Password and confirm password mismatch");

    // Create a toast to tell the user that the password entered is incorrect
    Fluttertoast.showToast(
      msg: "The password entered is incorrect",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      // backgroundColor: Colors.blue,
      // textColor: Colors.black,
      fontSize: 16.0,
    );
  } else {
    Future<bool> dataStore =
        service.saveUser(data.username, data.email, data.password);
    if (await dataStore) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    } else {
      // Create a toast to tell the user that either the username or email is duplicated
      Fluttertoast.showToast(
          msg: "Username or email is duplicate",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          // backgroundColor: Colors.blue,
          // textColor: Colors.black,
          fontSize: 16.0);
    }
  }
}
