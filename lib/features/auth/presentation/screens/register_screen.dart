import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundry_customer_app/core/theme/app_colors.dart';
import 'package:laundry_customer_app/features/auth/presentation/widgets/primary_button.dart';
import 'package:laundry_customer_app/features/auth/presentation/widgets/phone_input_field.dart';
import 'package:laundry_customer_app/features/auth/presentation/widgets/name_input_field.dart';
import 'package:laundry_customer_app/features/auth/presentation/widgets/email_input_field.dart';
import 'package:laundry_customer_app/main.dart';

// Step 1: Phone Number Input
class RegisterPhonePage extends StatefulWidget {
  const RegisterPhonePage({super.key});

  @override
  State<RegisterPhonePage> createState() => _RegisterPhonePageState();
}

class _RegisterPhonePageState extends State<RegisterPhonePage> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();
  bool _isLoading = false;

  void _sendOTP() async {
    final phone = _phoneController.text.trim();

    if (phone.isEmpty) {
      _showSnackBar('Nomor HP tidak boleh kosong');
      return;
    }

    if (phone.length < 10) {
      _showSnackBar('Nomor HP minimal 10 digit');
      return;
    }

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterOTPPage(phoneNumber: phone),
        ),
      );
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: message.contains('berhasil')
            ? Colors.green
            : Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.customWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 16),

                // Header with back button
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back, size: 20),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.02),

                // Country Selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 20,
                            height: 15,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Flag_of_Indonesia.svg/1000px-Flag_of_Indonesia.svg.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.03),

                // Illustration
                Container(
                  height: size.height * 0.32,
                  child: Stack(
                    children: [
                      // Background shapes
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            color: AppColors.customPrimaryBlue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(80),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: AppColors.customPrimaryBlue.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(45),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: AppColors.customPrimaryBlue.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                      ),
                      // Main illustration
                      Center(
                        child: Container(
                          width: 260,
                          height: 260,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(130),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person_add,
                            size: 220,
                            color: AppColors.customPrimaryBlue,
                          ),
                        ),
                      ),
                      // Decorative dots
                      Positioned(
                        top: 50,
                        left: 50,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.customPrimaryBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 70,
                        right: 70,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppColors.customPrimaryBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                // Title
                Text(
                  'Buat Akun Baru',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Daftarkan nomor HP untuk membuat akun',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSubheading,
                  ),
                ),

                const SizedBox(height: 32),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PhoneInputField(
                      controller: _phoneController,
                      focusNode: _phoneFocus,
                      onChanged: (value) => setState(() {}),
                      onSubmitted: (_) => _sendOTP(),
                    ),
                  ],
                ),

                const SizedBox(height: 26),

                // Continue Button
                const SizedBox(height: 24),
                PrimaryButton(
                  text: 'Lanjut',
                  onPressed: _sendOTP,
                  isLoading: _isLoading,
                  width: double.infinity,
                ),

                const SizedBox(height: 14),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun? ',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        'Masuk Sekarang',
                        style: TextStyle(
                          color: AppColors.customPrimaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Step 2: OTP Verification
class RegisterOTPPage extends StatefulWidget {
  const RegisterOTPPage({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<RegisterOTPPage> createState() => _RegisterOTPPageState();
}

class _RegisterOTPPageState extends State<RegisterOTPPage> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _otpFocus = List.generate(4, (index) => FocusNode());

  int _resendTimer = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          if (_resendTimer > 0) {
            _resendTimer--;
          }
        });
      }
      return _resendTimer > 0 && mounted;
    }).then((_) {
      if (mounted) {
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  void _verifyOTP() async {
    final otp = _otpControllers.map((c) => c.text).join();

    if (otp.length != 4) {
      _showSnackBar('Masukkan kode OTP lengkap');
      return;
    }

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              RegisterNamePage(phoneNumber: widget.phoneNumber),
        ),
      );
    }
  }

  void _resendOTP() {
    if (!_canResend) return;

    setState(() {
      _canResend = false;
      _resendTimer = 30;
    });
    _startResendTimer();

    _showSnackBar('Kode OTP telah dikirim ulang');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: message.contains('dikirim')
            ? Colors.green
            : Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focus in _otpFocus) {
      focus.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back, size: 20),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'OTP',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),

              SizedBox(height: size.height * 0.08),

              // Illustration (sama seperti OTP login)
              Container(
                height: size.height * 0.25,
                child: Stack(
                  children: [
                    // Background shapes with different colors
                    Positioned(
                      top: 20,
                      right: 40,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.customPrimaryBlue.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 30,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.customPrimaryBlue.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    // Phone/SMS illustration
                    Center(
                      child: Stack(
                        children: [
                          // Phone container
                          Container(
                            width: 180,
                            height: 220,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Container(
                                  width: 140,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    color: AppColors.customPrimaryBlue
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.sms,
                                    color: AppColors.customPrimaryBlue,
                                    size: 68,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: 60,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  width: 40,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Message bubble
                          Positioned(
                            right: -20,
                            top: 40,
                            child: Container(
                              width: 80,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.customPrimaryBlue,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  '1234',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Decorative dots
                    Positioned(
                      top: 40,
                      left: 50,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.customPrimaryBlue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      right: 60,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.customPrimaryBlue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.04),

              // Title
              const Text(
                'Kode Verifikasi',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Masukkan OTP yang kami kirim',
                style: TextStyle(fontSize: 16, color: AppColors.textSubheading),
              ),
              const SizedBox(height: 4),
              Text(
                'ke nomer +62${widget.phoneNumber}',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textSubheading,
                ),
              ),

              const SizedBox(height: 38),

              // OTP Input
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _otpControllers[index],
                      focusNode: _otpFocus[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColors.customPrimaryBlue,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          _otpFocus[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          _otpFocus[index - 1].requestFocus();
                        }
                        final otp = _otpControllers.map((c) => c.text).join();
                        if (otp.length == 4) {
                          _verifyOTP();
                          FocusScope.of(context).unfocus();
                        }
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 35),

              // Resend OTP Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tidak menerima kode? ',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSubheading,
                    ),
                  ),
                  GestureDetector(
                    onTap: _canResend ? _resendOTP : null,
                    child: Text(
                      _canResend
                          ? 'Kirim Ulang'
                          : 'Kirim Ulang lagi dalam ($_resendTimer)',
                      style: TextStyle(
                        fontSize: 14,
                        color: _canResend
                            ? AppColors.customPrimaryBlue
                            : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

// Step 3: Name Input
class RegisterNamePage extends StatefulWidget {
  const RegisterNamePage({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<RegisterNamePage> createState() => _RegisterNamePageState();
}

class _RegisterNamePageState extends State<RegisterNamePage> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  bool _isLoading = false;

  void _continueToEmail() async {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      _showSnackBar('Nama tidak boleh kosong');
      return;
    }

    if (name.length < 2) {
      _showSnackBar('Nama minimal 2 karakter');
      return;
    }

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              RegisterEmailPage(phoneNumber: widget.phoneNumber, name: name),
        ),
      );
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.customWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 16),

                // Header
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back, size: 20),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Nama Lengkap',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),

                SizedBox(height: size.height * 0.05),

                // Illustration
                Container(
                  height: size.height * 0.35,
                  child: Stack(
                    children: [
                      // Background shapes
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            color: AppColors.customPrimaryBlue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors.customPrimaryBlue.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.customPrimaryBlue.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                      // Main illustration
                      Center(
                        child: Container(
                          width: 290,
                          height: 290,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(180),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 250,
                            color: AppColors.customPrimaryBlue,
                          ),
                        ),
                      ),
                      // Decorative dots
                      Positioned(
                        top: 60,
                        left: 60,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.customPrimaryBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 80,
                        right: 80,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppColors.customPrimaryBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                // Title
                Text(
                  'Siapa Nama Kamu?',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Masukkan nama lengkap untuk melanjutkan',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSubheading,
                  ),
                ),

                const SizedBox(height: 32),

                NameInputField(
                  controller: _nameController,
                  focusNode: _nameFocus,
                  onChanged: (value) => setState(() {}),
                  onSubmitted: (_) => _continueToEmail(),
                ),

                const SizedBox(height: 26),

                // Continue Button
                PrimaryButton(
                  text: 'Lanjut',
                  onPressed: _continueToEmail,
                  isLoading: _isLoading,
                  isDisabled: _nameController.text.trim().length < 2,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Step 4: Email Input
class RegisterEmailPage extends StatefulWidget {
  const RegisterEmailPage({
    super.key,
    required this.phoneNumber,
    required this.name,
  });

  final String phoneNumber;
  final String name;

  @override
  State<RegisterEmailPage> createState() => _RegisterEmailPageState();
}

class _RegisterEmailPageState extends State<RegisterEmailPage> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  bool _isLoading = false;

  bool _isValidEmail(String email) {
    // Kode RegExp yang diperbaiki
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _completeRegistration() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showSnackBar('Email tidak boleh kosong');
      return;
    }

    if (!_isValidEmail(email)) {
      _showSnackBar('Format email tidak valid');
      return;
    }

    setState(() => _isLoading = true);

    // Simulate API call for registration
    await Future.delayed(const Duration(seconds: 3));

    setState(() => _isLoading = false);

    if (mounted) {
      _showSnackBar('Akun berhasil dibuat! Silakan login.');

      // Navigate back to login or main app
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
        (route) => false,
      );
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: message.contains('berhasil')
            ? Colors.green
            : Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.customWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 16),

                // Header
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back, size: 20),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Alamat Email',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),

                SizedBox(height: size.height * 0.05),

                // Illustration
                Container(
                  height: size.height * 0.35,
                  child: Stack(
                    children: [
                      // Background shapes
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            color: AppColors.customPrimaryBlue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors.customPrimaryBlue.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.customPrimaryBlue.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                      // Main illustration
                      Center(
                        child: Container(
                          width: 290,
                          height: 290,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(180),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.email,
                            size: 250,
                            color: AppColors.customPrimaryBlue,
                          ),
                        ),
                      ),
                      // Decorative dots
                      Positioned(
                        top: 60,
                        left: 60,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.customPrimaryBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 80,
                        right: 80,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppColors.customPrimaryBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                // Title
                Text(
                  'Hampir Selesai!',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Masukkan alamat email untuk menyelesaikan pendaftaran',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSubheading,
                  ),
                ),

                const SizedBox(height: 32),

                EmailInputField(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  onChanged: (value) => setState(() {}),
                  onSubmitted: (_) =>
                      _isValidEmail(_emailController.text.trim())
                      ? _completeRegistration()
                      : null,
                ),

                const SizedBox(height: 26),

                // Complete Registration Button
                PrimaryButton(
                  text: 'Selesai',
                  onPressed: _completeRegistration,
                  isLoading: _isLoading,
                  isDisabled: !_isValidEmail(_emailController.text.trim()),
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
