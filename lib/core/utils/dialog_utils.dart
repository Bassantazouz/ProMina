import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const AlertDialog(
          content: Row(
            children: [
              Text(
                "Loading...",
                style: TextStyle(color: Color(0xFF4A4A4A)),
              ),
              Spacer(),
              CircularProgressIndicator(),
            ],
          ),
        );
      });
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}


void showInvalidUserSnackbar(BuildContext context,String text, {Color? color}) {

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color == null?Colors.red:Colors.green,
      content: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}


