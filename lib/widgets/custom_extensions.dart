import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';
   
extension CustomDate on DateTime{
  String customDateFormate(){

return DateFormat.yMMM().format(this);
  }
}
extension CustomTimestampDate on Timestamp{
  String customFormattedDate({DateTime ? dateTime}){
    DateTime date=dateTime ?? this.toDate();

return DateFormat('MMMM yyyy').format(date);
  }
  
}
