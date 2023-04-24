import 'package:flutter/material.dart';
import 'package:proequine/features/profile/presentation/widgets/profile_divider.dart';
import '../../../../core/constants/colors/app_colors.dart';

class DropDownWidget extends StatefulWidget {
  late List<DropdownMenuItem>? items;
  late String? selected;
  final String? hint;
  final FormFieldValidator<String> validator;
  final BorderSide borderSide;

  DropDownWidget({
    super.key,
    this.selected,
    this.items,
    required this.validator,
    this.hint,
    this.borderSide =
        const BorderSide(color: AppColors.backgroundColor, width: 0.0),
  });

  @override
  DropDownWidgetState createState() => DropDownWidgetState();
}

class DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FormField<String>(
        validator: (value) {
          return widget.validator(value);
        },
        autovalidateMode: AutovalidateMode.disabled,
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              fillColor: AppColors.formsBackground,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.gold, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: widget.borderSide,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: widget.borderSide,
              ),
              errorStyle: const TextStyle(color: AppColors.darkRed),
              errorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.darkRed, width: 1.0),
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                underline: ProfileDivider(),
                dropdownColor: AppColors.formsBackground,
                elevation: 2,
                borderRadius: BorderRadius.circular(10),
                style: const TextStyle(
                  color: AppColors.white,
                  fontFamily: "notosan",
                  decoration: TextDecoration.none,
                ),
                hint: Text(
                  widget.hint!,
                  style: const TextStyle(
                    fontFamily: "notosan",
                    fontSize: 16.0,
                    color: AppColors.formsLabel,
                  ),
                ),
                items: widget.items?.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem(
                    value: value.value,
                    child: Text(value.value!),
                    // // SizedBox(height: 10,),
                    // ProfileDivider(),
                  );
                }).toList(),
                isExpanded: true,
                isDense: true,
                onChanged: (String? newSelectedBank) {
                  setState(() {
                    widget.selected = newSelectedBank;
                  });
                },
                value: widget.selected,
              ),
            ),
          );
        },
      ),
    );
  }
}
