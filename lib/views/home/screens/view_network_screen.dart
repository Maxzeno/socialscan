import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:socialscan/models/social_link_model.dart';
import 'package:socialscan/models/user_model.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/frosted_glass_box.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/utils/textfield.dart';
import 'package:socialscan/view_model/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class ViewNetworkScreen extends StatelessWidget {
  final UserModel user;
  final List<SocialLinkModel> socialMediaList;
  const ViewNetworkScreen(
      {super.key, required this.user, required this.socialMediaList});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(
      context,
    );

    Widget textTile(String text) {
      return Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: ProjectColors.midBlack.withOpacity(0.4),
        ),
      );
    }

    void launchURL(String url) async {
      try {
        Uri finalUrl = Uri.parse(url);
        bool launched = await launchUrl(finalUrl);
        if (!launched) {
          VxToast.show(
            context,
            msg: 'Cannot launch URL.',
            bgColor: ProjectColors.errorColor,
            textColor: Colors.white,
            showTime: 3000,
          );
        }
      } catch (e) {
        VxToast.show(
          context,
          msg: 'Cannot launch URL.',
          bgColor: ProjectColors.errorColor,
          textColor: Colors.white,
          showTime: 3000,
        );
      }
    }

    void openPhone(String phoneNumber) async {
      try {
        String phoneUrl = "tel:$phoneNumber";
        Uri finalUrl = Uri.parse(phoneUrl);
        bool launched = await launchUrl(finalUrl);

        if (!launched) {
          VxToast.show(
            context,
            msg: 'Invalid Phone Number.',
            bgColor: ProjectColors.errorColor,
            textColor: Colors.white,
            showTime: 3000,
          );
        }
      } catch (e) {
        // await launch(fallbackUrl);
        VxToast.show(
          context,
          msg: 'Invalid Phone Number.',
          bgColor: ProjectColors.errorColor,
          textColor: Colors.white,
          showTime: 3000,
        );
      }
    }

    void openEmail(String emailAddress, String subject, String body) async {
      try {
        String emailUrl =
            "mailto:$emailAddress?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}";
        Uri finalUrl = Uri.parse(emailUrl);
        bool launched = await launchUrl(finalUrl);

        if (!launched) {
          VxToast.show(
            context,
            msg: 'Invalid E-mail.',
            bgColor: ProjectColors.errorColor,
            textColor: Colors.white,
            showTime: 3000,
          );
        }
      } catch (e) {
        // await launch(fallbackUrl);
        VxToast.show(
          context,
          msg: 'Invalid E-mail.',
          bgColor: ProjectColors.errorColor,
          textColor: Colors.white,
          showTime: 3000,
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      // extendBody: true,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarHeight: 70,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            bottom: 30.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FrostedGlassBox(
                title: '${user.firstName} ${user.lastName}',
                subTitle: user.profession!,
                theChild: Container(
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
                            user.firstName.toString().substring(0, 1),
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
                            child: user.image.isNotEmpty &&
                                        userProvider.image == null ||
                                    userProvider.image!.isEmpty
                                ? Image.network(
                                    user.image,
                                    fit: BoxFit.cover,
                                  )
                                : Image.memory(
                                    userProvider.image!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                ),
                background: Center(
                  child: user.image.isNotEmpty &&
                          (userProvider.image == null ||
                              userProvider.image!.isEmpty)
                      ? Image.network(
                          user.image,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : userProvider.image != null &&
                              userProvider.image!.isNotEmpty
                          ? Image.memory(
                              userProvider.image!,
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
              user.phoneNumber == ""
                  ? const SizedBox()
                  : Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textTile(phone),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  user.phoneNumber,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: ProjectColors.midBlack,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await Clipboard.setData(
                                      ClipboardData(
                                        text: user.phoneNumber,
                                      ),
                                    );

                                    VxToast.show(
                                      context,
                                      msg: 'Copied to clipboard.',
                                      bgColor: ProjectColors.fadeBlack,
                                      textColor: Colors.white,
                                      showTime: 2000,
                                    );
                                  },
                                  child: Icon(
                                    Icons.copy_outlined,
                                    size: 24,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                const SizedBox(width: 7),
                                GestureDetector(
                                  onTap: () => openPhone(user.phoneNumber),
                                  child: Icon(
                                    Icons.launch_outlined,
                                    size: 24,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
              user.email == ""
                  ? const SizedBox()
                  : Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textTile('Email'),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  user.email,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: ProjectColors.midBlack,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await Clipboard.setData(
                                      ClipboardData(
                                        text: user.email,
                                      ),
                                    );

                                    VxToast.show(
                                      context,
                                      msg: 'Copied to clipboard.',
                                      bgColor: ProjectColors.fadeBlack,
                                      textColor: Colors.white,
                                      showTime: 2000,
                                    );
                                  },
                                  child: Icon(
                                    // onPressed: () {},
                                    Icons.copy_outlined,
                                    size: 24,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                const SizedBox(width: 7),
                                GestureDetector(
                                  onTap: () => openEmail(user.email, "", ""),
                                  child: Icon(
                                    Icons.launch_outlined,
                                    size: 24,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
              const SizedBox(
                height: 30,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  // socialMediaList.map((social) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // textTile(socialMediaList[index].text),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            socialMediaList[index].imagePath!,
                            height: 15,
                            width: 15,
                            colorFilter: ColorFilter.mode(
                              socialMediaList[index].conColor!,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            socialMediaList[index].text,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: ProjectColors.midBlack.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      // TextField(
                      //   // enabled: false,
                      //   readOnly: true,
                      //   controller: TextEditingController(
                      //     text: socialMediaList[index].linkUrl,
                      //   ),
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //     // fontSize: 15,
                      //   ),
                      //   decoration: InputDecoration(
                      //     // hintText: socialMediaList[index].linkUrl,
                      //     // hintStyle: const TextStyle(
                      //     //   color: Colors.black,
                      //     // ),
                      //     enabled: false,
                      //     filled: true,
                      //     fillColor: Colors.grey.shade300,
                      //     // contentPadding: const EdgeInsets.all(0),
                      //     // suffixIconConstraints:
                      //     //     BoxConstraints.tight(const Size.fromWidth(100)),
                      //     suffixIcon: Padding(
                      //       padding: const EdgeInsets.only(right: 10.0),
                      //       child: Row(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           GestureDetector(
                      //             onTap: () async {
                      //               // await Clipboard.setData(ClipboardData(
                      //               //     text: socialMediaList[index].linkUrl));

                      //               // ScaffoldMessenger.of(context)
                      //               //     .showSnackBar(const SnackBar(
                      //               //   content: Text('Copied to clipboard'),
                      //               // ));
                      //               // print("Copied");
                      //             },
                      //             child: Icon(
                      //               // onPressed: () {},
                      //               Icons.copy_outlined,
                      //               size: 24,
                      //               color: Colors.grey.shade800,
                      //             ),
                      //           ),
                      //           const SizedBox(width: 7),
                      //           Icon(
                      //             Icons.launch_outlined,
                      //             size: 24,
                      //             color: Colors.grey.shade800,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      ReusableTextField(
                        // controller: TextEditingController(
                        //   text: socialMediaList[index].linkUrl,
                        // ),
                        initialValue: socialMediaList[index].linkUrl,
                        obscure: false,
                        textSize: 15,
                        readOnly: true,
                        onTap: () {},
                        iconButton: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  // await Clipboard.setData(ClipboardData(
                                  //     text: socialMediaList[index].linkUrl));

                                  // ScaffoldMessenger.of(context)
                                  //     .showSnackBar(const SnackBar(
                                  //   content: Text('Copied to clipboard'),
                                  // ));
                                  // print("Copied");
                                  await Clipboard.setData(
                                    ClipboardData(
                                      text: socialMediaList[index].linkUrl,
                                    ),
                                  );

                                  // ScaffoldMessenger.of(context)
                                  //     .showSnackBar(const SnackBar(
                                  //   content: Text('Copied to clipboard'),
                                  // ));
                                  VxToast.show(
                                    context,
                                    msg: 'Copied to clipboard.',
                                    bgColor: ProjectColors.fadeBlack,
                                    textColor: Colors.white,
                                    showTime: 2000,
                                  );
                                },
                                child: Icon(
                                  // onPressed: () {},
                                  Icons.copy_outlined,
                                  size: 22,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              const SizedBox(width: 7),
                              GestureDetector(
                                onTap: () =>
                                    launchURL(socialMediaList[index].linkUrl),
                                child: Icon(
                                  Icons.launch_outlined,
                                  size: 22,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );

                  // return Text(social.linkUrl);
                  // }).toList();
                  // return null;
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemCount: socialMediaList.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
