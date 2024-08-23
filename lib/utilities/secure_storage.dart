/*import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();
  final String _keySessionId = 'session_id';
  final String _keyAccessToken = 'access_token';
  final String _keyAccessTokenExpiry = 'access_token_expires_in';
  final String _keyRefreshToken = 'refresh_token';
  final String _keyRefreshTokenExpiry = 'refresh_token_expires_in';
  final String _keyAccessTokenExpiryDate = 'accesstokenexpiry';

  //Datos específicos del usuario con sesión activa
  final String _keyUserId = 'userid';
  final String _keyCodaleaOrg = 'codalea_org';
  final String _keyFotoUrl = 'foto';
  final String _keyNombres = 'nombres';
  final String _keyApellidos = 'apellidos';
  final String _keyCorreo = 'correo';
  final String _keyRol = 'rol';

  //SETTERS
  Future<String> setSessionId(String sessionId) async {
    try {
      await storage.write(key: _keySessionId, value: sessionId);
      return 'exito';
    } catch (e) {
      throw 'error con storage: $e';
    }
  }

  Future setAccessToken(String accessToken) async {
    try {
      await storage.write(key: _keyAccessToken, value: accessToken);
    } catch (e) {
      throw 'error con storage: $e';
    }
  }

  Future setAccessTokenExpiry(String accessTokenExpiry) async {
    try {
      await storage.write(key: _keyAccessTokenExpiry, value: accessTokenExpiry);
    } catch (e) {
      throw 'error con storage: $e';
    }
  }

  Future setAccessTokenExpiryDate(String accessTokenExpiryDate) async {
    try {
      await storage.write(
          key: _keyAccessTokenExpiryDate, value: accessTokenExpiryDate);
    } catch (e) {
      throw 'error con storage: $e';
    }
  }

  Future setRefreshToken(String refreshToken) async {
    try {
      await storage.write(key: _keyRefreshToken, value: refreshToken);
    } catch (e) {
      throw 'error con storage: $e';
    }
  }

  Future setRefreshTokenExpiry(String refreshTokenExpiry) async {
    try {
      await storage.write(
          key: _keyRefreshTokenExpiry, value: refreshTokenExpiry);
    } catch (e) {
      throw 'error con storage: $e';
    }
  }

  Future setUserId(String userId) async {
    try {
      await storage.write(key: _keyUserId, value: userId);
    } catch (e) {
      throw 'error con storage: $e';
    }
  }

  Future setCodaleaOrg(String codaleaOrg) async {
    try {
      await storage.write(key: _keyCodaleaOrg, value: codaleaOrg);
    } catch (e) {
      throw 'error con storage: $e';
    }
  }

  Future setFotoUrl(String fotoUrl) async {
    try {
      await storage.write(key: _keyFotoUrl, value: fotoUrl);
    } catch (e) {
      throw 'error con storage: $e';
    }
  }

  Future setNombres(String nombres) async {
    try {
      await storage.write(key: _keyNombres, value: nombres);
    } catch (e) {
      throw 'error de storage: $e';
    }
  }

  Future setApellidos(String apellidos) async {
    try {
      await storage.write(key: _keyApellidos, value: apellidos);
    } catch (e) {
      throw 'error de storage: $e';
    }
  }

  Future setCorreo(String correo) async {
    try {
      await storage.write(key: _keyCorreo, value: correo);
    } catch (e) {
      throw 'error de storage: $e';
    }
  }

  Future setRol(String rol) async {
    try {
      await storage.write(key: _keyRol, value: rol);
    } catch (e) {
      throw 'error de storage: $e';
    }
  }

  //GETTERS
  Future<String?> getSessionId() async {
    return await storage.read(key: _keySessionId);
  }

  Future<String?> getAccessToken() async {
    return await storage.read(key: _keyAccessToken);
  }

  Future<String?> getAccessTokenExpiry() async {
    return await storage.read(key: _keyAccessTokenExpiry);
  }

  Future<String?> getAccessTokenExpiryDate() async {
    return await storage.read(key: _keyAccessTokenExpiryDate);
  }

  Future<String?> getRefreshToken() async {
    return await storage.read(key: _keyRefreshToken);
  }

  Future<String?> getRefreshTokenExpiry() async {
    return await storage.read(key: _keyRefreshTokenExpiry);
  }

  Future<String?> getUserId() async {
    return await storage.read(key: _keyUserId);
  }

  Future<String?> getCodaleaOrg() async {
    return await storage.read(key: _keyCodaleaOrg);
  }

  Future<String?> getFotoUrl() async {
    return await storage.read(key: _keyFotoUrl);
  }

  Future<String?> getNombres() async {
    return await storage.read(key: _keyNombres);
  }

  Future<String?> getApellidos() async {
    return await storage.read(key: _keyApellidos);
  }

  Future<String?> getCorreo() async {
    return await storage.read(key: _keyCorreo);
  }

  Future<String?> getRol() async {
    return await storage.read(key: _keyRol);
  }

  //Función para obtener todos los valores en el storage y mandarlos como mapa
  Future<Map<String, String>> getAllValues() async {
    try {
      return await storage.readAll();
    } catch (e) {
      throw 'Error con storage: $e';
    }
  }

  //DELETE ALL VALUES (WHEN SESSION IS DESTROYED)
  Future<void> deleteCredentialValues() async {
    try {
      await storage.deleteAll();
    } catch (e) {
      throw 'Error con storage: $e';
    }
  }

  Future<void> deleteSessionValues() async {
    try {
      await storage.delete(key: _keySessionId);
      await storage.delete(key: _keyAccessToken);
      await storage.delete(key: _keyAccessTokenExpiry);
      await storage.delete(key: _keyRefreshToken);
      await storage.delete(key: _keyRefreshTokenExpiry);
      await storage.delete(key: _keyAccessTokenExpiryDate);
    } catch (e) {
      throw 'Error con storage: $e';
    }
  }
}
*/