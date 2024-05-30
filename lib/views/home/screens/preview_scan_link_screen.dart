import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialscan/bottom_nav_screen.dart';
import 'package:socialscan/models/social_link_model.dart';
import 'package:socialscan/models/user_model.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/frosted_glass_box.dart';

import '../../../utils/strings.dart';

class PreviewScanLinkScreen extends StatelessWidget {
  final List<UserModel> data;
  const PreviewScanLinkScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget textTile(String text) {
      return Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          // color: ProjectColors.midBlack.withOpacity(0.4),
          color: Theme.of(context).brightness == Brightness.light
              ? ProjectColors.midBlack.withOpacity(0.4)
              : Colors.white,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarHeight: 70,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const BottomNav();
                  }),
                  (route) => false,
                );
              },
              child: const Text(
                "Back to home",
                style: TextStyle(
                  color: ProjectColors.mainPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final UserModel user = data[index];
                    return Column(
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
                            child: user.image.isNotEmpty &&
                                    user.image.startsWith("https")
                                ? Container(
                                    width: 100,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                    ),
                                    child: ClipOval(
                                      child: Image.network(
                                        user.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      user.firstName.substring(0, 1),
                                      style: const TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          ),
                          background: Center(
                            child: user.image.isNotEmpty &&
                                    user.image.startsWith('https')
                                ? Image.network(
                                    user.image,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                      Icon(
                                        Icons.copy_outlined,
                                        size: 24,
                                        color: Colors.grey.shade800,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                      Icon(
                                        // onPressed: () {},
                                        Icons.copy_outlined,
                                        size: 24,
                                        color: Colors.grey.shade800,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        // Text('Phone Number: ${user.phoneNumber}'),
                        // Text('Profession: ${user.profession}'),
                        // Text('Image: ${user.image}'),
                        // const Text('Social Links:'),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: user.socialMediaLink!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final SocialLinkModel link =
                                user.socialMediaLink![index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // textTile(socialMediaList[index].text),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      link.imagePath!,
                                      height: 15,
                                      width: 15,
                                      colorFilter: ColorFilter.mode(
                                        link.conColor!,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      link.text,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: ProjectColors.midBlack
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                TextField(
                                  // enabled: false,
                                  readOnly: true,
                                  controller: TextEditingController(
                                    text: link.linkUrl,
                                  ),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    // fontSize: 15,
                                  ),
                                  decoration: InputDecoration(
                                    // hintText: socialMediaList[index].linkUrl,
                                    // hintStyle: const TextStyle(
                                    //   color: Colors.black,
                                    // ),
                                    enabled: false,
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    // contentPadding: const EdgeInsets.all(0),
                                    // suffixIconConstraints:
                                    //     BoxConstraints.tight(const Size.fromWidth(100)),
                                    suffixIcon: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
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
                                            },
                                            child: Icon(
                                              // onPressed: () {},
                                              Icons.copy_outlined,
                                              size: 24,
                                              color: Colors.grey.shade800,
                                            ),
                                          ),
                                          const SizedBox(width: 7),
                                          Icon(
                                            Icons.launch_outlined,
                                            size: 24,
                                            color: Colors.grey.shade800,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, _) => const SizedBox(
                            height: 15,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
