import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:adasba_2024/constants/app_colors.dart';

class MultiSelectCustomInput extends StatefulWidget {
  const MultiSelectCustomInput(
      {required this.selectedValues,
      required this.listado,
      required this.label,
      this.isRequired = false,
      this.iconito,
      super.key});
  final List<Object?> selectedValues;
  final List<MultiSelectItem<Object?>> listado;
  final String label;
  final bool isRequired;
  final IconData? iconito;

  @override
  State<MultiSelectCustomInput> createState() => _MultiSelectCustomInputState();
}

class _MultiSelectCustomInputState extends State<MultiSelectCustomInput> {
  bool _isvalidated = true;

  @override
  Widget build(BuildContext context) {
    return MultiSelectDialogField(
      initialValue: widget.selectedValues,
      items: widget.listado,
      cancelText: const Text('Cancelar'),
      confirmText: const Text('Aceptar'),
      title: const Text("Seleccionar los que apliquen"),
      selectedColor: AppColors.azulPrincipal,
      backgroundColor: Colors.white,
      dialogWidth: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: _isvalidated ? 0.5 : 1.0,
          color: _isvalidated ? Colors.black12 : Colors.red,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      buttonIcon: widget.iconito != null
          ? Icon(
              widget.iconito,
            )
          : null,
      buttonText: Text(
        widget.label,
        style: GoogleFonts.roboto(
          color: const Color(0xFF7E828E),
          fontSize: 14,
        ),
      ),
      onConfirm: (values) {
        if (values.isNotEmpty) {
          widget.selectedValues.clear();
          for (var element in values) {
            widget.selectedValues.add(element);
          }
        }
      },
      validator: widget.isRequired
          ? (value) {
              if (value == null || value.isEmpty) {
                setState(() => _isvalidated = false);

                return 'Campo obligatorio';
              }
              setState(() => _isvalidated = true);
              return null;
            }
          : null,
    );
  }
}
