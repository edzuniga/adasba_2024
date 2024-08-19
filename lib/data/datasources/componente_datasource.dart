import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:adasba_2024/data/models/componente_model.dart';
import 'package:adasba_2024/utilities/secure_storage.dart';
import 'package:adasba_2024/domain/entities/componente.dart';
import 'package:adasba_2024/constants/api_routes.dart';

abstract class ComponenteDataSource {
  Future<List<Componente>> getAllComponentes(String codaleaOrg);
  Future<Componente> getSpecificComponente(int id);
  Future<String> addComponente(Componente componente);
  Future<void> updateComponente(Componente componente);
  Future<void> deleteComponente(int id);
}

class RemoteComponenteDataSource implements ComponenteDataSource {
  @override
  Future<String> addComponente(Componente componente) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de componenteModel a partir de componente
    ComponenteModel model = ComponenteModel.fromComponente(componente);

    Map<String, dynamic> cuerpo = model.toJson();
    try {
      //!TODO: después cambiarlas a https
      var url = Uri.http(ApiRoutes.urlApi, ApiRoutes.addComponenteRoute);
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
  Future<String> deleteComponente(int id) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();
    String rutaConId = '${ApiRoutes.componenteRoute}$id';
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
  Future<List<Componente>> getAllComponentes(String codaleaOrg) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();
    List<Componente> listado = [];
    String rutaConCodaleaOrg = '${ApiRoutes.allComponentesRoute}$codaleaOrg';
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
        final List<dynamic> json = receivedData['data']['componentes'];

        listado = json.map((json) {
          return ComponenteModel.fromJson(
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
  Future<Componente> getSpecificComponente(int id) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();
    List<Componente> listado = [];
    String rutaConId = '${ApiRoutes.componenteRoute}$id';
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
        final List<dynamic> json = receivedData['data']['componentes'];

        listado = json.map((json) {
          return ComponenteModel.fromJson(
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
  Future<String> updateComponente(Componente componente) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de GrupoModel a partir de Grupo
    ComponenteModel model = ComponenteModel.fromComponente(componente);

    String rutaConId = '${ApiRoutes.componenteRoute}${componente.id}';

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
