import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin DialogMixin {
  void showAlertDialog(
    context,
    title,
    message,
    yes,
    no,
    Function callback,
  ) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        if (no != null)
          return getDialogTwoButton(context, title, message, yes, no, callback);
        else
          return getDialogOneButton(context, title, message, yes, no, callback);
      },
      barrierDismissible: false,
    );
  }
 
  CupertinoAlertDialog getDialogTwoButton(
      context, title, message, yes, no, Function callback) {
    RenderObject.debugCheckingIntrinsics = true;
    return CupertinoAlertDialog(
      title: title != null
          ? Text(
              title,
              style: const TextStyle(
                color: Colors.black,
              ),
            )
          : Container(),
      content: Text(message ?? ""),
      actions: [
        yes != null
            ? CupertinoDialogAction(
                child: Text(
                  yes,
                ),
                onPressed: () {
                  Future.delayed(
                    const Duration(milliseconds: 10),
                    () => callback(true),
                  );
                  Navigator.of(context).pop();
                },
              )
            : Container(),
        no != null
            ? CupertinoDialogAction(
                child: Text(
                  no,
                ),
                onPressed: () {
                  Future.delayed(
                    const Duration(milliseconds: 10),
                    () => callback(false),
                  );
                  Navigator.of(context).pop();
                },
              )
            : Container(),
      ],
    );
  }

  CupertinoAlertDialog getDialogOneButton(
      context, title, message, yes, no, Function callback) {
    RenderObject.debugCheckingIntrinsics = true;
    return CupertinoAlertDialog(
      title: title != null
          ? Text(
              title,
              style: TextStyle(
                color: Colors.black,
              ),
            )
          : Container(),
      content: Text(message ?? ""),
      actions: [
        yes != null
            ? CupertinoDialogAction(
                child: Text(
                  yes,
                ),
                onPressed: () {
                  Future.delayed(
                    const Duration(milliseconds: 10),
                    () => callback(true),
                  );
                  Navigator.of(context).pop();
                },
              )
            : Container(),
      ],
    );
  }

  void showGetXToast(text, message) {
    if (text != null && text.toString().isNotEmpty) {
      Get.snackbar(
        text,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF191E26),
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }
  }
}
