import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:adasba_2024/constants/app_colors.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    super.key,
    required this.label,
    required this.controlador,
    this.isRequired = false,
    this.isEmail = false,
    this.isPassword = false,
    this.iconito,
    this.isTextArea = false,
  });

  final TextEditingController controlador;
  final String label;
  final bool isRequired;
  final bool isEmail;
  final bool isPassword;
  final IconData? iconito;
  final bool isTextArea;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool isObscure = true;

  void setObscurity() {
    setState(() => isObscure = !isObscure);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controlador,
      obscureText: widget.isPassword ? isObscure : false,
      maxLines: widget.isTextArea ? 4 : 1,
      decoration: InputDecoration(
        alignLabelWithHint: widget.isTextArea ? true : false,
        suffixIcon: widget.iconito != null
            ? Icon(widget.iconito)
            : widget.isPassword
                ? isObscure
                    ? IconButton(
                        onPressed: setObscurity,
                        icon: const Icon(Icons.visibility),
                      )
                    : IconButton(
                        onPressed: setObscurity,
                        icon: const Icon(Icons.visibility_off),
                      )
                : null,
        labelText: widget.label,
        labelStyle: GoogleFonts.roboto(
          color: const Color(0xFF7E828E),
          fontSize: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.azulPrincipal,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: widget.isRequired
          ? (value) {
              if (value == null || value == '') {
                return 'Campo obligatorio';
              }

              return null;
            }
          : widget.isEmail
              ? (value) {
                  if (value == null || value == '') {
                    return 'Campo obligatorio';
                  }

                  if (!EmailValidator.validate(value)) {
                    return 'Ingrese un correo válido';
                  }

                  return null;
                }
              : null,
    );
  }
}
