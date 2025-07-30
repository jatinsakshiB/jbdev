import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:jbdev/jbdev.dart';

class JBBottomSheetWidget extends StatelessWidget {
  final JBPopup popup;
  const JBBottomSheetWidget({super.key, required this.popup});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!popup.image.isNullOrEmpty)
            Image.network(
              popup.image!,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ).withRoundedCorners(20).withPaddingAll(8),
          16.heightBox,
          if (!popup.title.isNullOrEmpty)
            Text(
              popup.title!,
              style: context.textThemes.titleMedium,
            ).withWidth(double.infinity).withSymmetricPadding(horizontal: 16),
          12.heightBox,

          if (!popup.content.isNullOrEmpty)
            Material(
              color: Colors.transparent,
              child: Html(
                data: popup.content,
              ).withWidth(double.infinity).withSymmetricPadding(horizontal: 16),
            ),

          if (popup.contentBuilder != null)
            popup.contentBuilder!(context).withTopPadding(12),

          26.heightBox,
          GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: popup.actions.length == 2 ? 2 : 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 44),
            physics: const NeverScrollableScrollPhysics(),
            children: (popup.actions).map((action) {
              return JBButton(
                text: action.label ?? "",
                onPressed: () {
                  if (action.url != "pop"){
                    hideJBPopup(popup.id);
                  }
                  context.launchAction(action);
                },
                type: action.getButtonType(),
              );
            }).toList(),
          ).withSymmetricPadding(horizontal: 16),
          if (popup.actions.isNotEmpty) 16.heightBox,
        ],
      ),
    );
  }
}
