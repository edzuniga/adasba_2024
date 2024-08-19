import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:adasba_2024/utilities/secure_storage.dart';
import 'package:adasba_2024/data/models/proyecto_model.dart';
import 'package:adasba_2024/domain/entities/proyecto.dart';
import 'package:adasba_2024/constants/api_routes.dart';

abstract class ProyectoDataSource {
  Future<List<Proyecto>> getAllProyectos(String codaleaOrg);
  Future<Proyecto> getSpecificProyecto(int id);
  Future<String> addProyecto(Proyecto proyecto);
  Future<void> updateProyecto(Proyecto proyecto);
  Future<void> deleteProyecto(int id);
}

class RemoteProyectoDataSource implements ProyectoDataSource {
  @override
  Future<String> addProyecto(Proyecto proyecto) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de proyectoModel a partir de proyecto
    ProyectoModel proyectoModel = ProyectoModel.fromProyecto(proyecto);

    Map<String, dynamic> cuerpo = proyectoModel.toJson();
    try {
      //!TODO: después cambiarlas a https
      var url = Uri.http(ApiRoutes.urlApi, ApiRoutes.addProyectoRoute);
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
  Future<String> deleteProyecto(int id) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();
    String rutaConId = '${ApiRoutes.proyectoRoute}$id';
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
  Future<List<Proyecto>> getAllProyectos(String codaleaOrg) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();
    List<Proyecto> proyectosListado = [];
    String rutaConCodaleaOrg = '${ApiRoutes.allProyectosRoute}$codaleaOrg';
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
        final List<dynamic> proyectosJson = receivedData['data']['proyectos'];

        proyectosListado = proyectosJson.map((json) {
          return ProyectoModel.fromJson(
              json as Map<String, dynamic>); //es importante en "as" (casting)
        }).toList();
        return proyectosListado;
      }
      throw receivedData['messages'][0] ?? 'error';
    } catch (e) {
      throw 'Ocurrió un error: $e';
    }
  }

  @override
  Future<Proyecto> getSpecificProyecto(int id) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();
    List<Proyecto> proyectosListado = [];
    String rutaConId = '${ApiRoutes.proyectoRoute}$id';
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
        final List<dynamic> proyectosJson = receivedData['data']['proyectos'];

        proyectosListado = proyectosJson.map((json) {
          return ProyectoModel.fromJson(
              json as Map<String, dynamic>); //es importante en "as" (casting)
        }).toList();
        return proyectosListado.first;
      }
      throw receivedData['messages'][0] ?? 'error';
    } catch (e) {
      throw 'Ocurrió un error: $e';
    }
  }

  @override
  Future<String> updateProyecto(Proyecto proyecto) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de GrupoModel a partir de Grupo
    ProyectoModel proyectoModel = ProyectoModel.fromProyecto(proyecto);

    String rutaConId = '${ApiRoutes.proyectoRoute}${proyecto.id}';

    Map<String, dynamic> cuerpo = proyectoModel.toJson();
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
