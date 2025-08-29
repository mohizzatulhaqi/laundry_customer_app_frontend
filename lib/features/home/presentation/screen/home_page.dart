import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_customer_app/core/theme/app_colors.dart';
import 'package:laundry_customer_app/features/home/presentation/bloc/location_bloc.dart';
import 'package:laundry_customer_app/features/home/presentation/widget/banner_widget.dart';
import 'package:laundry_customer_app/features/home/presentation/widget/service_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late PageController _bannerController;

  final List<String> _searchHints = [
    "Cari layanan laundry",
    "Temukan laundry terdekat",
    "Cuci sepatu & tas",
    "Laundry kiloan murah",
    "Dry cleaning berkualitas",
    "Setrika express",
    "Laundry 24 jam",
  ];

  int _currentHintIndex = 0;
  String _currentHint = "";
  int _currentBannerIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _bannerController = PageController();
    _currentHint = _searchHints[0];
    _startHintAnimation();
    _startBannerAutoSlide();
  }

  void _startHintAnimation() {
    _animationController.forward().then((_) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          _animationController.reverse().then((_) {
            if (mounted) {
              setState(() {
                _currentHintIndex =
                    (_currentHintIndex + 1) % _searchHints.length;
                _currentHint = _searchHints[_currentHintIndex];
              });
              _startHintAnimation();
            }
          });
        }
      });
    });
  }

  void _startBannerAutoSlide() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _currentBannerIndex = (_currentBannerIndex + 1) % 3;
        _bannerController.animateToPage(
          _currentBannerIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _startBannerAutoSlide();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocationBloc()..add(GetLocationEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.customWhite,
          elevation: 0,
          centerTitle: false,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.location_on,
                color: AppColors.customPrimaryBlue,
                size: 28,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Lokasi Anda",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocBuilder<LocationBloc, LocationState>(
                        builder: (context, state) {
                          String locationText = "Mencari lokasi...";
                          if (state is LocationLoaded) {
                            locationText = state.address;
                          } else if (state is LocationError) {
                            locationText = "Lokasi gagal";
                          }
                          return Text(
                            locationText,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.customPrimaryBlue,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: AppColors.customPrimaryBlue,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.account_circle,
                size: 34,
                color: AppColors.customPrimaryBlue,
              ),
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(48.0),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: null,
                      hint: AnimatedBuilder(
                        animation: _fadeAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _fadeAnimation.value,
                            child: Text(
                              _currentHint,
                              style: TextStyle(
                                color: AppColors.textSubheading,
                                fontSize: 16,
                              ),
                            ),
                          );
                        },
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.customPrimaryBlue,
                        size: 24,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          // Filter action
                        },
                        icon: const Icon(
                          Icons.tune,
                          color: AppColors.customPrimaryBlue,
                          size: 24,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16.0,
                      ),
                    ),
                    style: const TextStyle(fontSize: 16),
                    onSubmitted: (value) {
                      // Handle search submission
                    },
                  ),
                ),
              ),

              // Hero Banner/Carousel
              Container(
                height: 180,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: PageView(
                  controller: _bannerController,
                  children: const [
                    BannerCard(
                      title: "Diskon 30% Cuci Kiloan",
                      subtitle: "Minimal 5kg, berlaku sampai 31 Agustus",
                      color: Colors.blue,
                      icon: Icons.local_laundry_service,
                    ),
                    BannerCard(
                      title: "Gratis Pickup & Delivery",
                      subtitle: "Untuk pembelian di atas 50rb",
                      color: Colors.green,
                      icon: Icons.local_shipping,
                    ),
                    BannerCard(
                      title: "Express Service 3 Jam",
                      subtitle: "Cuci setrika dalam 3 jam saja",
                      color: Colors.orange,
                      icon: Icons.timer,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // Tambahkan childAspectRatio untuk mengontrol tinggi item
                  childAspectRatio:
                      0.8, // Nilai ini akan membuat item lebih tinggi
                  children: [
                    ServiceCard(
                      icon: Icons.local_laundry_service,
                      title: "Cuci Kiloan",
                      onTap: () {},
                    ),
                    ServiceCard(
                      icon: Icons.cleaning_services,
                      title: "Dry Clean",
                      onTap: () {},
                    ),
                    ServiceCard(
                      icon: Icons.access_time,
                      title: "Cuci Express ",
                      onTap: () {},
                    ),
                    ServiceCard(
                      icon: Icons.directions_run,
                      title: "Laundry Sepatu",
                      onTap: () {},
                    ),
                    ServiceCard(
                      icon: Icons.backpack,
                      title: "Laundry Tas",
                      onTap: () {},
                    ),
                    ServiceCard(
                      icon: Icons.checkroom,
                      title: "Laundry Luaran",
                      onTap: () {},
                    ),
                    ServiceCard(
                      icon: Icons.inventory_2,
                      title: "Laundry Satuan",
                      onTap: () {},
                    ),
                    ServiceCard(
                      icon: Icons.iron,
                      title: "Jasa Setrika",
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.customPrimaryBlue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            color: AppColors.customPrimaryBlue,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
              label: 'Promo',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          ],
        ),
      ),
    );
  }
}
