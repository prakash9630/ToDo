
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/const/app_colors.dart';
import 'package:todo/const/app_string.dart';
import '../../common/text_style.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({Key? key,required this.status}) : super(key: key);
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(vertical: 4.h,horizontal: 10.w),
      decoration: BoxDecoration(
        color: status==AppString.uncompleted?AppColors.red:status==AppString.inProcess?AppColors.appColor:Colors.green,
        borderRadius: BorderRadius.circular(100.r)
      ),
      child: Text(status,style:w4f11(AppColors.white),),
    );
  }
}
