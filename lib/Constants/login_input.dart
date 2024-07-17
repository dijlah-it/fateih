import 'package:fateih/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/gradient_borders.dart';

bool showPassword = true;

class LoginInput extends StatefulWidget {
  final String labelText;
  final int minLength;
  final int maxLength;
  final String isEmptyTitle;
  final TextInputType inputType;
  final TextEditingController controller;
  final bool isPassWord;
  const LoginInput({
    super.key,
    required this.labelText,
    required this.inputType,
    required this.isEmptyTitle,
    required this.minLength,
    required this.maxLength,
    required this.controller,
    required this.isPassWord,
  });

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter>? _inputFormatters;
    if (widget.inputType == TextInputType.number) {
      _inputFormatters = [FilteringTextInputFormatter.digitsOnly];
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return widget.isEmptyTitle;
          } else if (value.length < widget.minLength) {
            return 'يرجى ادخال المعلومات بشكل صحيح';
          } else if (value.length > widget.maxLength) {
            return 'يرجى ادخال المعلومات بشكل صحيح';
          }
          return null;
        },
        controller: widget.controller,
        keyboardType: widget.inputType,
        inputFormatters: _inputFormatters,
        // obscureText: widget.isPassWord,
        obscureText:
            widget.isPassWord == true ? showPassword : widget.isPassWord,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          labelText: widget.labelText,
          suffixIcon: widget.isPassWord
              ? IconButton(
                  icon: Icon(
                    !showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  color: Colors.white70,
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                )
              : SizedBox(),
          border: const GradientOutlineInputBorder(
            gradient: Constants.appGradient,
            width: 1,
          ),
          labelStyle: const TextStyle(
            color: Constants.themeColor,
          ),
        ),
      ),
    );
  }
}
