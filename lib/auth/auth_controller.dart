import 'package:get/get.dart';
import '../home/home_view.dart';
import '../storage/token_storage.dart';
import 'auth_service.dart';

class AuthController extends GetxController {
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  final name = ''.obs;
  final email = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final isLogin = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> signup() async {
    if (password.value != confirmPassword.value) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    isLoading.value = true;
    final response = await AuthService().signup(
      name: name.value,
      email: email.value,
      password: password.value,
    );
    isLoading.value = false;

    if (response['status'] == 'success') {
      Get.snackbar("Success", response['message']);
    } else {
      // Custom message for user already exists
      if (response['message'].toString().toLowerCase().contains('409')) {
        Get.snackbar("Already Registered", "You are already registered. Try login.");
      } else {
        Get.snackbar("Failed", response['message']);
      }
    }
  }

  Future<void> login() async {
    isLoading.value = true;
    final response = await AuthService().login(
      email: email.value,
      password: password.value,
    );
    isLoading.value = false;

    final code = response['code'];

    if (response['status'] == 'success') {
      final token = response['token'];
      await TokenStorage.saveToken(token);
      await TokenStorage.saveCredentials(email.value, password.value);
      Get.snackbar("Success", response['message']);
      // Optional: navigation
      Get.offAll(() => HomeView());
    } else {
      if (response['message'].toString().toLowerCase().contains('401')) {
        Get.snackbar("Incorrect Password", "The password you entered is incorrect.");
      } else if (response['message'].toString().toLowerCase().contains('404')) {
        Get.snackbar("Invalid Email", "No user found with this email.");
      } else {
        Get.snackbar("Login Failed", response['message'] ?? "An error occurred.");
      }
    }
  }



}
