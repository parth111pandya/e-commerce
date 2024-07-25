import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import '../utils/ConnectionStatusSingleton.dart';
import '../utils/DialogMixin.dart';
import 'ApiNameConst.dart';
import 'api_service.dart';

class ApiExecutor with DialogMixin {
  late ProgressDialog pd;
  final dio = Dio();

  Future<void> showPd(context, isNew) async {
    pd = ProgressDialog(
      context,
      type: ProgressDialogType.normal,
      isDismissible: true,
    );
    pd.style(
      padding: EdgeInsets.all(20),
      elevation: 10,
      message: 'Please wait...',
      progressWidget: const SpinKitCircle(
        color: Colors.black,
        size: 30.0,
      ),
      insetAnimCurve: Curves.easeInOut,
    );
    if (isNew) {
      await pd.show();
    }
  }

  Future<void> dismissPd(isClose) async {
    if (isClose) {
      await pd.hide();
    }
  }

  Future<void> callApi(context, apiCode, isNew, isClose,
      Map<String, dynamic> data, Function onGetData, isShowDialog) async {
    bool isInternetAvailable =
        await ConnectionStatusSingleton.getInstance().checkConnection();
    if (isInternetAvailable) {
      await showPd(context, isNew);
      final api = Get.put(ApiService(dio));
      Future<String>? future;
      switch (apiCode) {
        case CATEGORIES:
          future = api.categories();
          break;
        case PRODUCTS:
          future = api.products();
          break;
      }
      await future!.then(
        (value) async {
          await dismissPd(isClose);
          // SuccessModel detailModel = SuccessModel.fromJson(jsonDecode(value));
          // if (detailModel.isResult == 0) {
          //   await dismissPd(true);
          //   if (isShowDialog) {
          //     showAlertDialog(context, 'Alert', detailModel.message, 'Okay',
          //         null, (val) {});
          //   }
          //   print(value);
          //   onGetData(value);
          // } else {
          await dismissPd(true);
          onGetData(value);
          // }
        },
        onError: (data) async {
          print("data:::${data}");
          DioException error = data;
          await dismissPd(isClose);
          if (error.response!.statusCode == 500) {
            showAlertDialog(context, 'Alert', 'Something went wrong', 'Okay',
                null, (val) {});
          }
        },
      );
    } else {
      Future.delayed(
        Duration.zero,
        () async {
          showAlertDialog(context, 'Internet',
              'Please check your internet connection', 'Ok', null, (val) {});
        },
      );
    }
  }
}
