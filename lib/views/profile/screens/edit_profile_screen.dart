import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialscan/bottom_nav_screen.dart';
import 'package:socialscan/utils/button.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/info_snackbar.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/utils/textfield.dart';
import 'package:socialscan/view_model/river_pod/user_notifier.dart';

import '../../../utils/frosted_glass_box.dart';
import '../../../utils/services/firebase_services.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String profession = '';
  String phoneNumber = '';
  String email = '';
  @override
  Widget build(BuildContext context) {
    final userNotifier = ref.watch(userProvider);
    final userState = ref.read(userProvider.notifier);

    // final nameController = TextEditingController();
    return Scaffold(
      // backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarHeight: 70,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const BottomNav()));
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FrostedGlassBox(
                    title:
                        '${userNotifier.userModel!.firstName} ${userNotifier.userModel!.lastName}',
                    subTitle: userNotifier.userModel!.profession!,
                    theChild: Stack(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ProjectColors.mainPurple,
                          ),
                          child: userNotifier.userModel!.image.isEmpty &&
                                  userNotifier.image == null
                              ? Center(
                                  child: Text(
                                    userNotifier.userModel!.firstName
                                        .toString()
                                        .substring(0, 1),
                                    style: const TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  // height: MediaQuery.of(context).size.width - 40,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                  ),
                                  child: ClipOval(
                                    child: userNotifier.userModel!.image
                                                    .isNotEmpty &&
                                                userNotifier.image == null ||
                                            userNotifier.image!.isEmpty
                                        ? Image.network(
                                            userNotifier.userModel!.image,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.memory(
                                            userNotifier.image!,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                        ),
                        Positioned(
                          right: 0,
                          top: 30,
                          child: changeProfileIcon(
                            onTap: () {
                              userState.selectProfilePic();
                            },
                          ),
                        ),
                      ],
                    ),
                    background: Center(
                      child: userNotifier.userModel!.image.isNotEmpty &&
                              (userNotifier.image == null ||
                                  userNotifier.image!.isEmpty)
                          ? Image.network(
                              userNotifier.userModel!.image,
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : userNotifier.image != null &&
                                  userNotifier.image!.isNotEmpty
                              ? Image.memory(
                                  userNotifier.image!,
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  color: ProjectColors.mainPurple,
                                ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  textTile(name),
                  const SizedBox(
                    height: 5,
                  ),
                  ReusableTextField(
                    // controller: nameController,
                    initialValue:
                        '${userNotifier.userModel!.firstName} ${userNotifier.userModel!.lastName}',
                    obscure: false,
                    iconButton: null,
                    onSaved: (val) {
                      firstName = val!;
                    },
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  textTile('Profession'),
                  const SizedBox(
                    height: 5,
                  ),
                  ReusableTextField(
                    // controller: nameController,
                    initialValue: userNotifier.userModel!.profession,
                    obscure: false,
                    iconButton: null,
                    onSaved: (val) {
                      profession = val!;
                    },
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  textTile(phone),
                  const SizedBox(
                    height: 5,
                  ),
                  ReusableTextField(
                    // controller: nameController,
                    initialValue: userNotifier.userModel!.phoneNumber,
                    obscure: false,
                    iconButton: null,
                    onSaved: (val) {
                      phoneNumber = val!;
                    },
                    onTap: () {},
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                  textTile('Email'),
                  const SizedBox(
                    height: 5,
                  ),
                  ReusableTextField(
                    // controller: nameController,
                    initialValue: userNotifier.userModel!.email,
                    obscure: false,
                    iconButton: null,
                    onSaved: (val) {
                      email = val!;
                    },
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // ButtonTile(text: save, boxRadius: 8),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          _formKey.currentState!.save();
          FirebaseService()
              .updateProfile(
                  firstName: firstName,
                  lastName: lastName,
                  profession: profession,
                  phoneNumber: phoneNumber,
                  email: email,
                  image: userNotifier.image!)
              .then(
                (value) => infoSnackBar(context, 'Profile Updated Successful',
                    const Duration(milliseconds: 400), Colors.green),
              );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          color: Colors.transparent,
          child: ButtonTile(text: save, boxRadius: 8),
        ),
      ),
    );
  }

  Widget changeProfileIcon({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 33,
        width: 33,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white),
          color: ProjectColors.mainPurple,
        ),
        child: Center(
            child: SvgPicture.asset(
          editIcon,
        )),
      ),
    );
  }

  Widget textTile(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).brightness == Brightness.light
            ? ProjectColors.midBlack.withOpacity(0.4)
            : Colors.white,
      ),
    );
  }
}
