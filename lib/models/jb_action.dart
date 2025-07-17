import 'package:jbdev/models/jb_popup.dart';

class JBAction {
  String? label;
  String? url;
  Map<String, dynamic>? metadata;
  Function? onAction;
  JBPopup? popup;


  JBAction({
    this.label,
    this.url,
    this.metadata,
    this.onAction,
    this.popup
  });

  String? getButtonType(){
    return metadata?['button_type'] ?? metadata?['buttonType'];
  }

  factory JBAction.fromJson(Map<String, dynamic> json) {
    return JBAction(
      label: json['label'],
      url: json['url'],
      metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
      popup: json['popup'] != null ? JBPopup.fromJson(json['popup']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'url': url,
      'metadata': metadata,
      'popup': popup?.toJson(),
    };
  }

}
