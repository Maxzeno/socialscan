import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/view_model/user_provider.dart';
import 'package:socialscan/views/home/screens/network_page.dart';
import 'package:socialscan/views/home/screens/socials_page.dart';
import 'package:socialscan/views/home/widgets/tabs_container_widget.dart';
import 'package:socialscan/views/profile/screens/profile_screen.dart';
import 'package:socialscan/views/settings/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    addData();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  addData() async {
    UserProvider userModel = Provider.of<UserProvider>(context, listen: false);
    await userModel.updateUserDetails();

    // await logicModelProvider.transactionsStream('expense');
    // await logicModelProvider.transactionsStream('income');
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   // leadingWidth: 20,
      //   elevation: 0.0,
      //   leading: Center(
      //     child: CircleAvatar(
      //       radius: 20,
      //       backgroundImage: NetworkImage(profileImage),
      //     ),
      //   ),
      //   title: Text(
      //     helloDavid,
      //     style: TextStyle(
      //       fontSize: 18,
      //       fontWeight: FontWeight.w600,
      //       color: ProjectColors.midBlack,
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: SvgPicture.asset(
      //         settingsIcon,
      //         height: 24,
      //         width: 24,
      //       ),
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: userProvider.userModel == null
              ? const SizedBox()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => const ProfileScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 42,
                            width: 42,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ProjectColors.mainPurple,
                            ),
                            child: (userProvider.userModel!.image.isEmpty) &&
                                    userProvider.image == null
                                ? Center(
                                    child: Text(
                                      userProvider.userModel!.firstName
                                          .substring(0, 1),
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : userProvider.image != null &&
                                        userProvider.image!.isNotEmpty
                                    ? ClipOval(
                                        child: Image.memory(
                                          userProvider.image!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : ClipOval(
                                        child: Image.network(
                                          userProvider.userModel!.image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          // helloDavid,
                          "Hello ${userProvider.userModel!.firstName}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: ProjectColors.midBlack,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => const SettingScreen(),
                              ),
                            );
                          },
                          child: SvgPicture.asset(
                            settingsIcon,
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TabsContainerWidget(
                      tabController: _tabController,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Expanded(
                      // height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                        controller: _tabController,
                        children: const [
                          SocialsPage(),
                          NetworkPage(),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
