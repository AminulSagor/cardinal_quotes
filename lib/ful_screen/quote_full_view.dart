import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../combine_service/view_service.dart';
import 'quote_full_controller.dart';

class QuoteFullView extends StatelessWidget {
  final Map<String, dynamic> quote;

  QuoteFullView({super.key, required this.quote}) {
    Get.put(QuoteFullController()).setQuote(quote);
  }


  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuoteFullController>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              controller.type.value == 'text'
                  ? Center(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Text(
                    controller.text.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      height: 1.4,
                    ),
                  ),
                ),
              )
                  : Center(
                child: Image.network(
                  controller.background.value,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Icon(Icons.broken_image, color: Colors.white),
                ),
              ),
              Positioned(
                top: 16.h,
                left: 12.w,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close, color: Colors.white, size: 28),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
