import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:adasba_2024/domain/entities/user.dart';
import 'package:adasba_2024/utilities/secure_storage.dart';

import 'package:adasba_2024/data/models/user_model.dart';
import 'package:adasba_2024/constants/api_routes.dart';

abstract class UserDataSource {
  Future<List<User>> getAllUsers(String codaleaOrg);
  Future<User> getSpecificUser(int id);
  Future<String> addUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(int id);
}

class RemoteUserDataSource implements UserDataSource {
  @override
  Future<String> addUser(User user) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de userModel a partir de user
    UserModel userModel = UserModel.fromUser(user);

    Map<String, dynamic> cuerpo = userModel.toJson();
    try {
      //!TODO: después cambiarlas a https
      var url = Uri.http(ApiRoutes.urlApi, ApiRoutes.addUserRoute);
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
  Future<String> deleteUser(int id) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();
    String rutaConId = '${ApiRoutes.userRoute}$id';
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
  Future<List<User>> getAllUsers(String codaleaOrg) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();
    List<User> usuariosListado = [];
    String rutaConCodaleaOrg = '${ApiRoutes.allUsersRoute}$codaleaOrg';
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
        final List<dynamic> usuariosJson = receivedData['data']['usuarios'];

        usuariosListado = usuariosJson.map((json) {
          return UserModel.fromJson(
              json as Map<String, dynamic>); //es importante en "as" (casting)
        }).toList();
        return usuariosListado;
      }
      throw receivedData['messages'][0] ?? 'error';
    } catch (e) {
      throw 'Ocurrió un error: $e';
    }
  }

  @override
  Future<User> getSpecificUser(int id) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();
    List<User> usersListado = [];
    String rutaConId = '${ApiRoutes.userRoute}$id';
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
        final List<dynamic> usersJson = receivedData['data']['usuarios'];

        usersListado = usersJson.map((json) {
          return UserModel.fromJson(
              json as Map<String, dynamic>); //es importante en "as" (casting)
        }).toList();
        return usersListado.first;
      }
      throw receivedData['messages'][0] ?? 'error';
    } catch (e) {
      throw 'Ocurrió un error: $e';
    }
  }

  @override
  Future<String> updateUser(User user) async {
    //Obtener las variables necesarias del storage
    final storage = SecureStorage();
    String? accessToken = await storage.getAccessToken();

    // Crear una instancia de GrupoModel a partir de Grupo
    UserModel userModel = UserModel.fromUser(user);

    String rutaConId = '${ApiRoutes.userRoute}${user.id}';

    Map<String, dynamic> cuerpo = userModel.toJson();
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
