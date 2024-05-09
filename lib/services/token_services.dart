import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class _TokenServices {
  Future<void> setToken(String token) async {
    const storage = FlutterSecureStorage();

    await storage.write(key: 'jwt', value: token);
  }



  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();

    return await storage.read(key: 'jwt');
  }
}



final tokenServices = _TokenServices();