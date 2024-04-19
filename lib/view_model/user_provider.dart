import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialscan/utils/info_snackbar.dart';
import 'package:socialscan/utils/lists/pick_image.dart';
import 'package:socialscan/utils/services/firebase_services.dart';
import 'package:socialscan/views/auth/screens/sign_in_screen.dart';

import '../models/user_model.dart';
import '../views/home/screens/home_sceen.dart';

class UserProvider extends ChangeNotifier {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController profession = TextEditingController();
  final _auth = FirebaseAuth.instance;

  final FirebaseService _authService = FirebaseService();

  UserModel? _userModel;
  Uint8List? image;

  bool isLoading = false;
  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;
  // bool get isObscure => _isObscure;
  UserModel? get userModel => _userModel;

  Future<void> updateUserDetails() async {
    print('Updating user details');
    try {
      UserModel? userModel = await _authService.getUserDetails();

      if (userModel != null) {
        print('User model: $userModel');
        _userModel = userModel;
        notifyListeners();
      } else {
        print('No signed-in user. Clearing user details.');
        _userModel = null;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating user details: $e');
      rethrow;
    }
  }

  selectProfilePic([ImageSource? imageSource]) async {
    Uint8List? img = await pickImage(imageSource ?? ImageSource.gallery);
    image = img;
    notifyListeners();
  }

  Future<void> isLoggedIn() async {
    _auth.authStateChanges().listen((User? user) {
      // log("isLoggedIn $user");
      if (user == null) {
        _isSignedIn = false;
      } else {
        _isSignedIn = true;
      }
    });
    notifyListeners();
  }

  Future<void> registerAccount(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 2));
      String res = await _authService.createUser(
          email: emailController.text,
          firstName: firstName.text,
          lastName: lastName.text,
          password: passwordController.text,
          profession: profession.text,
          context: context,
          phoneNumber: phoneNumber.text);

      isLoading = false;
      notifyListeners();
      if (res != 'success') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
            (route) => false);
        log('Signing up Successful');
      }
    } catch (error) {
      log('Register account ===> $error');
    }
    emailController.clear();
    passwordController.clear();
    firstName.clear();
    lastName.clear();
    phoneNumber.clear();
    notifyListeners();
  }

  Future<void> signIn(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 2));

      String res = await _authService.loginUser(
          email: emailController.text,
          password: passwordController.text,
          context: context);

      isLoading = false;
      notifyListeners();
      if (res == 'Successful') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
        log('Login successful');
      }
    } catch (error) {
      log('Sign in error ====> $error');
    }
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
          (route) => false);

      infoSnackBar(
          context, 'Sign-Out successful', const Duration(milliseconds: 400));
    } catch (e) {
      print('Failed to sign out: $e');
    }
  }
}
