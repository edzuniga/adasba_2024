import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
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
  Future setSessionId(String sessionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(_keySessionId, sessionId);
    } catch (e) {
      throw 'error con storage: $e';
    }
  }

  Future setAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(_keyAccessToken, accessToken);
    } catch (e) {
      throw 'error con storage: $e';
    }
  }

  Future setAccessTokenExpiry(String accessTokenExpiry) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(_keyAccessTokenExpiry, accessTokenExpiry);
    } catch (e) {
      throw 'error con storage: $e';
    }
  }

  Future setAccessTokenExpiryDate(String accessTokenExpiryDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(_keyAccessTokenExpiryDate, accessTokenExpiryDate);
    } catch (e) {
      throw 'error con storage: $e';
    }
  }

  Future setRefreshToken(String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(_keyRefreshToken, refreshToken);
    } catch (e) {
      throw 'error con storage: $e';
    }
  }

  Future setRefreshTokenExpiry(String refreshTokenExpiry) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(_keyRefreshTokenExpiry, refreshTokenExpiry);
    } catch (e) {
      throw 'error con storage: $e';
    }
  }

  Future setUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(_keyUserId, userId);
    } catch (e) {
      throw 'error con storage: $e';
    }
  }

  Future setCodaleaOrg(String codaleaOrg) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(_keyCodaleaOrg, codaleaOrg);
    } catch (e) {
      throw 'error con storage: $e';
    }
  }

  Future setFotoUrl(String fotoUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(_keyFotoUrl, fotoUrl);
    } catch (e) {
      throw 'error con storage: $e';
    }
  }

  Future setNombres(String nombres) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(_keyNombres, nombres);
    } catch (e) {
      throw 'error de storage: $e';
    }
  }

  Future setApellidos(String apellidos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(_keyApellidos, apellidos);
    } catch (e) {
      throw 'error de storage: $e';
    }
  }

  Future setCorreo(String correo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(_keyCorreo, correo);
    } catch (e) {
      throw 'error de storage: $e';
    }
  }

  Future setRol(String rol) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(_keyRol, rol);
    } catch (e) {
      throw 'error de storage: $e';
    }
  }

  //GETTERS
  Future<String?> getSessionId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keySessionId);
  }

  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAccessToken);
  }

  Future<String?> getAccessTokenExpiry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAccessTokenExpiry);
  }

  Future<String?> getAccessTokenExpiryDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAccessTokenExpiryDate);
  }

  Future<String?> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyRefreshToken);
  }

  Future<String?> getRefreshTokenExpiry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyRefreshTokenExpiry);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }

  Future<String?> getCodaleaOrg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyCodaleaOrg);
  }

  Future<String?> getFotoUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyFotoUrl);
  }

  Future<String?> getNombres() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyNombres);
  }

  Future<String?> getApellidos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyApellidos);
  }

  Future<String?> getCorreo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyCorreo);
  }

  Future<String?> getRol() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyRol);
  }

  //Función para obtener todos los valores en el storage y mandarlos como mapa
  Future<Map<String, String>> getAllValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> mapa = {};

    (prefs.getString(_keySessionId) != null)
        ? mapa[_keySessionId] = prefs.getString(_keySessionId)!
        : null;
    (prefs.getString(_keyAccessToken) != null)
        ? mapa[_keyAccessToken] = prefs.getString(_keyAccessToken)!
        : null;
    (prefs.getString(_keyAccessTokenExpiry) != null)
        ? mapa[_keyAccessTokenExpiry] = prefs.getString(_keyAccessTokenExpiry)!
        : null;
    (prefs.getString(_keyRefreshToken) != null)
        ? mapa[_keyRefreshToken] = prefs.getString(_keyRefreshToken)!
        : null;
    (prefs.getString(_keyRefreshTokenExpiry) != null)
        ? mapa[_keyRefreshTokenExpiry] =
            prefs.getString(_keyRefreshTokenExpiry)!
        : null;
    (prefs.getString(_keyAccessTokenExpiryDate) != null)
        ? mapa[_keyAccessTokenExpiryDate] =
            prefs.getString(_keyAccessTokenExpiryDate)!
        : null;
    (prefs.getString(_keyUserId) != null)
        ? mapa[_keyUserId] = prefs.getString(_keyUserId)!
        : null;
    (prefs.getString(_keyCodaleaOrg) != null)
        ? mapa[_keyCodaleaOrg] = prefs.getString(_keyCodaleaOrg)!
        : null;
    (prefs.getString(_keyFotoUrl) != null)
        ? mapa[_keyFotoUrl] = prefs.getString(_keyFotoUrl)!
        : null;
    (prefs.getString(_keyNombres) != null)
        ? mapa[_keyNombres] = prefs.getString(_keyNombres)!
        : null;
    (prefs.getString(_keyApellidos) != null)
        ? mapa[_keyApellidos] = prefs.getString(_keyApellidos)!
        : null;
    (prefs.getString(_keyCorreo) != null)
        ? mapa[_keyCorreo] = prefs.getString(_keyCorreo)!
        : null;
    (prefs.getString(_keyRol) != null)
        ? mapa[_keyRol] = prefs.getString(_keyRol)!
        : null;

    return mapa;
  }

  //DELETE ALL VALUES (WHEN SESSION IS DESTROYED)
  Future<void> deleteCredentialValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_keySessionId);
    prefs.remove(_keyAccessToken);
    prefs.remove(_keyAccessTokenExpiry);
    prefs.remove(_keyRefreshToken);
    prefs.remove(_keyRefreshTokenExpiry);
    prefs.remove(_keyAccessTokenExpiryDate);
    prefs.remove(_keyUserId);
    prefs.remove(_keyCodaleaOrg);
    prefs.remove(_keyFotoUrl);
    prefs.remove(_keyNombres);
    prefs.remove(_keyApellidos);
    prefs.remove(_keyCorreo);
    prefs.remove(_keyRol);
  }

  Future<void> deleteSessionValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.remove(_keySessionId);
      await prefs.remove(_keyAccessToken);
      await prefs.remove(_keyAccessTokenExpiry);
      await prefs.remove(_keyRefreshToken);
      await prefs.remove(_keyRefreshTokenExpiry);
      await prefs.remove(_keyAccessTokenExpiryDate);
    } catch (e) {
      throw 'Error con storage: $e';
    }
  }
}
