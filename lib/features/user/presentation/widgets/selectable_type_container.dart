import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';

class SelectableTypeContainer extends StatefulWidget {
  final String? label;

  final int? index;
  final bool isSelected;
  final Function(bool) onSelected;

  const SelectableTypeContainer({
    super.key,
    required this.label,
    required this.index,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  State<SelectableTypeContainer> createState() =>
      _SelectableTypeContainerState();
}

class _SelectableTypeContainerState extends State<SelectableTypeContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onSelected(true);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: widget.isSelected
                ? const Color(0xFFC48737).withOpacity(0.3)
                : AppColors.backgroundColor, //here i want to add opacity

            border: Border.all(
              color:
                  widget.isSelected ? const Color(0xFFC48737) : AppColors.grey,
            ),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.5),
                topRight: Radius.circular(20.5),
                bottomLeft: Radius.circular(20.5),
                bottomRight: Radius.circular(20.5))),
        child: Center(
          child: Text(
            widget.label!,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              fontFamily: "notosan",
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
