import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:adasba_2024/constants/api_routes.dart';
import 'package:adasba_2024/data/models/set_indicadores_model.dart';
import 'package:adasba_2024/domain/entities/set_indicador.dart';
import 'package:adasba_2024/utilities/local_storage.dart';

abstract class SetIndicadoresDataSource {
  Future<List<SetIndicador>> getAllSetIndicadores(String codaleaOrg);
  Future<SetIndicador> getSpecificSetIndicador(int id);
  Future<void> addSetIndicador(SetIndicador setIndicador);
  Future<void> updateSetIndicador(SetIndicador setIndicador);
  Future<void> deleteSetIndicador(int id);
}

class RemoteSetIndicadoresDataSource implements SetIndicadoresDataSource {
  @override
  Future<String> addSetIndicador(SetIndicador setIndicador) async {
    //Obtener las variables necesarias del storage
    final storage = LocalStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de model a partir del entity
    SetIndicadoresModel model =
        SetIndicadoresModel.fromSetIndicador(setIndicador);

    Map<String, dynamic> cuerpo = model.toJson();
    try {
      //!TODO: después cambiarlas a https
      var url = Uri.http(ApiRoutes.urlApi, ApiRoutes.addSetIndicadorRoute);
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
  Future<String> deleteSetIndicador(int id) async {
    //Obtener las variables necesarias del storage
    final storage = LocalStorage();
    String? accessToken = await storage.getAccessToken();
    String rutaConId = '${ApiRoutes.setIndicadorRoute}$id';
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
  Future<List<SetIndicador>> getAllSetIndicadores(String codaleaOrg) async {
    //Obtener las variables necesarias del storage
    final storage = LocalStorage();
    String? accessToken = await storage.getAccessToken();
    List<SetIndicador> listado = [];
    String rutaConCodaleaOrg = '${ApiRoutes.allSetIndicadoresRoute}$codaleaOrg';
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
        final List<dynamic> json = receivedData['data']['sets'];

        listado = json.map((json) {
          return SetIndicadoresModel.fromJson(
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
  Future<SetIndicador> getSpecificSetIndicador(int id) async {
    //Obtener las variables necesarias del storage
    final storage = LocalStorage();
    String? accessToken = await storage.getAccessToken();
    List<SetIndicador> listado = [];
    String rutaConId = '${ApiRoutes.setIndicadorRoute}$id';
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
        final List<dynamic> json = receivedData['data']['sets'];

        listado = json.map((json) {
          return SetIndicadoresModel.fromJson(
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
  Future<String> updateSetIndicador(SetIndicador setIndicador) async {
    //Obtener las variables necesarias del storage
    final storage = LocalStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de GrupoModel a partir de Grupo
    SetIndicadoresModel model =
        SetIndicadoresModel.fromSetIndicador(setIndicador);

    String rutaConId = '${ApiRoutes.setIndicadorRoute}${setIndicador.id}';

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
