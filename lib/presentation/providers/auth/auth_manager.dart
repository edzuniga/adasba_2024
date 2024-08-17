import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:adasba_2024/presentation/providers/auth/credentials_manager.dart';
import 'package:adasba_2024/utilities/secure_storage.dart';
import 'package:adasba_2024/constants/api_routes.dart';
part 'auth_manager.g.dart';

@Riverpod(keepAlive: true)
class AuthManager extends _$AuthManager {
  @override
  bool build() {
    return false;
  }

  set setAuthenticationStatus(bool valor) {
    state = valor;
  }

  Future<String> tryLogin(
      String email, String password, BuildContext context) async {
    try {
      Map<String, dynamic> cuerpo = {
        'correo': email,
        'contrasena': password,
      };
      //TODO: CAMBIARLO A HTTPS CUANDO YA ESTÉ EN PRODUCCIÓN
      Uri url = Uri.http(ApiRoutes.urlApi, ApiRoutes.authApiRoute);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(cuerpo),
      );

      final receivedData = jsonDecode(response.body);

      //Manejo de la respuesta
      if (response.statusCode == 201 && receivedData['success'] == true) {
        //Grabación de los datos recibidos en Secure Storage
        SecureStorage storage = SecureStorage();

        //Chequear que no hayan datos viejos (si hay, borrarlos)
        Map<String, String> oldCredentials = await storage.getAllValues();
        oldCredentials.isNotEmpty
            ? await storage.deleteCredentialValues()
            : null;

        await storage
            .setSessionId(receivedData['data']['session_id'].toString());
        await storage
            .setAccessToken(receivedData['data']['access_token'].toString());
        await storage.setAccessTokenExpiry(
            receivedData['data']['access_token_expires_in'].toString());
        await storage.setAccessTokenExpiryDate(
            receivedData['data']['accesstokenexpiry'].toString());
        await storage
            .setRefreshToken(receivedData['data']['refresh_token'].toString());
        await storage.setRefreshTokenExpiry(
            receivedData['data']['refresh_token_expires_in'].toString());
        await storage.setUserId(receivedData['data']['userid'].toString());

        String? userId = await storage.getUserId();
        String? accessToken = await storage.getAccessToken();

        //? Obtener los datos del usuario que hizo login
        //TODO: CAMBIARLO A HTTPS CUANDO YA ESTÉ EN PRODUCCIÓN
        Uri urlUsers =
            Uri.http(ApiRoutes.urlApi, '${ApiRoutes.userRoute}$userId');
        var responseUserData = await http.get(
          urlUsers,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': accessToken!,
          },
        );

        final rawUserData = jsonDecode(responseUserData.body);

        if (responseUserData.statusCode == 200) {
          final userData = rawUserData['data']['usuarios'][0];

          await storage.setCodaleaOrg(userData['codalea_org'].toString());
          (userData['foto'] != null && userData['foto'] != '')
              ? await storage.setFotoUrl(userData['foto'].toString())
              : await storage.setFotoUrl('');
          await storage.setCorreo(userData['correo'].toString());
          await storage.setNombres(userData['nombres'].toString());
          await storage.setApellidos(userData['apellidos'].toString());
          await storage.setRol(userData['rol'].toString());

          //Obtener todos los valores en el storage
          Map<String, String> userDataMap = await storage.getAllValues();

          //Grabación de las credenciales en el provider de credenciales
          ref
              .read(userCredentialsProvider.notifier)
              .setUserCredentials(userDataMap);

          state = true; //Actualizar el estado del provider de auth
          return 'success';
        }
        return 'error';
      } else {
        return (receivedData['messages'] != null) &&
                receivedData['messages'] != ''
            ? receivedData['messages'][0].toString()
            : '';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> tryRefreshToken() async {
    final storage = SecureStorage();

    //Obtener los campos necesarios
    String? accessToken = await storage.getAccessToken();
    String? idSession = await storage.getSessionId();
    String? refreshToken = await storage.getRefreshToken();

    try {
      Map<String, dynamic> cuerpo = {
        "refresh_token": "$refreshToken",
      };
      //TODO: CAMBIARLO A HTTPS CUANDO YA ESTÉ EN PRODUCCIÓN
      Uri url =
          Uri.http(ApiRoutes.urlApi, '${ApiRoutes.authApiRoute}/$idSession');
      var response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken!,
        },
        body: jsonEncode(cuerpo),
      );

      final receivedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        //Grabación de los datos recibidos en Secure Storage
        SecureStorage storage = SecureStorage();

        //Borrar SOLAMENTE la info de session
        storage.deleteSessionValues();

        await storage
            .setSessionId(receivedData['data']['session_id'].toString());
        await storage
            .setAccessToken(receivedData['data']['access_token'].toString());
        await storage.setAccessTokenExpiry(
            receivedData['data']['access_token_expires_in'].toString());
        await storage.setAccessTokenExpiryDate(
            receivedData['data']['accesstokenexpiry'].toString());
        await storage
            .setRefreshToken(receivedData['data']['refresh_token'].toString());
        await storage.setRefreshTokenExpiry(
            receivedData['data']['refresh_token_expires_in'].toString());
        //Obtener todos los valores en el storage
        Map<String, String> userDataMap = await storage.getAllValues();

        //Grabación de las credenciales en el provider de credenciales
        ref
            .read(userCredentialsProvider.notifier)
            .setUserCredentials(userDataMap);

        state = true; //Actualizar el estado del provider de auth
        return 'success';
      } else {
        state = false;
        return (receivedData['messages'] != null) &&
                receivedData['messages'] != ''
            ? receivedData['messages'][0].toString()
            : '';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> tryLogout() async {
    SecureStorage storage = SecureStorage();

    String? accessToken = await storage.getAccessToken();
    String? idSession = await storage.getSessionId();

    try {
      Uri url =
          Uri.http(ApiRoutes.urlApi, '${ApiRoutes.authApiRoute}/$idSession');
      var response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken!,
        },
      );

      var receivedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        //Borrar el contenido del storage
        await storage.deleteCredentialValues();
        state = false;
        return 'success';
      } else {
        return (receivedData['messages'] != null) &&
                receivedData['messages'] != ''
            ? receivedData['messages'][0].toString()
            : '';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
