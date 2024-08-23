import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:adasba_2024/data/models/compromiso_ley_model.dart';
import 'package:adasba_2024/domain/entities/compromiso_ley.dart';
import 'package:adasba_2024/utilities/local_storage.dart';
import 'package:adasba_2024/constants/api_routes.dart';

abstract class CompromisoLeyDataSource {
  Future<List<CompromisoLey>> getAllCompromisosLey(String codaleaOrg);
  Future<CompromisoLey> getSpecificCompromisoLey(int id);
  Future<String> addCompromisoLey(CompromisoLey compromisoLey);
  Future<void> updateCompromisoLey(CompromisoLey compromisoLey);
  Future<void> deleteCompromisoLey(int id);
}

class RemoteCompromisoLeyDataSource implements CompromisoLeyDataSource {
  @override
  Future<String> addCompromisoLey(CompromisoLey compromisoLey) async {
    //Obtener las variables necesarias del storage
    final storage = LocalStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de model a partir del entity
    CompromisoLeyModel compromisoLeyModel =
        CompromisoLeyModel.fromCompromiso(compromisoLey);

    Map<String, dynamic> cuerpo = compromisoLeyModel.toJson();
    try {
      //!TODO: después cambiarlas a https
      var url = Uri.http(ApiRoutes.urlApi, ApiRoutes.addCompromisoLeyRoute);
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
  Future<String> deleteCompromisoLey(int id) async {
    //Obtener las variables necesarias del storage
    final storage = LocalStorage();
    String? accessToken = await storage.getAccessToken();
    String rutaConId = '${ApiRoutes.compromisoLeyRoute}$id';
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
  Future<List<CompromisoLey>> getAllCompromisosLey(String codaleaOrg) async {
    //Obtener las variables necesarias del storage
    final storage = LocalStorage();
    String? accessToken = await storage.getAccessToken();
    List<CompromisoLey> listado = [];
    String rutaConCodaleaOrg = '${ApiRoutes.allCompromisosLeyRoute}$codaleaOrg';
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
        final List<dynamic> json = receivedData['data']['compromiso_ley'];

        listado = json.map((json) {
          return CompromisoLeyModel.fromJson(
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
  Future<CompromisoLey> getSpecificCompromisoLey(int id) async {
    //Obtener las variables necesarias del storage
    final storage = LocalStorage();
    String? accessToken = await storage.getAccessToken();
    List<CompromisoLey> listado = [];
    String rutaConId = '${ApiRoutes.compromisoLeyRoute}$id';
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
        final List<dynamic> json = receivedData['data']['compromiso_ley'];

        listado = json.map((json) {
          return CompromisoLeyModel.fromJson(
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
  Future<String> updateCompromisoLey(CompromisoLey compromisoLey) async {
    //Obtener las variables necesarias del storage
    final storage = LocalStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de GrupoModel a partir de Grupo
    CompromisoLeyModel compromisoLeyModel =
        CompromisoLeyModel.fromCompromiso(compromisoLey);

    String rutaConId = '${ApiRoutes.compromisoLeyRoute}${compromisoLey.id}';

    Map<String, dynamic> cuerpo = compromisoLeyModel.toJson();
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
