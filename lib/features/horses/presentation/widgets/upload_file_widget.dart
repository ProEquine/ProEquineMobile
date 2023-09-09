import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';

class UploadFileWidget extends StatefulWidget {
  Function onPressUpload;
  String? title;

  UploadFileWidget({Key? key, required this.onPressUpload, this.title})
      : super(key: key);

  @override
  State<UploadFileWidget> createState() => _UploadFileWidgetState();
}

class _UploadFileWidgetState extends State<UploadFileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.zero,
      decoration: ShapeDecoration(
        color: const Color(0xFFF9FAFB),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.50,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Color(0xFFDFD9C9),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 39,
              clipBehavior: Clip.antiAlias,
              decoration: const ShapeDecoration(
                  color: Color(0xFFDFD9C9),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.50,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0xFFDFD9C9),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  )),
              margin: EdgeInsets.zero,
              child: MaterialButton(
                color: Color(0xFFDFD9C9),
                onPressed: () {
                  setState(() {
                    widget.onPressUpload();
                  });
                },
                child: Text("Upload"),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                  width: 150,
                  child: Text(

                    widget.title!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.blackLight,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
