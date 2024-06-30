import 'package:email_auth_firebase_app/core/helpers/extensions/assetss_widgets.dart';
import 'package:email_auth_firebase_app/views/widgets/main_text.dart';
import 'package:flutter/material.dart';

class MainTextField extends StatefulWidget {
  final String hint;
  final String? title;
  final String? label;
  final FontWeight? fontWeight;
  final Color? colorText;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final int maxLines;
  final String? init;
  final bool isDense;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final int? maxInputLength;
  final bool hideKeyboard;
  final OutlineInputBorder? border;
  final Color? filledColor;
  final Color? borderColor;
  final bool enable;
  final void Function(String value)? onSubmit;
  final bool unfocusWhenTapOutside;
  final void Function()? onTap;
  final void Function(String value)? onChanged;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final int radius;
  final bool readOnly;
  final bool obscureText;
  final double? hintFontSize;
  final FocusNode? focusNode;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  const MainTextField({
    super.key,
    this.hint = '',
    this.title,
    this.label,
    this.fontWeight,
    this.colorText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.init,
    this.maxInputLength,
    this.border,
    this.isDense = true,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 14,
    ),
    this.filledColor = Colors.white,
    this.suffix,
    this.onSubmit,
    this.enable = true,
    this.style,
    this.hideKeyboard = false,
    this.borderColor,
    this.suffixIcon,
    this.unfocusWhenTapOutside = false,
    this.onTap,
    this.onChanged,
    this.controller,
    this.validator,
    this.radius = 8,
    this.readOnly = false,
    this.obscureText = false,
    this.hintFontSize = 16,
    this.focusNode,
    this.prefix,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
  });

  @override
  State<MainTextField> createState() => MainTextFieldState();
}

class MainTextFieldState extends State<MainTextField> {
  TextEditingController controller = TextEditingController();

  @override
  void didUpdateWidget(MainTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller &&
        widget.controller != null) {
      controller = widget.controller!;
    }
  }

  @override
  void dispose() {
    if (mounted) {
      controller.dispose();
    }
    super.dispose();
  }

  bool isShow = false;
  onChange() {
    setState(() {
      isShow = !isShow;
    });
  }

  String? textError;
  setError(String? e) {
    setState(() {
      textError = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...{
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 9,
              right: 8,
            ),
            child: MainText.title(
              widget.title ?? '',
              fontSize: 13,
              color: Colors.black,
            ),
          ),
          2.hSize,
        },
        TextFormField(
          obscuringCharacter: '*',
          obscureText: (widget.obscureText && !isShow),
          controller: widget.controller,
          cursorHeight: 22.0,
          enabled: widget.enable,
          maxLines: widget.maxLines,
          maxLength: widget.maxInputLength,
          onFieldSubmitted: widget.onSubmit,
          keyboardType: widget.keyboardType,
          readOnly: widget.readOnly,
          initialValue: widget.init,
          style: widget.style ??
              const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          focusNode: widget.focusNode,
          onTapOutside: (event) {
            if (widget.unfocusWhenTapOutside) {
              FocusScope.of(context).requestFocus(FocusNode());
            }
          },
          validator: (value) {
            String? v = widget.validator?.call(value);
            setError(v);
            return v != null ? '' : null;
          },
          decoration: InputDecoration(
            isDense: widget.isDense,
            prefixIcon: widget.prefixIcon,
            prefixIconConstraints: widget.prefixIconConstraints,
            prefix: widget.prefix,
            suffix: widget.suffix,
            suffixIconConstraints: widget.suffixIconConstraints,
            contentPadding: widget.contentPadding,
            hintText: widget.hint.isNotEmpty ? widget.hint : null,
            labelText: widget.label,
            hintStyle:
                TextStyle(color: Colors.grey, fontSize: widget.hintFontSize),
            labelStyle: const TextStyle(color: Colors.black54, fontSize: 13),
            errorStyle: const TextStyle(fontSize: 0),
            border: _border(
              color: widget.borderColor ?? Colors.grey,
              radius: widget.radius,
            ),
            disabledBorder: _border(
              color: widget.borderColor ?? Colors.grey,
              radius: widget.radius,
            ),
            enabledBorder: _border(
              color: widget.borderColor ?? Colors.grey.withOpacity(0.3),
              radius: widget.radius,
            ),
            focusedBorder: _border(
              color: widget.borderColor ?? Colors.grey,
              radius: widget.radius,
            ),
            errorBorder: _border(
              color: Colors.redAccent,
              radius: widget.radius,
            ),
            fillColor: widget.filledColor ?? Colors.white,
            filled: true,
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      onChange();
                    },
                    icon:
                        Icon(isShow ? Icons.visibility : Icons.visibility_off))
                : widget.suffixIcon,
          ),
        ),
        if (textError != null)
          Padding(
            padding: 12.vhEdge,
            child: Row(
              children: [
                const Icon(
                  Icons.error_rounded,
                  color: Colors.red,
                  size: 17,
                ),
                8.sSize,
                Expanded(
                  child: MainText(
                    textError ?? '',
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  OutlineInputBorder _border({required Color color, int radius = 25}) {
    return widget.border == null
        ? OutlineInputBorder(
            borderRadius: radius.cBorder,
            borderSide: BorderSide(color: color),
          )
        : widget.border!.copyWith(borderSide: BorderSide(color: color));
  }
}
