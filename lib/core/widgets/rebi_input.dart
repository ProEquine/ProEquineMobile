import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors/app_colors.dart';

class RebiInput extends StatefulWidget {
  const RebiInput({
    Key? key,
    this.radius = 10.0,
    this.background = AppColors.formsBackground,
    this.color = AppColors.formsHintFont,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.onSave,
    this.onFieldSubmitted,
    this.onChanged,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.initialValue,
    this.textAlign = TextAlign.start,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 13.0, horizontal: 4.0),
    this.scrollPadding=const EdgeInsets.only(bottom: 40),
    this.borderSide =
        const BorderSide(color: AppColors.backgroundColor, width: 0.0),
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.inputFormatters,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.isOptional = false,
    this.isItDisable=false,
    this.autofocus = false,
    this.hintStyle,
  }) : super(key: key);

  final double radius;
  final Color? background;
  final Color color;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final FormFieldSetter<String>? onSave;
  final FormFieldSetter<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onChanged;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? initialValue;
  final TextAlign textAlign;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsets scrollPadding;
  final BorderSide borderSide;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autoValidateMode;
  final bool isOptional;
  final bool autofocus;
  final bool isItDisable;
  final TextStyle? hintStyle;

  @override
  State<RebiInput> createState() => _RebiInputState();
}

class _RebiInputState extends State<RebiInput> {
  late bool showPassword;
  final TextEditingController _controller = TextEditingController();
  late FocusNode focusNode = FocusNode()
    ..addListener(() {
      setState(() {});
    });

  @override
  void initState() {
    showPassword = widget.obscureText;
    if (widget.initialValue != null && widget.initialValue != 'null') {
      _controller.text = widget.initialValue!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          scrollPadding: widget.scrollPadding,
          focusNode: focusNode,
          autofocus: widget.autofocus,
          enableSuggestions: false,
          cursorColor: AppColors.white,
          autocorrect: false,
          controller: widget.controller ?? _controller,
          textAlign: widget.textAlign,
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscuringCharacter: '*',
          style: const TextStyle(
            color: AppColors.white,
            fontFamily: "notosan",
            // fontFamily: AppStyles.montserrat,
            decoration: TextDecoration.none,

            ///todo
          ),
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          onChanged: (value) {
            if (widget.onChanged == null) {
              return;
            }
            widget.onChanged!(value);
          },
          onFieldSubmitted: (value) {
            if (widget.onFieldSubmitted == null) {
              return;
            }
            widget.onFieldSubmitted!(value);
          },
          onTap: () {
            if (widget.onTap == null) {
              return;
            }
            widget.onTap!();
          },
          onSaved: (newValue) {
            if (widget.onSave == null) {
              return;
            }
            widget.onSave!(newValue);
          },
          validator: (value) {
            return widget.validator(value);
          },
          autovalidateMode: widget.autoValidateMode,
          obscureText: showPassword,
          decoration: InputDecoration(
            labelText: widget.labelText,

            errorStyle: const TextStyle(color: AppColors.red,fontSize: 11,height: 1.0,fontFamily: 'notosan'),
            errorMaxLines: 4,
            errorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.red, width: 1.0),
              borderRadius: BorderRadius.circular(10.0,),
            ),

            isDense: true,
            iconColor: AppColors.white,
            prefixIconColor: AppColors.formsHintFont,
            suffixIconColor: AppColors.formsHintFont,
            contentPadding: widget.contentPadding,
            prefixIcon: widget.prefixIcon != null
                ? IconButton(
                    onPressed: null,
                    icon: widget.prefixIcon!,
                  )
                : null,

            suffixIcon: _buildSuffixWidget(),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide:
               BorderSide(color: AppColors.red, width: 1.0),),
            focusedBorder: OutlineInputBorder(
              borderSide:  BorderSide(color:widget.isItDisable?AppColors.grey:AppColors.gold, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
              borderSide: widget.borderSide,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
              borderSide: widget.borderSide,
            ),
            fillColor: widget.background,
            filled: true,
            alignLabelWithHint: true,
            labelStyle: TextStyle(
              fontSize: 12.0,
              fontFamily: "notosan",
              fontWeight: FontWeight.w400,
              color: widget.color,
            ),
            hintStyle: widget.hintStyle ??
                const TextStyle(
                  fontFamily: "notosan",
                  fontSize: 14.0,
                  color: AppColors.formsLabel,
                ),
            hintText: widget.hintText,
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixWidget() {
    if (widget.suffixIcon != null) {
      return IconButton(onPressed: null, icon: widget.suffixIcon!);
    } else {
      return widget.obscureText
          ? IconButton(
              focusNode: FocusNode(skipTraversal: false),
              icon: showPassword
                  ? const Icon(
                      CupertinoIcons.eye,
                      color: AppColors.white,
                      size: 20.0,
                    )
                  : const Icon(
                      CupertinoIcons.eye_slash,
                      color: AppColors.white,
                      size: 20.0,
                    ),
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
            )
          : null;
    }
  }
}
