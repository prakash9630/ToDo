
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/components/customtextfield.dart';
import 'package:todo/const/app_colors.dart';


class CustomCalenderDatePicker extends StatefulWidget {
  const CustomCalenderDatePicker({Key? key,required this.dateCon,required this.labelText,this.showRequired=false,this.hintText,this.validator}) : super(key: key);
  final TextEditingController dateCon;
  final String labelText;
  final String? hintText;
  final Function(String?)? validator;
  final bool showRequired;

  @override
  State<CustomCalenderDatePicker> createState() => _CustomCalenderDatePickerState();
}

class _CustomCalenderDatePickerState extends State<CustomCalenderDatePicker> {

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
    onTap: ()=> pickDate(convertedDate(widget.dateCon.text)),
    controller: widget.dateCon,
    readOnly: true,
    showRequired: widget.showRequired,
    keyboardType: TextInputType.number,
    hintText: widget.hintText,
    labelText: widget.labelText,
    suffixIcon:  const Icon(Icons.calendar_month, color: AppColors.appColor,),
    validator: (value) {
      if(widget.validator!=null){
       return widget.validator!(value);
      }
      if(widget.showRequired){
        return value == null || value.isEmpty ? 'Date cannot be empty.' : null;
      }else {
        return null;
      }
    },
        );
  }
  pickDate(initialDate) async{
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: DateTime(DateTime.now().year), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(3000),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.red.withOpacity(0.9), //Background color
                onSurface: AppColors.black, //UnSelected Date Font Color
              ),
            ),
            child: child!,
          );
        },
      );
      //Formatt date
      if(pickedDate != null ){
        //Formatted Eng Date
        var englishDateTime = DateTime(pickedDate.year, pickedDate.month, pickedDate.day).toString();
        widget.dateCon.text = DateFormat('yyyy-MM-dd').format((DateTime.parse(englishDateTime))).toString();
      }
  }

  convertedDate(date){
    if(date != null && date != ""){
      var splitDate = date.toString().split("-");
      var convertedDate = DateTime(int.parse(splitDate[0]), int.parse(splitDate[1]), int.parse(splitDate[2]));
      return convertedDate;
    } else{
      return null;
    }
  }
}
