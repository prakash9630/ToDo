
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


extension PaddingExt on num{
  Widget get verticalSpace => SizedBox(height: toDouble().h,);
  Widget get horizontalSpace => SizedBox(width: toDouble().w,);
}
