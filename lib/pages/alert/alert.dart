import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class WidgetAlertError{
static Widget Alerts(BuildContext context,String errorMessage,String title){
  Alert(
    context: context,
    type: AlertType.error,
    title:title,
    desc:errorMessage,
    buttons: [
      DialogButton(
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: ()=>Navigator.pop(context),
        width:120,
      )
    ],
  ).show();
}
}