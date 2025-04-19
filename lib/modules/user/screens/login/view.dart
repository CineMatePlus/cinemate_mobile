import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemate_mobile/modules/user/screens/login/state.dart';
import 'package:cinemate_mobile/core/constants/theme_constants.dart';

import '../../../home/view.dart';
import '../register/view.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'string@gmail.com');
  final _passwordController = TextEditingController(text: 'string');
  bool _isObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      await ref.read(loginProvider.notifier).login();

      if (mounted) {
        final loginState = ref.read(loginProvider);
        if (loginState.status == LoginStatus.success) {
          // Başarılı giriş sonrası yönlendirme
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    // Tema renklerini al
    final backgroundColor = ThemeConstants.getBackgroundColor(ref);
    final primaryColor = ThemeConstants.getPrimaryColor(ref);
    final textColor = ThemeConstants.getTextColor(ref);
    final surfaceColor = ThemeConstants.getSurfaceColor(ref);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(ThemeConstants.defaultPadding),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Giriş Yap',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'E-posta',
                      labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: primaryColor.withOpacity(0.3)),
                        borderRadius:
                            BorderRadius.circular(ThemeConstants.defaultRadius),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius:
                            BorderRadius.circular(ThemeConstants.defaultRadius),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.shade300),
                        borderRadius:
                            BorderRadius.circular(ThemeConstants.defaultRadius),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.shade400),
                        borderRadius:
                            BorderRadius.circular(ThemeConstants.defaultRadius),
                      ),
                      filled: true,
                      fillColor: surfaceColor,
                    ),
                    style: TextStyle(color: textColor),
                    cursorColor: primaryColor,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: ref.read(loginProvider.notifier).updateEmail,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'E-posta adresi gerekli';
                      }
                      if (!value.contains('@')) {
                        return 'Geçerli bir e-posta adresi girin';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Şifre',
                      labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: primaryColor.withOpacity(0.3)),
                        borderRadius:
                            BorderRadius.circular(ThemeConstants.defaultRadius),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius:
                            BorderRadius.circular(ThemeConstants.defaultRadius),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.shade300),
                        borderRadius:
                            BorderRadius.circular(ThemeConstants.defaultRadius),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.shade400),
                        borderRadius:
                            BorderRadius.circular(ThemeConstants.defaultRadius),
                      ),
                      filled: true,
                      fillColor: surfaceColor,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          color: primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                    style: TextStyle(color: textColor),
                    cursorColor: primaryColor,
                    obscureText: _isObscure,
                    onChanged: ref.read(loginProvider.notifier).updatePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Şifre gerekli';
                      }
                      if (value.length < 6) {
                        return 'Şifre en az 6 karakter olmalı';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  if (loginState.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        loginState.error!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ElevatedButton(
                    onPressed: loginState.status == LoginStatus.loading
                        ? null
                        : _login,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(ThemeConstants.defaultRadius),
                      ),
                    ),
                    child: loginState.status == LoginStatus.loading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: textColor,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Giriş Yap',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/forgot-password');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                    ),
                    child: const Text('Şifremi Unuttum'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RegisterView(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                    ),
                    child: const Text('Hesabım Yok, Kayıt Ol'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
