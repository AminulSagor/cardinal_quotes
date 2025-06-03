import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_controller.dart';

class SignupView extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF1DC),
      body: Stack(
        children: [
          // Bottom image
          Obx(() => Transform.translate(
            offset: controller.isLogin.value
                ? Offset(0, -12.h)
                : Offset(0, -7.h),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Transform.scale(
                scale: 1.1,
                child: Image.asset(
                  'assets/signup_bottom.png',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          )),

          // Scrollable form content
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Transform.translate(
                    offset: Offset(110.w, -5.h),
                    child: Transform.scale(
                      scale: 1.1,
                      child: Image.asset(
                        'assets/signup_bird.png',
                        width: 150.w,
                      ),
                    ),
                  ),
                  SizedBox(height: controller.isLogin.value ? 30.h : 1.h),
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTabButton("Sign Up", !controller.isLogin.value,
                              () {
                            controller.isLogin.value = false;
                          }),
                      SizedBox(width: 16.w),
                      _buildTabButton("Log In", controller.isLogin.value,
                              () {
                            controller.isLogin.value = true;
                          }),
                    ],
                  )),
                  SizedBox(height: 30.h),
                  Obx(() {
                    return Column(
                      children: [
                        if (!controller.isLogin.value)
                          _buildTextField(
                            hint: "Enter your username",
                            onChanged: (val) => controller.name.value = val,
                          ),
                        _buildTextField(
                          hint: "Enter your email address",
                          onChanged: (val) => controller.email.value = val,
                        ),
                        Obx(() => _buildTextField(
                          hint: controller.isLogin.value
                              ? "Enter Password"
                              : "Create A Password",
                          obscure:
                          !controller.isPasswordVisible.value,
                          suffix: IconButton(
                            icon: Icon(
                                controller.isPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                            onPressed:
                            controller.togglePasswordVisibility,
                          ),
                          onChanged: (val) =>
                          controller.password.value = val,
                        )),
                        if (!controller.isLogin.value)
                          Obx(() => _buildTextField(
                            hint: "Confirm Password",
                            obscure: !controller
                                .isConfirmPasswordVisible.value,
                            suffix: IconButton(
                              icon: Icon(controller
                                  .isConfirmPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: controller
                                  .toggleConfirmPasswordVisibility,
                            ),
                            onChanged: (val) =>
                            controller.confirmPassword.value = val,
                          )),
                      ],
                    );
                  }),
                  SizedBox(height: 20.h),
                  Obx(() {
                    final bool isSignup = !controller.isLogin.value;
                    final bool canProceed = controller.email.value.isNotEmpty &&
                        controller.password.value.isNotEmpty &&
                        (isSignup ? controller.confirmPassword.value.isNotEmpty : true);

                    return ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.isLogin.value
                          ? controller.login
                          : controller.signup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: canProceed
                            ? const Color(0xFF844D38)
                            : const Color(0xFFD7886B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
                      ),
                      child: controller.isLoading.value
                          ? SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : Text(
                        "Next",
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                    );
                  }),

                  SizedBox(height: 120.h), // Add space so scroll doesn't cut
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(
      String label, bool isSelected, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor:
        isSelected ? const Color(0xFF844D38) : Colors.transparent,
        foregroundColor:
        isSelected ? Colors.white : const Color(0xFF844D38),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r)),
        side: BorderSide(color: const Color(0xFF844D38)),
        padding:
        EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      ),
      child: Text(label, style: TextStyle(fontSize: 14.sp)),
    );
  }

  Widget _buildTextField({
    required String hint,
    bool obscure = false,
    Widget? suffix,
    void Function(String)? onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: TextField(
        obscureText: obscure,
        onChanged: onChanged,
        style: TextStyle(fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white.withOpacity(0.6),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
          suffixIcon: suffix,
          contentPadding:
          EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        ),
      ),
    );
  }
}
