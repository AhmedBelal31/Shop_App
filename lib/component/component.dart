import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../style/color.dart';

void NavigateAndRep(context, widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void NavigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

Widget defaultForm({
  required TextEditingController controller,
  required TextInputType type,
  Function? onsubmit,
  Function? onchange,
  Function? onTap,
  dynamic Validator,
  required String text,
  required IconData prefixIcon,
  IconData? suffixIcon,
  bool isSecure = false,
}) =>
    TextFormField(
      keyboardType: type,
      controller: controller,
      onFieldSubmitted: (value) {
        onsubmit!(value);
      },
      validator: Validator,
      onChanged: (Value) {
        onchange!(Value);
      },
      obscureText: isSecure,
      decoration: InputDecoration(
        labelText: text,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(
            onPressed: () {
              onTap!();
            },
            icon: Icon(suffixIcon)),
      ),
    );

Widget DefaultButton({
  required String text,
  required Function onpress,
}) =>
    Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: defaultColor,
      ),
      child: MaterialButton(
        onPressed: () {
          onpress();
        },
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required Function onpress,
  required String text,
}) =>
    TextButton(
        onPressed: () {
          onpress();
        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ));

void showToast({required String msg}) => Fluttertoast.showToast(
    msg: msg,
    // toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 14.0);

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20, top: 10, bottom: 10),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[700],
      ),
    );
