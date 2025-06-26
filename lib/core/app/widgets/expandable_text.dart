import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_admin_app/core/extensions/context_extension.dart';
import 'package:ecommerce_admin_app/core/resources/colors.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({
    required this.text,
    required this.context,
    super.key,
  });

  final String text;
  final BuildContext context;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool expanded = false;

  late TextSpan textSpan;
  late TextPainter textPainter;

  @override
  void initState() {
    textSpan = TextSpan(
      text: widget.text,
    );

    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: expanded ? null : 2,
    )..layout(maxWidth: widget.context.width * .8);

    super.initState();

  }

  @override
  void dispose() {
    textPainter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const defaultStyle = TextStyle(
      color: Colours.grey600,
      height: 1.8,
      letterSpacing: 0.2,
      fontSize: 14,
    );
    return textPainter.didExceedMaxLines
        ? RichText(
            text: TextSpan(
              text: expanded
                  ? widget.text
                  : '${widget.text.substring(
                      0,
                      textPainter
                          .getPositionForOffset(Offset(
                            widget.context.width,
                            widget.context.height,
                          ),)
                          .offset,
                    )}...',
              style: defaultStyle,
              children: [
                TextSpan(
                  text: expanded ? ' See less' : 'See more',
                  style: const TextStyle(
                    color: Colours.primary,
                    fontSize: 14,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => setState(() {
                          expanded = !expanded;
                        }),
                ),
              ],
            ),
          )
        : Text(
            widget.text,
            style: defaultStyle,
          );
  }
}
