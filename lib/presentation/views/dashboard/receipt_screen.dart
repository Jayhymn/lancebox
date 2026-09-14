import 'package:flutter/material.dart';
import 'package:lance_box/app.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Receipts",
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const Icon(
                      Icons.receipt_long_outlined,
                      size: 48,
                      color: AppColors.disabled,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "No Receipts Yet",
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Your receipts will appear here",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.disabled,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
