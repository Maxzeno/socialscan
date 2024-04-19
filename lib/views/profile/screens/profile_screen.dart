import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:socialscan/utils/button.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/info_snackbar.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/utils/textfield.dart';
import 'package:socialscan/view_model/user_provider.dart';
import 'package:socialscan/views/settings/widgets/custom_country_picker.dart';

import '../../../models/user_model.dart';
import '../../../utils/frosted_glass_box.dart';
import '../../../utils/services/firebase_services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String profession = '';
  String phoneNumber = '';
  String email = '';
  @override
  Widget build(BuildContext context) {
    UserModel? userModel = Provider.of<UserProvider>(
      context,
    ).userModel;
    final userProvider = Provider.of<UserProvider>(
      context,
    );
    // final nameController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
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
                    title: '${userModel!.firstName} ${userModel.lastName}',
                    subTitle: userModel.profession!,
                    theChild: Stack(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ProjectColors.mainPurple,
                          ),
                          child: userProvider.userModel!.image.isEmpty &&
                                  userProvider.image == null
                              ? Center(
                                  child: Text(
                                    userModel.firstName
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
                                    child: userModel.image.isNotEmpty &&
                                                userProvider.image == null ||
                                            userProvider.image!.isEmpty
                                        ? Image.network(
                                            userModel.image,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.memory(
                                            userProvider.image!,
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
                              userProvider.selectProfilePic();
                            },
                          ),
                        ),
                      ],
                    ),
                    background: Center(
                        child: userModel.image != null &&
                                userModel.image.isNotEmpty &&
                                (userProvider.image == null ||
                                    userProvider.image!.isEmpty)
                            ? Image.network(
                                userModel.image,
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: ProjectColors.mainPurple,
                              )),
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
                        '${userModel.firstName} ${userModel.lastName}',
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
                  textTile(profession),
                  const SizedBox(
                    height: 5,
                  ),
                  ReusableTextField(
                    // controller: nameController,
                    initialValue: userModel.profession,
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
                  CustomCountryField(
                    initialValue: userModel.phoneNumber,
                    onSave: (val) {
                      phoneNumber = val!;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  textTile(email),
                  const SizedBox(
                    height: 5,
                  ),
                  ReusableTextField(
                    // controller: nameController,
                    initialValue: userModel.email,
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
                  image: userProvider.image!)
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
      style: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ProjectColors.midBlack.withOpacity(0.4),
      ),
    );
  }
}
