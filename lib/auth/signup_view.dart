import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_controller.dart';

class SignupView extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBC2A0D),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Transform.scale(
                  scale: 1.49,
                  child: Image.asset(
                    'assets/top_signup_login_bird.png',
                    width: 250.w,
                  ),
                ),

                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => controller.isLogin.value = false,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: controller.isLogin.value ? Colors.transparent : Colors.white,
                        foregroundColor: controller.isLogin.value ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        side: BorderSide(color: Colors.white),
                      ),
                      child: Text("Sign Up"),
                    ),
                    SizedBox(width: 12.w),
                    OutlinedButton(
                      onPressed: () => controller.isLogin.value = true,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: controller.isLogin.value ? Colors.white : Colors.transparent,
                        foregroundColor: controller.isLogin.value ? Colors.black : Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        side: BorderSide(color: Colors.white),
                      ),
                      child: Text("Log In"),
                    ),
                  ],
                )),

                SizedBox(height: 20.h),

                // Fields
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
                        hint: controller.isLogin.value ? "Enter Password" : "Create A Password",
                        obscure: !controller.isPasswordVisible.value,
                        suffix: IconButton(
                          icon: Icon(controller.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                        onChanged: (val) => controller.password.value = val,
                      )),
                      if (!controller.isLogin.value)
                        Obx(() => _buildTextField(
                          hint: "Confirm Password",
                          obscure: !controller.isConfirmPasswordVisible.value,
                          suffix: IconButton(
                            icon: Icon(controller.isConfirmPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: controller.toggleConfirmPasswordVisibility,
                          ),
                          onChanged: (val) => controller.confirmPassword.value = val,
                        )),
                    ],
                  );
                }),

                SizedBox(height: 20.h),

                // Submit Button
                Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.isLogin.value
                      ? controller.login
                      : controller.signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD7886B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  ),
                  child: controller.isLoading.value
                      ? SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                      : Text("Next"),
                )),

                Obx(() => Transform.translate(
                  offset: controller.isLogin.value ? Offset(0, 80.h) : Offset(0, 10.h),
                  child: Transform.scale(
                    scale: 1.3,
                    child: Image.asset(
                      'assets/bottom_signup_login_bird.png',
                      width: 300.w,
                    ),
                  ),
                )),

              ],
            ),
          ),
        ),
      ),
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
          suffixIcon: suffix,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        ),
      ),
    );
  }
}
