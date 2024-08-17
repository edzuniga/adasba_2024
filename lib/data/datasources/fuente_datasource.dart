import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:adasba_2024/constants/api_routes.dart';
import 'package:adasba_2024/data/models/fuente_model.dart';
import 'package:adasba_2024/domain/entities/fuente.dart';
import 'package:adasba_2024/utilities/secure_storage.dart';

abstract class FuenteDatasource {
  Future<List<Fuente>> getAllFuentes(String codaleaOrg);
  Future<Fuente> getSpecificFuente(int id);
  Future<String> addFuente(Fuente fuente);
  Future<String> updateFuente(Fuente fuente);
  Future<String> deleteFuente(int id);
}

class RemoteFuenteDataSource implements FuenteDatasource {
  @override
  Future<String> addFuente(Fuente fuente) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de model a partir del entity
    FuenteModel model = FuenteModel.fromFuente(fuente);

    Map<String, dynamic> cuerpo = model.toJson();
    try {
      //!TODO: después cambiarlas a https
      var url = Uri.http(ApiRoutes.urlApi, ApiRoutes.addFuenteRoute);
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
  Future<String> deleteFuente(int id) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();
    String rutaConId = '${ApiRoutes.fuenteRoute}$id';
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
  Future<List<Fuente>> getAllFuentes(String codaleaOrg) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();
    List<Fuente> listado = [];
    String rutaConCodaleaOrg = '${ApiRoutes.allFuentesRoute}$codaleaOrg';
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
      if (response.statusCode == 200) {
        final List<dynamic> json =
            receivedData['data']['fuentes_financiamiento'];

        listado = json.map((json) {
          return FuenteModel.fromJson(
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
  Future<Fuente> getSpecificFuente(int id) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();
    List<Fuente> listado = [];
    String rutaConId = '${ApiRoutes.fuenteRoute}$id';
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
        final List<dynamic> json =
            receivedData['data']['fuentes_financiamiento'];

        listado = json.map((json) {
          return FuenteModel.fromJson(
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
  Future<String> updateFuente(Fuente fuente) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de GrupoModel a partir de Grupo
    FuenteModel model = FuenteModel.fromFuente(fuente);

    String rutaConId = '${ApiRoutes.fuenteRoute}${fuente.id}';

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
