import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:safe_places_app/constants/urls.dart';
import 'package:safe_places_app/models/params/login_params.dart';
import 'package:safe_places_app/models/results/identity_result.dart';
import 'package:safe_places_app/services/token_services.dart';

import '../models/results/user_auth_result.dart';
import 'package:http/http.dart' as http;

class _IdentityServices {
  Future<IdentityResult> loginAction(LoginParams login) async {

      http.Response response = await http.post(
          Uri.parse('${Urls.baseUrl}/api/account/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(login.toMap()));

      if (response.statusCode == 400){
        return IdentityResult(status: ResponseStatus.badRequest,error: jsonDecode(response.body));
      }

      if (response.statusCode == 404){
        return const IdentityResult(status: ResponseStatus.notFound,error: {'message': 'Server error ....!'});
      }


      UserAuthResult authResult = UserAuthResult.fromJson(response.body);


      await tokenServices.setToken(authResult.token);

      return IdentityResult(status: ResponseStatus.ok,userData: authResult);
  }

  Future<IdentityResult> authorization() async {
    const storage = FlutterSecureStorage();
    
    String? jwt = await storage.read(key: 'jwt');
    
    if (jwt == null){
      return const IdentityResult(status: ResponseStatus.unauthorized);
    }
    
    
    http.Response response = await http.get(Uri.parse('${Urls.baseUrl}/auth/authorize'),headers: {
      'Authorization': 'Bearer $jwt'
    });

    if (response.statusCode == 401){
      return const IdentityResult(status: ResponseStatus.unauthorized);
    }

    return const IdentityResult(status: ResponseStatus.ok);
  }

}

final identityServices = _IdentityServices();
