import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:adasba_2024/utilities/local_storage.dart';
import 'package:adasba_2024/data/models/grupo_model.dart';
import 'package:adasba_2024/constants/api_routes.dart';
import 'package:adasba_2024/domain/entities/grupo_beneficiario.dart';

abstract class GrupoDataSource {
  Future<List<Grupo>> getAllGrupos(String codaleaOrg);
  Future<Grupo> getSpecificGrupo(int id);
  Future<String> addGrupo(Grupo grupo);
  Future<void> updateGrupo(Grupo grupo);
  Future<void> deleteGrupo(int id);
}

class RemoteGrupoDataSource implements GrupoDataSource {
  @override
  Future<String> addGrupo(Grupo grupo) async {
    //Obtener las variables necesarias del storage
    final storage = LocalStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de GrupoModel a partir de Grupo
    GrupoModel grupoModel = GrupoModel.fromGrupo(grupo);

    Map<String, dynamic> cuerpo = grupoModel.toJson();
    try {
      //!TODO: después cambiarlas a https
      var url = Uri.http(ApiRoutes.urlApi, ApiRoutes.addGrupoRoute);
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
      } else {
        throw receivedData['messages'][0] ?? 'error';
      }
    } catch (e) {
      throw 'Ocurrió un error: $e';
    }
  }

  @override
  Future<String> deleteGrupo(int id) async {
    //Obtener las variables necesarias del storage
    final storage = LocalStorage();
    String? accessToken = await storage.getAccessToken();
    String rutaConId = '${ApiRoutes.grupoRoute}$id';
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
  Future<List<Grupo>> getAllGrupos(String codaleaOrg) async {
    //Obtener las variables necesarias del storage
    final storage = LocalStorage();
    String? accessToken = await storage.getAccessToken();
    String rutaConCodaleaOrg = '${ApiRoutes.allGruposRoute}$codaleaOrg';
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
        final List<dynamic> gruposJson =
            receivedData['data']['grupos_beneficiarios'];

        List<Grupo> gruposListado = gruposJson.map((json) {
          return GrupoModel.fromJson(
              json as Map<String, dynamic>); //es importante en "as" (casting)
        }).toList();
        return gruposListado;
      }
      throw receivedData['messages'][0] ?? 'error';
    } catch (e) {
      throw 'Ocurrió un error: $e';
    }
  }

  @override
  Future<Grupo> getSpecificGrupo(int id) async {
    //Obtener las variables necesarias del storage
    final storage = LocalStorage();
    String? accessToken = await storage.getAccessToken();
    List<Grupo> gruposListado = [];
    String rutaConId = '${ApiRoutes.grupoRoute}$id';
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
        final List<dynamic> gruposJson =
            receivedData['data']['grupos_beneficiarios'];

        gruposListado = gruposJson.map((json) {
          return GrupoModel.fromJson(
              json as Map<String, dynamic>); //es importante en "as" (casting)
        }).toList();
        return gruposListado.first;
      }

      throw receivedData['messages'][0] ?? 'error';
    } catch (e) {
      throw 'Ocurrió un error: $e';
    }
  }

  @override
  Future<String> updateGrupo(Grupo grupo) async {
    //Obtener las variables necesarias del storage
    final storage = LocalStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de GrupoModel a partir de Grupo
    GrupoModel grupoModel = GrupoModel.fromGrupo(grupo);

    String rutaConId = '${ApiRoutes.grupoRoute}${grupo.id}';

    Map<String, dynamic> cuerpo = grupoModel.toJson();
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
