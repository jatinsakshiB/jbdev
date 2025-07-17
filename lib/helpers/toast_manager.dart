
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/jb_config.dart';

void toast(String msg){
  Fluttertoast.showToast(
    msg: msg,
    toastLength: JBConfig.toastConfig.toastLength,
    gravity: JBConfig.toastConfig.gravity,
    backgroundColor: JBConfig.toastConfig.backgroundColor,
    textColor: JBConfig.toastConfig.textColor,
    fontSize: JBConfig.toastConfig.fontSize,

  );
}
