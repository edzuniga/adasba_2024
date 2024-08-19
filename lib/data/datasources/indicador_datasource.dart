import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:adasba_2024/constants/api_routes.dart';
import 'package:adasba_2024/data/models/indicador_model.dart';
import 'package:adasba_2024/domain/entities/indicador.dart';
import 'package:adasba_2024/utilities/secure_storage.dart';

abstract class IndicadorDataSource {
  Future<List<Indicador>> getAllIndicadores(String codaleaOrg);
  Future<Indicador> getSpecificIndicador(int id);
  Future<String> addIndicador(Indicador indicador);
  Future<String> updateIndicador(Indicador indicador);
  Future<String> deleteIndicador(int id);
}

class RemoteIndicadorDataSource implements IndicadorDataSource {
  @override
  Future<String> addIndicador(Indicador indicador) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de componenteModel a partir de componente
    IndicadorModel model = IndicadorModel.fromIndicador(indicador);

    Map<String, dynamic> cuerpo = model.toJson();
    try {
      //!TODO: después cambiarlas a https
      var url = Uri.http(ApiRoutes.urlApi, ApiRoutes.addIndicadorRoute);
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
  Future<String> deleteIndicador(int id) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();
    String rutaConId = '${ApiRoutes.indicadorRoute}$id';
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
  Future<List<Indicador>> getAllIndicadores(String codaleaOrg) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();
    List<Indicador> listado = [];
    String rutaConCodaleaOrg = '${ApiRoutes.allIndicadoresRoute}$codaleaOrg';
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
        final List<dynamic> json = receivedData['data']['indicadores'];

        listado = json.map((json) {
          return IndicadorModel.fromJson(
              json as Map<String, dynamic>); //es importante en "as" (casting)
        }).toList();
        return listado;
      }
      throw receivedData['messages'][0] ?? 'error';
    } catch (e) {
      throw 'Ocurrió un error: $e';
    }
  }

  @override
  Future<Indicador> getSpecificIndicador(int id) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();
    List<Indicador> listado = [];
    String rutaConId = '${ApiRoutes.indicadorRoute}$id';
    try {
      //!TODO: después cambiarlas a https
      var url = Uri.http(ApiRoutes.urlApi, rutaConId);
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken.toString(),
        },
      );

      final receivedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> json = receivedData['data']['indicadores'];

        listado = json.map((json) {
          return IndicadorModel.fromJson(
              json as Map<String, dynamic>); //es importante en "as" (casting)
        }).toList();
        return listado.first;
      }
      throw receivedData['messages'][0] ?? 'error';
    } catch (e) {
      throw 'Ocurrió un error: $e';
    }
  }

  @override
  Future<String> updateIndicador(Indicador indicador) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de GrupoModel a partir de Grupo
    IndicadorModel model = IndicadorModel.fromIndicador(indicador);

    String rutaConId = '${ApiRoutes.indicadorRoute}${indicador.id}';

    Map<String, dynamic> cuerpo = model.toJson();
    try {
      //!TODO: después cambiarlas a https
      var url = Uri.http(ApiRoutes.urlApi, rutaConId);
      var response = await http.patch(
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
      } else {
        throw receivedData['messages'][0] ?? 'error';
      }
    } catch (e) {
      throw 'Ocurrió un error: $e';
    }
  }
}
