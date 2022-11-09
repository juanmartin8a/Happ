import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController;
  const PasswordField({
    required this.passwordController,
    required Key key
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {

  bool isPasswordVisible = false;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 45,
      child: TextField(
        // expands: true,
        // maxLines: 1,
        obscureText: !isPasswordVisible,
        controller: widget.passwordController,
        textInputAction: TextInputAction.done,
        cursorColor:const Color(0xff00ff03),
        textAlignVertical: TextAlignVertical.center,
        // textAlign: TextAlign.center,
        keyboardAppearance: Brightness.dark,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.25
        ),
        
        decoration: InputDecoration(
          isCollapsed: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[900]!, width: 2),
            // borderRadius: BorderRadius.circular(12.5),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff00ff03), width: 2),
            // borderRadius: BorderRadius.circular(12.5),
          ),
          contentPadding: EdgeInsets.zero,
          hintText: 'Password',
          hintStyle: TextStyle(
            color: Colors.grey[800],
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.25
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              if (isPasswordVisible == false) {
                setState(() {
                  isPasswordVisible = true;
                });
              } else {
                setState(() {
                  isPasswordVisible = false;
                });
              }
            },
            child: isPasswordVisible
              ? Icon(
                EvaIcons.eyeOutline,
                color: Colors.grey[200]
              )
              : Icon(
                EvaIcons.eyeOffOutline,
                color: Colors.grey[800]
              )
          )
        ),
      ),
    );
  }
}