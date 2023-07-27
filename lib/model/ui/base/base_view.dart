import 'package:chat/model/ui/base/base_nav.dart';
import 'package:chat/model/ui/base/base_viewmodel.dart';
import 'package:chat/model/ui/dialoge_utils.dart';
import 'package:flutter/material.dart';

abstract class BaseView<T extends StatefulWidget,VM extends BaseViewmodel>
    extends State<T> implements BaseNavigator {
  VM initViewmodel();
  late VM viewModel = initViewmodel();

  @override
  void hideDialog() {
    DialogeUtils.hideDialog(context);
  }

  @override
  void showMessage(String message,
      {String? posActionTitle,
      VoidCallback? posAction,
      VoidCallback? negAction,
      String? negActionTitle}) {
    DialogeUtils.showMessage(context, message);
  }

  @override
  void showProgressDialog(String message, {bool isDismissible = true}) {
    DialogeUtils.showProgressDialog(context, message);
  }
}
