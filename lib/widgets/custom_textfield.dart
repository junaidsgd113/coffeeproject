import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomWidgets {
  static Widget textField(
      {
      bool isNumber = false,
      int ?length,
      required String labeltext,
      required  TextStyle hintstyle,
      required  TextStyle textStyle,
      TextEditingController? textController,
      TextInputType? keyboard,
      int lines = 1}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6,),

      child: TextFormField(
        maxLines: lines,
        controller: textController,
        maxLength: length,
        inputFormatters: [
          LengthLimitingTextInputFormatter(length),
        ],
        style:textStyle ,
        keyboardType:keyboard ,
        decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue)),
                
                  labelText: labeltext, 
                  
        )),
    );
  }
}