import 'package:ewa_kit/ewa_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Login form example showcasing EwaTextField, EwaValidators, and EwaButton.
class LoginExampleScreen extends StatefulWidget {
  const LoginExampleScreen({super.key});

  @override
  State<LoginExampleScreen> createState() => _LoginExampleScreenState();
}

class _LoginExampleScreenState extends State<LoginExampleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() => _isLoading = false);

    final email = _emailController.text;
    final password = _passwordController.text;

    // Demo: accept test@example.com / password123
    if (email == 'test@example.com' && password == 'password123') {
      EwaToast.showSuccess(context, 'Login berhasil!');
    } else {
      EwaToast.showError(
        context,
        'Email atau password salah. Coba: test@example.com / password123',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Form Example'),
        backgroundColor: EwaColorFoundation.getPrimary(context),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.r),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 32.h),
                Icon(
                  Icons.login_rounded,
                  size: 64.sp,
                  color: EwaColorFoundation.getPrimary(context),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Selamat Datang',
                  textAlign: TextAlign.center,
                  style: EwaTypography.heading2Xl(),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Masukkan email dan password Anda',
                  textAlign: TextAlign.center,
                  style: EwaTypography.body().copyWith(
                    color: EwaColorFoundation.resolveColor(
                      context,
                      EwaColorFoundation.neutral500,
                      EwaColorFoundation.neutral400,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                EwaTextField.primary(
                  controller: _emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icon(Icons.email_outlined, size: 20.sp),
                  validator: (value) => EwaValidators.combine(
                    [
                      (v) => EwaValidators.required(v, 'Email wajib diisi'),
                      (v) => EwaValidators.email(v, 'Format email tidak valid'),
                    ],
                    value,
                  ),
                  onSubmitted: (_) => _passwordFocusNode.requestFocus(),
                ),
                SizedBox(height: 16.h),
                EwaTextField.primary(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  hintText: 'Password',
                  obscureText: _obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icon(Icons.lock_outline, size: 20.sp),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      size: 20.sp,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                  validator: (value) => EwaValidators.combine(
                    [
                      (v) => EwaValidators.required(v, 'Password wajib diisi'),
                      (v) => EwaValidators.minLength(
                        6,
                        v,
                        'Password minimal 6 karakter',
                      ),
                    ],
                    value,
                  ),
                  onSubmitted: (_) => _handleLogin(),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Demo: test@example.com / password123',
                  style: EwaTypography.bodyXs().copyWith(
                    color: EwaColorFoundation.resolveColor(
                      context,
                      EwaColorFoundation.neutral500,
                      EwaColorFoundation.neutral400,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                EwaButton.primary(
                  label: _isLoading ? 'Memproses...' : 'Login',
                  onPressed: _isLoading ? null : _handleLogin,
                  leading: _isLoading ? EwaLoading.bouncingDots(size: 18) : null,
                ),
                SizedBox(height: 16.h),
                EwaButton.tertiary(
                  label: 'Lupa Password?',
                  onPressed: () async {
                    EwaToast.showInfo(context, 'Fitur belum tersedia');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
