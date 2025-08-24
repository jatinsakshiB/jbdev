import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jbdev/jbdev.dart';


class JBText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final void Function(String? text)? onTap;

  const JBText(
      this.text, {
        super.key,
        this.style,
        this.textAlign,
        this.onTap,
      });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = style ?? DefaultTextStyle.of(context).style;
    final tokens = JBTokenizer(text).tokenize();
    return Text.rich(
      _parseTokens(tokens, defaultStyle),
      textAlign: textAlign,
    );
  }

  TextSpan _parseTokens(List<JBToken> tokens, TextStyle baseStyle, {GestureRecognizer? recognize}) {
    final spans = <InlineSpan>[];
    for (final token in tokens) {
      switch (token) {
        case JBTextToken(:final value):
          spans.add(TextSpan(text: value, style: baseStyle, recognizer: recognize));
          break;

        case JBStyleToken(:final styleModifier, :final children):
          final newStyle = styleModifier(baseStyle);
          spans.add(_parseTokens(children, newStyle, recognize: recognize));
          break;

        case JBClickableToken(:final children, :final action):
          spans.add(
            _parseTokens(children, baseStyle, recognize: onTap != null
                ? (TapGestureRecognizer()
              ..onTap = () => onTap!(action))
                : null),
          );
          break;
      }
    }
    return TextSpan(children: spans, style: baseStyle);
  }
}

// ===== Token Definitions =====

sealed class JBToken {
  String get rawText;
}

class JBTextToken extends JBToken {
  final String value;
  JBTextToken(this.value);
  @override
  String get rawText => value;
}

class JBStyleToken extends JBToken {
  final List<JBToken> children;
  final TextStyle Function(TextStyle) styleModifier;
  JBStyleToken(this.children, this.styleModifier);
  @override
  String get rawText => children.map((e) => e.rawText).join();
}

class JBClickableToken extends JBToken {
  final List<JBToken> children;
  final String action;
  JBClickableToken(this.children, this.action);
  @override
  String get rawText => children.map((e) => e.rawText).join();
}

// ===== Tokenizer =====

class JBTokenizer {
  final String input;
  int index = 0;

  JBTokenizer(this.input);

  List<JBToken> tokenize() => _parseUntil(() => false);

  List<JBToken> _parseUntil(bool Function() endCondition) {
    final tokens = <JBToken>[];

    while (index < input.length && !endCondition()) {
      if (input.startsWith('**', index)) {
        index += 2;
        final children = _parseUntil(() => input.startsWith('**', index));
        index += 2;
        tokens.add(JBStyleToken(children, (s) => s.bold));
      } else if (input.startsWith('~~', index)) {
        index += 2;
        final children = _parseUntil(() => input.startsWith('~~', index));
        index += 2;
        tokens.add(JBStyleToken(children, (s) => s.lineThrough));
      } else if (input.startsWith('__', index)) {
        index += 2;
        final children = _parseUntil(() => input.startsWith('__', index));
        index += 2;
        tokens.add(JBStyleToken(children, (s) => s.underline));
      } else if (input.startsWith('@[', index)) {
        index += 2;
        final buffer = StringBuffer();
        while (index < input.length && input[index] != ']') {
          buffer.write(input[index]);
          index++;
        }
        index++;
        var action = buffer.toString();
        List<JBToken> children = buffer.isNotEmpty ? [JBTextToken(action)] : [];
        if (input[index] == "("){
          index++;
          final actionTextBuffer = StringBuffer();
          while (index < input.length && input[index] != ')') {
            actionTextBuffer.write(input[index]);
            index++;
          }
          index++;
          action = actionTextBuffer.toString();
        }
        tokens.add(JBClickableToken(children, action));
      } else if (input.startsWith('{#', index)) {
        index += 2;
        final colorEnd = input.indexOf('|', index);
        final colorHex = input.substring(index, colorEnd);
        index = colorEnd + 1;
        final children = _parseUntil(() => input.startsWith('}', index));
        index++;
        final color = HexColor.fromHex(colorHex);
        tokens.add(JBStyleToken(children, (s) => s.c(color)));
      } else {
        final buffer = StringBuffer();
        while (index < input.length && !_isSpecialStart()) {
          buffer.write(input[index]);
          index++;
        }
        if (buffer.isNotEmpty) tokens.add(JBTextToken(buffer.toString()));
      }
    }

    return tokens;
  }

  bool _isSpecialStart() {
    return input.startsWith('**', index) ||
        input.startsWith('~~', index) ||
        input.startsWith('__', index) ||
        input.startsWith('@[', index) ||
        input.startsWith('{#', index);
  }

}
