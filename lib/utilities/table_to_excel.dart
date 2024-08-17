import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class CreateExcel {
  static Future<String> tableToExcel(List<List<String>> rows) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    CellStyle headerCellStyle = CellStyle(
      textWrapping: TextWrapping.WrapText,
      fontFamily: getFontFamily(FontFamily.Calibri),
      bold: true,
    );

    CellStyle bodyCellStyle = CellStyle(
      textWrapping: TextWrapping.WrapText,
      fontFamily: getFontFamily(FontFamily.Calibri),
    );

    // Iterar sobre los rows
    for (int rowIndex = 0; rowIndex < rows.length; rowIndex++) {
      List<String> row = rows[rowIndex];
      List<CellValue> cellRow = row.map((cell) {
        return TextCellValue(cell);
      }).toList();

      // Agregar la fila a la hoja de Excel
      sheetObject.appendRow(cellRow);

      // Aplicar estilos a cada celda
      for (int cellIndex = 0; cellIndex < cellRow.length; cellIndex++) {
        var cell = sheetObject.cell(CellIndex.indexByColumnRow(
            columnIndex: cellIndex, rowIndex: rowIndex));
        if (rowIndex == 0) {
          // Aplicar headerCellStyle a la primera fila
          cell.cellStyle = headerCellStyle;
        } else {
          // Aplicar bodyCellStyle al resto de las filas
          cell.cellStyle = bodyCellStyle;
        }
      }
    }

    return await saveExcel(excel);
  }

  static Future<String> saveExcel(Excel excel) async {
    String returnStringMessage = 'success';
    if (kIsWeb) {
      try {
        DateTime now = DateTime.now();
        String nombreArchivo =
            'tabla_${now.year}_${now.month}_${now.day}_${now.microsecondsSinceEpoch}';
        excel.save(fileName: '$nombreArchivo.xlsx');
      } catch (e) {
        return 'error';
      }
    } else {
      try {
        List<int>? fileBytes = excel.encode();
        Uint8List uint8ListBytes = Uint8List.fromList(fileBytes!);
        DateTime now = DateTime.now();

        // Obtener el directorio temporal
        Directory tempDir = await getTemporaryDirectory();
        String directorioNombreArchivo =
            '${tempDir.path}tabla_${now.year}_${now.month}_${now.day}_${now.millisecondsSinceEpoch}.xlsx';

        // Crear un archivo temporal
        File tempFile = File(directorioNombreArchivo);
        await tempFile.writeAsBytes(uint8ListBytes);

        // Crear un XFile desde el archivo temporal
        XFile xFile = XFile(tempFile.path);

        await Share.shareXFiles([xFile], text: 'Mi tabla de excel');
      } catch (e) {
        return 'error';
      }
    }
    return returnStringMessage;
  }
}
