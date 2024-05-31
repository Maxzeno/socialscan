import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/utils/button.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/utils/textfield.dart';
import 'package:socialscan/views/auth/screens/sign_up_screen.dart';

import '../../../utils/colors.dart';
import '../../../utils/google_button.dart';
import '../../../view_model/river_pod/user_notifier.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final userNotifier = ref.read(userProvider.notifier);
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                helloWelcomeBack,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ReusableTextField(
                controller: userNotifier.emailController,
                hintText: 'Email',
                obscure: false,
                onTap: () {},
                iconButton: const SizedBox(),
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 18,
              ),
              ReusableTextField(
                controller: userNotifier.passwordController,
                hintText: 'Password',
                obscure: _obscure,
                textInputType: TextInputType.visiblePassword,
                iconButton: InkWell(
                  onTap: () {
                    setState(() {
                      _obscure = !_obscure;
                    });
                  },
                  child: _obscure
                      ? const Icon(
                          Icons.visibility_off_outlined,
                          size: 15,
                          color: ProjectColors.mainPurple,
                        )
                      : const Icon(
                          Icons.visibility_outlined,
                          size: 15,
                          color: ProjectColors.mainPurple,
                        ),
                ),
                onTap: () {},
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                forgotPassword,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Theme.of(context).brightness == Brightness.light
                      ? ProjectColors.mainPurple.withOpacity(0.6)
                      : ProjectColors.lightishPurple,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ButtonTile(
                text: login,
                loading: userState.isLoading,
                onTap: () {
                  userNotifier.signIn(context);
                },
                boxRadius: 8,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    dontHaveAnAccount,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: Text(
                      signUp,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.light
                            ? ProjectColors.mainPurple.withOpacity(0.6)
                            : ProjectColors.lightishPurple,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 108,
                    child: Divider(
                      color: Theme.of(context).brightness == Brightness.light
                          ? ProjectColors.midBlack.withOpacity(0.4)
                          : ProjectColors.mainGray,
                    ),
                  ),
                  Text(orContinueWith),
                  SizedBox(
                    width: 108,
                    child: Divider(
                      color: Theme.of(context).brightness == Brightness.light
                          ? ProjectColors.midBlack.withOpacity(0.4)
                          : ProjectColors.mainGray,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const AccountButton(),
            ],
          ),
        ),
      ),
    );
  }
}

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});
//
//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   bool _obscure = true;
//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
//           child: ListView(
//             // crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 helloWelcomeBack,
//                 style: const TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               ReusableTextField(
//                 controller: userProvider.emailController,
//                 hintText: 'Email',
//                 obscure: false,
//                 onTap: () {},
//                 iconButton: const SizedBox(),
//                 textInputType: TextInputType.emailAddress,
//               ),
//               const SizedBox(
//                 height: 18,
//               ),
//               ReusableTextField(
//                 controller: userProvider.passwordController,
//                 hintText: 'Password',
//                 obscure: _obscure,
//                 textInputType: TextInputType.visiblePassword,
//                 iconButton: InkWell(
//                   onTap: () {
//                     setState(() {
//                       _obscure = !_obscure;
//                     });
//                   },
//                   child: _obscure
//                       ? const Icon(
//                           Icons.visibility_off_outlined,
//                           size: 15,
//                         )
//                       : const Icon(
//                           Icons.visibility_outlined,
//                           size: 15,
//                         ),
//                 ),
//                 onTap: () {},
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               Text(
//                 forgotPassword,
//                 style: GoogleFonts.inter(
//                   fontSize: 13,
//                   color: ProjectColors.mainPurple.withOpacity(0.6),
//                 ),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               ButtonTile(
//                 text: login,
//                 loading: userProvider.isLoading,
//                 onTap: () {
//                   userProvider.signIn(context);
//                 },
//                 boxRadius: 8,
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     dontHaveAnAccount,
//                     style: const TextStyle(
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const SignUpScreen()));
//                     },
//                     child: Text(
//                       signUp,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: ProjectColors.mainPurple.withOpacity(0.6),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 100,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SizedBox(
//                     width: 108,
//                     child: Divider(
//                       color: ProjectColors.midBlack.withOpacity(0.4),
//                     ),
//                   ),
//                   Text(orContinueWith),
//                   SizedBox(
//                     width: 108,
//                     child: Divider(
//                       color: ProjectColors.midBlack.withOpacity(0.4),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               accountButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

Widget accountButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => const CompleteGoogleProfile()));
    },
    child: Container(
      height: 53,
      width: 388,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ProjectColors.midBlack.withOpacity(0.4),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(googleIcon),
          const SizedBox(
            width: 16,
          ),
          Text(
            google,
            style: GoogleFonts.inter(
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}
