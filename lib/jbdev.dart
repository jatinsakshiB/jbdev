library jbdev;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jbdev/jbdev.dart';

import 'app.dart';


export 'package:jbdev/utils/jb_config.dart';
export 'package:jbdev/utils/log.dart';
export 'package:jbdev/utils/navigation.dart' show jbNavigatorKey, setJbNavigatorKey;

export 'package:jbdev/extensions/context_extensions.dart';
export 'package:jbdev/extensions/color_extensions.dart';
export 'package:jbdev/extensions/date_time_extensions.dart';
export 'package:jbdev/extensions/num_extension.dart';
export 'package:jbdev/extensions/string_extensions.dart';
export 'package:jbdev/extensions/text_style_extension.dart';
export 'package:jbdev/extensions/widget_extensions.dart';
export 'package:jbdev/extensions/list_extension.dart';
export 'package:jbdev/extensions/object_extension.dart';

export 'package:jbdev/enums/jb_locale.dart';
export 'package:jbdev/enums/jb_timezone.dart';

export 'package:jbdev/models/jb_action.dart';
export 'package:jbdev/models/jb_popup.dart';
export 'package:jbdev/models/jb_button_properties.dart';

export 'package:jbdev/helpers/loading_popup_manager.dart';
export 'package:jbdev/helpers/jb_popup_manager.dart' show showJBPopup, hideJBPopup, hideJBAllPopups;
export 'package:jbdev/helpers/shared_preferences_manager.dart';

export 'package:jbdev/ui/widget/jb_button.dart';

export 'package:jbdev/app.dart' show App;

export 'package:dio/dio.dart' show FormData;
export 'package:jbdev/data/network/api.dart';
export 'package:jbdev/data/network/api_methods.dart';

TextTheme? get textThemes {
  final context = jbNavigatorKey.currentContext;
  if (context != null) {
    return Theme.of(context).textTheme;
  }
  return null;
}

ColorScheme? get colors {
  final context = jbNavigatorKey.currentContext;
  if (context != null) {
    return Theme.of(context).colorScheme;
  }
  return null;
}

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

BuildContext? get jbContext => jbNavigatorKey.currentContext;

class Jbdev extends StatelessWidget {
  final Widget Function(BuildContext context, GlobalKey<NavigatorState> navKey) builder;
  const Jbdev({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appNotifier,
      builder: (context, _, __) {
        return builder(context, jbNavigatorKey);
      },
    );
  }
}