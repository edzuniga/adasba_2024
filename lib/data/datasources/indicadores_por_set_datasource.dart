import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:adasba_2024/constants/api_routes.dart';
import 'package:adasba_2024/data/models/indicadores_por_set_model.dart';
import 'package:adasba_2024/domain/entities/indicadores_por_set.dart';
import 'package:adasba_2024/utilities/local_storage.dart';

abstract class IndicadoresPorSetDataSource {
  Future<List<IndicadoresPorSet>> getAllIndicadoresPorIdSet(int idSet);
  Future<void> addIndicadoresPorSet(IndicadoresPorSet indicadoresPorSet);
  Future<void> deleteIndicadoresPorSet(int id);
}

class RemoteIndicadoresPorSetDataSource implements IndicadoresPorSetDataSource {
  @override
  Future<String> addIndicadoresPorSet(
      IndicadoresPorSet indicadoresPorSet) async {
    //Obtener las variables necesarias del storage
    final storage = LocalStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de componenteModel a partir de componente
    IndicadoresPorSetModel model =
        IndicadoresPorSetModel.fromIndicadoresPorSet(indicadoresPorSet);

    Map<String, dynamic> cuerpo = model.toJson();
    try {
      //!TODO: después cambiarlas a https
      var url = Uri.http(ApiRoutes.urlApi, ApiRoutes.addIndicadoresPorSetRoute);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken.toString(),
        },
        body: jsonEncode(cuerpo),
      );

      final receivedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return 'success';
      }
      throw receivedData['messages'][0] ?? 'error';
    } catch (e) {
      throw 'Ocurrió un error: $e';
    }
  }

  @override
  Future<String> deleteIndicadoresPorSet(int id) async {
    //Obtener las variables necesarias del storage
    final storage = LocalStorage();
    String? accessToken = await storage.getAccessToken();
    String rutaConId = '${ApiRoutes.indicadoresPorSetRoute}$id';
    try {
      //!TODO: después cambiarlas a https
      var url = Uri.http(ApiRoutes.urlApi, rutaConId);
      var response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken.toString(),
        },
      );

      final receivedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return 'success';
      }
      throw receivedData['messages'][0] ?? 'error';
    } catch (e) {
      throw 'Ocurrió un error: $e';
    }
  }

  @override
  Future<List<IndicadoresPorSet>> getAllIndicadoresPorIdSet(int idSet) async {
    //Obtener las variables necesarias del storage
    final storage = LocalStorage();
    String? accessToken = await storage.getAccessToken();
    List<IndicadoresPorSet> listado = [];
    String rutaConCodaleaOrg = '${ApiRoutes.indicadoresPorSetIdRoute}$idSet';
    try {
      //!TODO: después cambiarlas a https
      var url = Uri.http(ApiRoutes.urlApi, rutaConCodaleaOrg);
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken.toString(),
        },
      );

      final receivedData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 404) {
        final List<dynamic> json = receivedData['data']['indicadores_por_set'];

        listado = json.map((json) {
          return IndicadoresPorSetModel.fromJson(
              json as Map<String, dynamic>); //es importante en "as" (casting)
        }).toList();
        return listado;
      }
      throw receivedData['messages'][0] ?? 'error';
    } catch (e) {
      throw 'Ocurrió un error: $e';
    }
  }
}
