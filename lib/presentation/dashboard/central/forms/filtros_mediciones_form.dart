import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:adasba_2024/constants/app_colors.dart';

class FiltrosMedicionesForm extends StatefulWidget {
  const FiltrosMedicionesForm({super.key});

  @override
  State<FiltrosMedicionesForm> createState() => _FiltrosMedicionesFormState();
}

class _FiltrosMedicionesFormState extends State<FiltrosMedicionesForm> {
  final DateTime hasta = DateTime.now();
  late DateTime desde;
  final TextEditingController _fechaDesde = TextEditingController();
  final TextEditingController _fechaHasta = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? _selectedProyecto;
  //Listado para el dropdown PROVISIONAL
  List<DropdownMenuItem<int>> listadoProvisional = const [
    DropdownMenuItem(
      value: 1,
      child: Text('Proyecto 1'),
    ),
    DropdownMenuItem(
      value: 2,
      child: Text('Proyecto 2'),
    ),
    DropdownMenuItem(
      value: 3,
      child: Text('Proyecto 3'),
    ),
    DropdownMenuItem(
      value: 4,
      child: Text('Proyecto 4'),
    ),
  ];

  //Estilo de los labels
  TextStyle estiloLabels = GoogleFonts.roboto(
    color: Colors.black54,
    fontWeight: FontWeight.w700,
  );

  @override
  void initState() {
    super.initState();
    desde = DateTime(hasta.year - 2, hasta.month, hasta.day);
    _fechaDesde.text = desde.toString().substring(0, 10);
    _fechaHasta.text = hasta.toString().substring(0, 10);
  }

  @override
  void dispose() {
    _fechaDesde.dispose();
    _fechaHasta.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Proyectos',
            style: estiloLabels,
          ),
          const Gap(8),
          DropdownButtonFormField<int>(
            value: _selectedProyecto,
            isExpanded: true,
            items: listadoProvisional,
            decoration: InputDecoration(
              labelText: 'Proyectos',
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
            onChanged: (v) {
              if (v != null) {
                setState(() => _selectedProyecto = v);
              }
            },
            validator: (value) {
              if (value == null) {
                return 'Campo obligatorio';
              }

              return null;
            },
          ),
          const Gap(15),
          Text(
            'Fecha desde',
            style: estiloLabels,
          ),
          const Gap(8),
          TextFormField(
            controller: _fechaDesde,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () async {
                  showDatePicker(
                    context: context,
                    locale: const Locale('es'),
                    currentDate: desde,
                    firstDate: DateTime(hasta.year - 5, hasta.month, hasta.day),
                    lastDate: hasta,
                  ).then((value) {
                    if (value != null) {
                      _fechaDesde.text = value.toString().substring(0, 10);
                    }
                  });
                },
                icon: const Icon(
                  Icons.calendar_month,
                ),
              ),
              labelText: 'Fecha inicial',
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
            validator: (value) {
              if (value == null || value == '') {
                return 'Campo obligatorio';
              }

              if (value.length < 10) {
                return 'ingrese una fecha válida';
              }

              return null;
            },
          ),
          const Gap(15),
          Text(
            'Fecha hasta',
            style: estiloLabels,
          ),
          const Gap(8),
          TextFormField(
            controller: _fechaHasta,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () async {
                  showDatePicker(
                    context: context,
                    locale: const Locale('es'),
                    currentDate: hasta,
                    firstDate: DateTime(hasta.year - 5, hasta.month, hasta.day),
                    lastDate: hasta,
                  ).then((value) {
                    if (value != null) {
                      _fechaDesde.text = value.toString().substring(0, 10);
                    }
                  });
                },
                icon: const Icon(
                  Icons.calendar_month,
                ),
              ),
              labelText: 'Fecha final',
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
            validator: (value) {
              if (value == null || value == '') {
                return 'Campo obligatorio';
              }

              if (value.length < 10) {
                return 'ingrese una fecha válida';
              }

              return null;
            },
          ),
          const Gap(15),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.rojoPrincipal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Filtrar',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
