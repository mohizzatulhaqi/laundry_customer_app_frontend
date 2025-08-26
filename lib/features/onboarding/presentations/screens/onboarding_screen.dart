import 'package:flutter/material.dart';
import 'package:laundry_customer_app/features/onboarding/presentations/widgets/onboarding_button.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key, this.onFinish});

  final VoidCallback? onFinish;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<_OnboardContent> _pages = const [
    _OnboardContent(
      title: 'Welcome',
      subtitle:
          'Selamat datang di aplikasi Laundry. Mudah, cepat, dan terpercaya.',
      lottieAsset: 'assets/lottie/onboarding1.json',
    ),
    _OnboardContent(
      title: 'Pick-Up & Delivery',
      subtitle: 'Kami jemput dan antar cucian Anda tepat waktu.',
      lottieAsset: 'assets/lottie/onboarding2.json',
    ),
    _OnboardContent(
      title: 'Track Orders',
      subtitle: 'Pantau status cucian secara real-time dari ponsel Anda.',
      lottieAsset: 'assets/lottie/onboarding4.json',
    ),
  ];

  void _next() {
    if (_currentIndex < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      _finish();
    }
  }

  void _skip() {
    _controller.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _finish() {
    // If host provides a finish handler, use it. Otherwise try pop.
    if (widget.onFinish != null) {
      widget.onFinish!();
      return;
    }
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_currentIndex < _pages.length - 1)
                    TextButton(onPressed: _skip, child: const Text('Lewati')),
                ],
              ),
            ),
            // Pages
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _currentIndex = i),
                itemBuilder: (context, index) {
                  final p = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Stack(
                      children: [
                        // Lottie animation layer (background) - posisi tetap
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 200,
                          child: Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Background lingkaran tetap kecil
                                Container(
                                  width: 180,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primaryContainer,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                // Lottie besar di atas lingkaran
                                Lottie.asset(
                                  p.lottieAsset!,
                                  width: 1000,
                                  height: 1000,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Text layer (foreground) - posisi tetap
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 120, // Jarak dari bawah - bisa disesuaikan
                          child: Column(
                            children: [
                              Text(
                                p.title,
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                p.subtitle,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.textTheme.bodyMedium?.color,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Indicators
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (i) => _Dot(active: i == _currentIndex),
                ),
              ),
            ),
            // Bottom button
            PrimaryButton(
              label: _currentIndex == _pages.length - 1 ? 'Mulai' : 'Lanjut',
              onPressed: _next,
              margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.active});
  final bool active;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: active ? 22 : 8,
      decoration: BoxDecoration(
        color: active
            ? theme.colorScheme.primary
            : theme.colorScheme.primary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}

class _OnboardContent {
  const _OnboardContent({
    required this.title,
    required this.subtitle,
    this.lottieAsset,
  });
  final String title;
  final String subtitle;
  final String? lottieAsset;
}
