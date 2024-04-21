import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog extends StatelessWidget {
  final String heading;
  final String description;
  final Widget? body;
  final String? textForYes;
  final String? textForNo;
  final bool showNo;

  const CustomDialog({
    required this.heading,
    required this.description,
    this.textForYes,
    this.textForNo,
    this.body,
    this.showNo = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        heading,
        style: TextStyle(
          fontSize:18.sp,
          fontWeight:FontWeight.w800,
          color:Colors.black,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            description,
            style: TextStyle(
              fontSize:14.sp,
              color:Colors.black,
            ),
          ),
          body??const SizedBox(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(
            textForYes ?? "Yes",
          ),
        ),
        if (showNo)
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(
              textForNo ?? "No",
            ),
          ),
      ],
    );
  }
}
