import 'package:flutter/material.dart';

import 'package:socialscan/models/social_link_model.dart';
import 'package:socialscan/models/user_model.dart';


class PreviewScanLinkScreen extends StatelessWidget {
  final List<UserModel> data;
  const PreviewScanLinkScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('User Details'),
              ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final UserModel user = data[index];
                  return ListTile(
                    title: Text('Name: ${user.firstName} ${user.lastName}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone Number: ${user.phoneNumber}'),
                        Text('Profession: ${user.profession}'),
                        Text('Image: ${user.image}'),
                        Text('Social Links:'),
                        ListView.builder(
                          itemCount: user.socialMediaLink!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final SocialLinkModel link = user.socialMediaLink![index];
                            return ListTile(
                              title: Text('Text: ${link.text}'),
                              subtitle: Text('URL: ${link.linkUrl}'),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
