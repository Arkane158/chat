import 'package:chat/model/ui/base/base_nav.dart';
import 'package:flutter/material.dart';

class BaseViewmodel<N extends BaseNavigator> extends ChangeNotifier {
   N? navigator;
}
