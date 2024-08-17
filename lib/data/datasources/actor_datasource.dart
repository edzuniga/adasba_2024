import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:adasba_2024/data/models/actor_model.dart';
import 'package:adasba_2024/domain/entities/actor.dart';
import 'package:adasba_2024/utilities/secure_storage.dart';
import 'package:adasba_2024/constants/api_routes.dart';

abstract class ActorDataSource {
  Future<List<Actor>> getAllActores(String codaleaOrg);
  Future<Actor> getSpecificActor(int id);
  Future<String> addActor(Actor actor);
  Future<void> updateActor(Actor actor);
  Future<void> deleteActor(int id);
}

class RemoteActorDataSource implements ActorDataSource {
  @override
  Future<String> addActor(Actor actor) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de model a partir del entity
    ActorModel actorModel = ActorModel.fromActor(actor);

    Map<String, dynamic> cuerpo = actorModel.toJson();
    try {
      //!TODO: después cambiarlas a https
      var url = Uri.http(ApiRoutes.urlApi, ApiRoutes.addActorRoute);
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
  Future<String> deleteActor(int id) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();
    String rutaConId = '${ApiRoutes.actorRoute}$id';
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
  Future<List<Actor>> getAllActores(String codaleaOrg) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();
    List<Actor> actoresListado = [];
    String rutaConCodaleaOrg = '${ApiRoutes.allActoresRoute}$codaleaOrg';
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
        final List<dynamic> actoresJson =
            receivedData['data']['actores_participantes'];

        actoresListado = actoresJson.map((json) {
          return ActorModel.fromJson(
              json as Map<String, dynamic>); //es importante en "as" (casting)
        }).toList();
        return actoresListado;
      }
      throw receivedData['messages'][0] ?? 'error';
    } catch (e) {
      throw 'Ocurrió un error: $e';
    }
  }

  @override
  Future<Actor> getSpecificActor(int id) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();
    List<Actor> actoresListado = [];
    String rutaConId = '${ApiRoutes.actorRoute}$id';
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
        final List<dynamic> actoresJson =
            receivedData['data']['actores_participantes'];

        actoresListado = actoresJson.map((json) {
          return ActorModel.fromJson(
              json as Map<String, dynamic>); //es importante en "as" (casting)
        }).toList();
        return actoresListado.first;
      }
      throw receivedData['messages'][0] ?? 'error';
    } catch (e) {
      throw 'Ocurrió un error: $e';
    }
  }

  @override
  Future<String> updateActor(Actor actor) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de GrupoModel a partir de Grupo
    ActorModel actorModel = ActorModel.fromActor(actor);

    String rutaConId = '${ApiRoutes.actorRoute}${actor.id}';

    Map<String, dynamic> cuerpo = actorModel.toJson();
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
