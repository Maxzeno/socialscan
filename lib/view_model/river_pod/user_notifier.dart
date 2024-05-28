import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialscan/utils/lists/selected_socials_to_send_list.dart';

import '../../bottom_nav_screen.dart';
import '../../models/social_link_model.dart';
import '../../models/user_model.dart';
import '../../utils/info_snackbar.dart';
import '../../utils/lists/pick_image.dart';
import '../../utils/services/firebase_services.dart';
import '../../utils/shared_prefrences.dart';
import '../../views/auth/screens/sign_in_screen.dart';

class UserState {
  final UserModel? userModel;
  final Uint8List? image;
  final CountryCode? countryCode;
  final bool isLoading;
  final bool isSignedIn;
  final List<SocialLinkModel> selectedSocials;
  final bool isGoogleAccount;
  UserState({
    this.userModel,
    this.image,
    this.countryCode,
    this.isLoading = false,
    this.isSignedIn = false,
    this.selectedSocials = const [],
    this.isGoogleAccount = false,
    // this.selectedSocials = const [],
  });

  UserState copyWith({
    UserModel? userModel,
    Uint8List? image,
    CountryCode? countryCode,
    bool? isLoading,
    bool? isSignedIn,
    List<SocialLinkModel>? selectedSocials,
    bool? isGoogleAccount,
  }) {
    return UserState(
      userModel: userModel ?? this.userModel,
      image: image ?? this.image,
      countryCode: countryCode ?? this.countryCode,
      isLoading: isLoading ?? this.isLoading,
      isSignedIn: isSignedIn ?? this.isSignedIn,
      selectedSocials: selectedSocialsToSendList ?? this.selectedSocials,
      isGoogleAccount: isGoogleAccount ?? this.isGoogleAccount,
    );
  }
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(UserState());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseService _authService = FirebaseService();
  final countryPicker = const FlCountryCodePicker();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController professionController = TextEditingController();

  Future<void> updateUserDetails() async {
    log('Updating user details');
    try {
      UserModel? userModel = await _authService.getUserDetails();

      if (userModel != null) {
        log('User model: $userModel');

        state = state.copyWith(
          userModel: userModel,
        );
      } else {
        log('No signed-in user. Clearing user details.');
        state = state.copyWith(
          userModel: null,
        );
      }
    } catch (e) {
      log('Error updating user details: $e');
      rethrow;
    }
  }

  Future<void> selectProfilePic([ImageSource? imageSource]) async {
    Uint8List? img = await pickImage(imageSource ?? ImageSource.gallery);
    state = state.copyWith(image: img);
  }

  Future<void> isLoggedIn() async {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        state = state.copyWith(isSignedIn: false);
      } else {
        state = state.copyWith(isSignedIn: true);
      }
    });
  }

  Future<void> registerAccount(BuildContext context) async {
    try {
      state = state.copyWith(isLoading: true);

      await Future.delayed(const Duration(seconds: 2));
      String res = await _authService.createUser(
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        password: passwordController.text,
        profession: professionController.text,
        context: context,
        phoneNumber:
            '${state.countryCode!.dialCode}-${phoneNumberController.text}',
      );

      state = state.copyWith(isLoading: false);
      if (res != 'success') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
          (route) => false,
        );
        log('Signing up Successful');
      }
    } catch (error) {
      log('Register account ===> $error');
    }
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    phoneNumberController.clear();
    professionController.clear();
    retypePasswordController.clear();
    state = state.copyWith(countryCode: null);
  }

  Future<void> registerWithGoogle(BuildContext context) async {
    try {
      state = state.copyWith(isLoading: true);

      await Future.delayed(const Duration(seconds: 2));
      String res = await _authService.signInWithGoogle(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        context: context,
        password: passwordController.text,
        profession: professionController.text,
        phoneNumber:
            '${state.countryCode!.dialCode}-${phoneNumberController.text}',
      );

      state = state.copyWith(isLoading: false);
      if (res != 'success') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BottomNav()),
          (route) => false,
        );
        log('Signing up Successful');
      }
    } catch (error) {
      log('Register account ===> $error');
    }
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    phoneNumberController.clear();
    professionController.clear();
    retypePasswordController.clear();
    state = state.copyWith(countryCode: null);
  }

  Future<void> signIn(BuildContext context) async {
    try {
      state = state.copyWith(isLoading: true);

      await Future.delayed(const Duration(seconds: 2));

      String res = await _authService.loginUser(
        email: emailController.text,
        password: passwordController.text,
        context: context,
      );

      state = state.copyWith(isLoading: false);
      if (res == 'Successful') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BottomNav()),
          (route) => false,
        );
        log('Login successful');
      }
    } catch (error) {
      log('Sign in error ====> $error');
    }
    emailController.clear();
    passwordController.clear();
  }

  Future<void> signOut(BuildContext context) async {
    try {
      // await GoogleSignIn().signOut();

      await FirebaseAuth.instance.signOut();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
        (route) => false,
      );

      infoSnackBar(
          context, 'Sign-Out successful', const Duration(milliseconds: 400));
    } catch (e) {
      log('Failed to sign out: $e');
    }
  }

  Future<void> selectCountryCode(BuildContext context) async {
    final code = await countryPicker.showPicker(context: context);
    if (code != null) {
      state = state.copyWith(countryCode: code);
    }
  }

  Future<void> checkGoogleUser() async {
    bool isGoogleAccount =
        await CompleteAccountPreference().isAccountSetupComplete();
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null && isGoogleAccount) {
      bool isGoogleSignIn = false;
      for (UserInfo userInfo in currentUser.providerData) {
        if (userInfo.providerId == GoogleAuthProvider.GOOGLE_SIGN_IN_METHOD) {
          isGoogleSignIn = true;
          break;
        }
      }
      print('Account is Google sign-in: $isGoogleSignIn');
      state = state.copyWith(isGoogleAccount: isGoogleSignIn);
    } else {
      state = state.copyWith(isGoogleAccount: false);
    }
  }

  void selectSocialToQrCode(bool isSelected, dynamic data, int index) {
    final updatedSelectedSocials = selectedSocialsToSendList; // Create a copy
    if (isSelected) {
      updatedSelectedSocials.add(
        SocialLinkModel(
          text: data.text,
          imagePath: data.imagePath,
          conColor: data.conColor,
          iconColor: data.iconColor,
          linkUrl: data.linkUrl,
        ),
      );
    } else {
      updatedSelectedSocials.removeWhere((item) => item.text == data.text);
    }

    state = state.copyWith(selectedSocials: updatedSelectedSocials);
    print('Checking added lists ====> $selectedSocialsToSendList');

    // Update the state using the provider's update method (e.g., ref.read(userProvider).update((state) => state.copyWith(selectedSocials: updatedSelectedSocials)))
  }

// void selectSocialToQrCode(bool isSelected, dynamic data, int index) {
  //   if (isSelected) {
  //     state.selectedSocials.add(
  //       SocialLinkModel(
  //         text: data.text,
  //         imagePath: data.imagePath,
  //         conColor: data.conColor,
  //         iconColor: data.iconColor,
  //         linkUrl: data.linkUrl,
  //       ),
  //     );
  //     log("Social added: ${state.selectedSocials}");
  //   } else {
  //     log('checking');
  //     state.selectedSocials.removeWhere((item) => item.text == data.text);
  //     log("Social removed: ${state.selectedSocials}");
  //   }
  // }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});
