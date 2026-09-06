import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';
import '../../../../../../core/modules/auth/state.dart';
import '../../../../../../core/modules/auth/screens/register/state.dart';
import '../../../../routes/route_name.dart';

class RegisterScreen extends ConsumerWidget {
  final void Function()? onRegisterSuccess;
  final Widget? logo;
  final ThemeData? theme;
  final String? title;
  final bool showAppBar;

  const RegisterScreen({
    super.key,
    this.onRegisterSuccess,
    this.logo,
    this.theme,
    this.title = '',
    this.showAppBar = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerProvider);
    final registerNotifier = ref.read(registerProvider.notifier);
    final authState = ref.watch(authProvider);

    // Başarılı kayıt durumunu izle
    ref.listen(authProvider, (previous, current) {
      if (current.status == AuthStatus.error && current.errorMessage != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(current.errorMessage!)));
      }
      if (previous?.status != AuthStatus.authenticated &&
          current.status == AuthStatus.authenticated) {
        // Başarılı kayıt sonrası authProvider state'i authenticated olacak.
        // go_router redirect bunu algılayıp homePath'e yönlendirecek.
        // Bu yüzden burada ek bir Navigator.pushReplacement veya onRegisterSuccess callback'i çağırmaya gerek yok.
        if (onRegisterSuccess != null) {
          // Geriye uyumluluk için veya özel bir durum varsa çağrılabilir ama genellikle gereksiz.
          debugPrint("Register başarılı, go_router yönlendirecek...");
          // onRegisterSuccess!(); // Bu satır kaldırılabilir
        }
      }
    });

    final effectiveTheme = theme ?? Theme.of(context);

    return Theme(
      data: effectiveTheme,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: showAppBar
            ? AppBar(
                title: Text(
                  title!,
                  style: AppTextStyles.heading4.withColor(AppColors.black87),
                ),
                backgroundColor: AppColors.white,
                centerTitle: true,
                elevation: 0,
                iconTheme: const IconThemeData(color: AppColors.black87),
              )
            : null,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo Alanı
                  Container(
                    margin: const EdgeInsets.only(top: 40, bottom: 40),
                    child: logo ?? _buildLogo(),
                  ),

                  // Form Alanı - Kart olmadan direkt form
                  RegisterForm(
                    state: registerState,
                    notifier: registerNotifier,
                    authState: authState,
                    onLoginTap: () {
                      context.go(loginPath);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        _buildLogoIcon(),
        const SizedBox(height: 10),
        Text(
          'CineMate',
          style: AppTextStyles.logo.withColor(AppColors.black87),
        ),
      ],
    );
  }

  Widget _buildLogoIcon() {
    return const Icon(
      Icons.movie_filter_outlined,
      size: 70,
      color: AppColors.primary,
    );
  }
}

// Form Widget'ı
class RegisterForm extends StatefulWidget {
  final RegisterState state;
  final RegisterNotifier notifier;
  final AuthState authState;
  final VoidCallback? onLoginTap;

  const RegisterForm({
    super.key,
    required this.state,
    required this.notifier,
    required this.authState,
    this.onLoginTap,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.state.name);
    _emailController = TextEditingController(text: widget.state.email);
    _passwordController = TextEditingController(text: widget.state.password);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        widget.state.isLoading || widget.authState.status == AuthStatus.loading;

    return Form(
      key: widget.state.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            controller: _nameController,
            label: 'Ad Soyad',
            icon: Icons.person_outline,
            onChanged: widget.notifier.setName,
            validator: (value) =>
                value!.isEmpty ? 'Lütfen adınızı girin' : null,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _emailController,
            label: 'E-posta Adresi',
            icon: Icons.email_outlined,
            onChanged: widget.notifier.setEmail,
            validator: (value) => value!.isEmpty || !value.contains('@')
                ? 'Geçerli bir e-posta girin'
                : null,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _passwordController,
            label: 'Şifre',
            icon: Icons.lock_outline,
            onChanged: widget.notifier.setPassword,
            validator: (value) =>
                value!.length < 6 ? 'Şifre en az 6 karakter olmalı' : null,
            obscureText: true,
          ),
          const SizedBox(height: 16),
          _buildGenderDropdown(),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: isLoading ? null : () => widget.notifier.register(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                disabledBackgroundColor: Colors.grey[400],
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'KAYIT OL',
                      style: AppTextStyles.buttonLarge
                          .withWeight(FontWeight.bold)
                          .withLetterSpacing(0.5),
                    ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.bodyMedium.withColor(AppColors.textGrey),
                children: [
                  const TextSpan(text: 'Zaten bir hesabın var mı? '),
                  TextSpan(
                    text: 'Giriş Yap',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onLoginTap,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<int>(
      initialValue: widget.state.gender,
      onChanged: (value) {
        if (value != null) {
          widget.notifier.setGender(value);
        }
      },
      items: const [
        DropdownMenuItem(value: 0, child: Text('Kadın')),
        DropdownMenuItem(value: 1, child: Text('Erkek')),
        DropdownMenuItem(value: 2, child: Text('Diğer')),
      ],
      decoration: InputDecoration(
        labelText: 'Cinsiyet',
        prefixIcon: const Icon(Icons.wc_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required void Function(String) onChanged,
    String? Function(String?)? validator,
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.darkTextGrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black87, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE53935)),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        labelStyle: AppTextStyles.inputLabel,
      ),
      style: AppTextStyles.inputText,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
    );
  }
}
