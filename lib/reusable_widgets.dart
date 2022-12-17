import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

Widget formfield_for_email(String text,
    TextEditingController editingController) {
  return (Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: TextFormField(
          controller: editingController,
          autocorrect: true,
          decoration: InputDecoration(
            labelText: text,
            border: InputBorder.none,
          ),
          validator: MultiValidator([
            RequiredValidator(errorText: "Required"),
            EmailValidator(errorText: "Enter Valid Email")
          ]))));
}

Widget formfield_for_password(String text,
    TextEditingController editingController) {
  return (Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: TextFormField(
          obscureText: true,
          controller: editingController,
          autocorrect: true,
          decoration: InputDecoration(
            labelText: text,
            border: InputBorder.none,
          ),
          validator: MultiValidator([
            RequiredValidator(errorText: "Required"),
            MinLengthValidator(6, errorText: "Minimum length 6")
          ]))));
}

Widget formfield_for_name(String text,TextEditingController editingController) {
  return (Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: TextFormField(
          controller: editingController,
          autocorrect: true,
          decoration: InputDecoration(
            labelText: text,
            border: InputBorder.none,
          ),
          validator: RequiredValidator(errorText: "Required"))));
}

Widget google_sign_in_buttons() {
  return (
      ElevatedButton(
        onPressed: () {},
        style: const ButtonStyle(
            shape: MaterialStatePropertyAll(CircleBorder()),
            backgroundColor:
            MaterialStatePropertyAll(Colors.white)),
        child: Image.asset(
          "assets/images/google_logo.png",
          width: 50,
          height: 50,
        ),
      )
  );
}

Widget facebook_sign_in_button() {
  return (ElevatedButton(
    onPressed: () {},
    style: const ButtonStyle(
        shape: MaterialStatePropertyAll(CircleBorder()),
        backgroundColor:
        MaterialStatePropertyAll(Colors.white)),
    child: Image.asset(
      "assets/images/fb_logo.png",
      width: 50,
      height: 50,
    ),
  ));
}
