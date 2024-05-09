
import 'package:flutter/material.dart';
import 'package:safe_places_app/models/params/login_params.dart';
import 'package:safe_places_app/models/results/identity_result.dart';
import 'package:safe_places_app/screens/home_screen.dart';
import 'package:safe_places_app/services/identity_services.dart';

import '../../constants/colors.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // States
  bool _isSubmitting = false;

  // Focus nodes
  final userNameFn = FocusNode();
  final passwordFn = FocusNode();

  // Errors states
  Map<String, String?> _errors = {'email': null, 'password': null};

  // Form params
  final loginParams = LoginParams(email: "", password: "");

  final _formKey = GlobalKey<FormState>();

  Future<void> _submitForm(BuildContext context) async {
    _formKey.currentState?.save();

    setState(() {
      _isSubmitting = true;
    });

    try {
      final identityResult = await identityServices.loginAction(loginParams);

      if (identityResult.status == ResponseStatus.badRequest){
        final err = identityResult.error as Map<String, dynamic>;

        if (err.containsKey('errors')){

          final Map<String, String?> errors = {
            'email': null,
            'password': null
          };

          if ((err['errors'] as Map<String,dynamic>).containsKey('Email')){
            errors['email'] = err['errors']['Email'][0];
          }


          if ((err['errors'] as Map<String,dynamic>).containsKey('Password')){
            errors['password'] = err['errors']['Password'][0];
          }


          setState(() {
            _errors = errors;
          });

          _formKey.currentState?.validate();
        }else if (err.containsKey('message') && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err['message'])));
        }
        return;
      }

      if (identityResult.status == ResponseStatus.notFound){
        if (context.mounted){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Server error ..!')));
        }

        return;
      }

      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed(HomeScreen.route);
      }

    } catch (_) {

      debugPrint('Error .....!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');




    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        child: Form(
          key: _formKey,
          child: Container(
            height: 450,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset(
                  'assets/location.png',
                  width: 50,
                ),
                const Text('Login'),
                const SizedBox(height: 30),
                TextFormField(
                  focusNode: userNameFn,
                  textInputAction: TextInputAction.next,
                  decoration:
                      const InputDecoration(label: Text('Email or user name')),
                  validator: (_) => _errors['email'],
                  onFieldSubmitted: (_) {
                    Focus.of(context).requestFocus(passwordFn);
                  },
                  onSaved: (value) {
                    loginParams.email = value ?? "";
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  focusNode: passwordFn,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  decoration: const InputDecoration(label: Text('Password')),
                  validator: (_) => _errors['password'],
                  onSaved: (value) {
                    loginParams.password = value ?? "";
                  },
                  onFieldSubmitted: (_) {
                    _submitForm(context);
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    _submitForm(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.success,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 40)),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ))
                      : const Text('Login'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
