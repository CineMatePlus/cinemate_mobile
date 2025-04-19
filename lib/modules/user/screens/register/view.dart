import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemate_mobile/core/constants/theme_constants.dart';
import '../login/view.dart';
import '../../../home/view.dart';
import 'state.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await ref.read(registerProvider.notifier).register();
        if (mounted) {
          final registerState = ref.read(registerProvider);
          if (registerState.status == RegisterStatus.success) {
            // Başarılı kayıt sonrası ana sayfaya yönlendirme
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          }
        }
      } catch (e) {
        // Hata zaten state'de tutuluyor
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerProvider);
    final registerNotifier = ref.read(registerProvider.notifier);

    // Tema renklerini al
    final backgroundColor = ThemeConstants.getBackgroundColor(ref);
    final primaryColor = ThemeConstants.getPrimaryColor(ref);
    final textColor = ThemeConstants.getTextColor(ref);
    final surfaceColor = ThemeConstants.getSurfaceColor(ref);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'Kayıt Ol',
          style: TextStyle(color: textColor),
        ),
        iconTheme: IconThemeData(color: primaryColor),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(ThemeConstants.defaultPadding),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    onChanged: registerNotifier.updateName,
                    style: TextStyle(color: textColor),
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      labelText: 'Ad Soyad',
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ad Soyad boş olamaz';
                      }
                      if (value.length < 3) {
                        return 'Ad Soyad en az 3 karakter olmalıdır';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    onChanged: registerNotifier.updateEmail,
                    style: TextStyle(color: textColor),
                    cursorColor: primaryColor,
                    keyboardType: TextInputType.emailAddress,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'E-posta adresi boş olamaz';
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
                    onChanged: registerNotifier.updatePassword,
                    obscureText: registerState.isObscure,
                    style: TextStyle(color: textColor),
                    cursorColor: primaryColor,
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
                          registerState.isObscure
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: primaryColor,
                        ),
                        onPressed: registerNotifier.toggleObscure,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Şifre boş olamaz';
                      }
                      if (value.length < 6) {
                        return 'Şifre en az 6 karakter olmalıdır';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  if (registerState.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        registerState.errorMessage!,
                        style: TextStyle(color: ThemeConstants.errorColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ElevatedButton(
                    onPressed: registerState.status == RegisterStatus.loading
                        ? null
                        : _register,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(ThemeConstants.defaultRadius),
                      ),
                    ),
                    child: registerState.status == RegisterStatus.loading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Kayıt Ol',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                    ),
                    child: const Text('Zaten hesabınız var mı? Giriş yapın'),
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
