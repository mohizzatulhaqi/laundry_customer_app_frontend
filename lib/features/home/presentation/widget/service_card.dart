import 'package:flutter/material.dart';
import 'package:laundry_customer_app/core/theme/app_colors.dart';

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
        ),

        child: SizedBox(
          height: 120,
          width: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Icon(icon, size: 32, color: AppColors.customPrimaryBlue),
              const SizedBox(height: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
                maxLines: 2, // Batasi teks maksimal 2 baris
                overflow: TextOverflow
                    .ellipsis, // Tambahkan "..." jika teks terlalu panjang
              ),
            ],
          ),
        ),
      ),
    );
  }
}
