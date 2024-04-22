import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialscan/models/social_link_model.dart';
import 'package:socialscan/models/user_model.dart';
import 'package:socialscan/utils/info_snackbar.dart';
import 'package:socialscan/utils/services/storage_service.dart';

class FirebaseService {
  static FirebaseAuth auth = FirebaseAuth.instance;

  // static GoogleSignIn googleSignIn = GoogleSignIn();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var user = auth.currentUser;

  Future<String> addSocialLink(SocialLinkModel newSocialLink) async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser == null) {
        return 'User not logged in.';
      }

      CollectionReference socialLinksRef = _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('socialMediaLinks');

      // Check if the social media link already exists
      QuerySnapshot snapshot = await socialLinksRef
          .where('text', isEqualTo: newSocialLink.text)
          .get();

      if (snapshot.docs.isNotEmpty) {
        print('it exits');
        return 'Social link already exists!';
      }

      String newLinkId = DateTime.now().millisecondsSinceEpoch.toString();
      newSocialLink.id = newLinkId;

      await socialLinksRef.doc(newLinkId).set(newSocialLink.toJson());

      return 'Social link added successfully!';
    } catch (error) {
      print("Error adding social link: $error");
      return 'Error adding social link: $error';
    }
  }

  Future<String> editSocialLink(String socialLinkId, String newLinkUrl) async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser == null) {
        return 'User not logged in.';
      }

      CollectionReference socialLinksRef = _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('socialMediaLinks');

      // Update the link URL of the specified social media link
      await socialLinksRef.doc(socialLinkId).update({'linkUrl': newLinkUrl});

      return 'Social link updated successfully!';
    } catch (error) {
      print("Error editing social link: $error");
      return 'Error editing social link: $error';
    }
  }

  Future<String> deleteSocialLink(String socialLinkId) async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser == null) {
        return 'User not logged in.';
      }

      CollectionReference socialLinksRef = _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('socialMediaLinks');

      await socialLinksRef.doc(socialLinkId).delete();

      return 'Social link deleted successfully!';
    } catch (error) {
      print("Error deleting social link: $error");
      return 'Error deleting social link: $error';
    }
  }

  Stream<List<SocialLinkModel>> getAllSocialMediaLinks() {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser == null) {
        print('For get social link =====> User not logged in.');
        return Stream.value([]);
      }

      print('Getting data from Firebase'); // Indicate start of data fetching
      CollectionReference socialLinksRef = _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('socialMediaLinks');

      return socialLinksRef.snapshots().map((querySnapshot) {
        final List<SocialLinkModel> socialLinks = [];
        for (var doc in querySnapshot.docs) {
          final socialLinkData = doc.data()
              as Map<String, dynamic>; // Cast to Map<String, dynamic>
          final socialLinkModel = SocialLinkModel.fromJson(socialLinkData);
          socialLinks.add(socialLinkModel);
        }
        print('Social Links: $socialLinks'); // Print social links
        return socialLinks;
      });
    } catch (error) {
      print('Error fetching social media links: $error');
      return Stream.value([]);
    }
  }

  Future<String> updatePassword({
    required String password,
  }) async {
    String res = 'Some error occurred';
    try {
      User? currentUser = auth.currentUser;

      if (currentUser == null) {
        return 'User not logged in';
      }
      var cred = EmailAuthProvider.credential(
          email: currentUser.email!, password: password);
      await currentUser.reauthenticateWithCredential(cred).then((value) {
        currentUser.updatePassword(password);
      }).catchError((error) {
        print(' checking password ${error.toString()}');
      });
      print(' new password $cred');
      print(' email ${currentUser.email}');

      await _firestore.collection('users').doc(currentUser.uid).update({
        'password': password,
      });

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(currentUser.uid).get();

      UserModel updatedUser =
          UserModel.fromJson(userDoc.data() as Map<String, dynamic>);

      updatedUser.password = password;

      await _firestore.collection('users').doc(currentUser.uid).update(
            updatedUser.toJson(),
          );

      res = 'Password updated successfully';
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  // Future<String> updateProfile(
  //     {String? firstName,
  //     String? lastName,
  //     String? email,
  //     String? profession,
  //     String? phoneNumber,
  //     required Uint8List image}) async {
  //   String res = 'Some error occurred';
  //   try {
  //     User? currentUser = auth.currentUser;
  //     if (currentUser != null) {
  //       String photoUrl = await StorageService()
  //           .uploadingImageToStorage('profilePic', image, false);
  //       UserModel updatedUser = UserModel(
  //         image: photoUrl ?? '',
  //         profession: profession ?? '',
  //         firstName: firstName ?? '',
  //         lastName: lastName ?? '',
  //         id: currentUser.uid,
  //         email: email ?? '',
  //         phoneNumber: phoneNumber ?? '',
  //       );
  //       await _firestore.collection('users').doc(currentUser.uid).update(
  //             updatedUser.toJson(),
  //           );
  //
  //       res = 'Profile updated successfully';
  //     }
  //   } catch (error) {
  //     res = error.toString();
  //   }
  //   return res;
  // }

  Future<String> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? profession,
    String? phoneNumber,
    Uint8List? image,
  }) async {
    String res = 'Some error occurred';
    try {
      User? currentUser = auth.currentUser;
      if (currentUser != null) {
        String? photoUrl = image != null
            ? await StorageService()
                .uploadingImageToStorage('profilePic', image, false)
            : null;
        Map<String, dynamic> updatedFields = {
          if (firstName != null && firstName.isNotEmpty) 'firstName': firstName,
          if (lastName != null && lastName.isNotEmpty) 'lastName': lastName,
          if (email != null && email.isNotEmpty) 'email': email,
          if (profession != null && profession.isNotEmpty)
            'profession': profession,
          if (phoneNumber != null && phoneNumber.isNotEmpty)
            'phoneNumber': phoneNumber,
          if (photoUrl != null) 'image': photoUrl,
        };
        if (updatedFields.isNotEmpty) {
          await _firestore.collection('users').doc(currentUser.uid).update(
                updatedFields,
              );
          res = 'Profile updated successfully';
        } else {
          res = 'No fields to update';
        }
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<UserModel?> getUserDetails() async {
    try {
      User? currentUser = auth.currentUser;

      if (currentUser == null) {
        return null;
      }

      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(currentUser.uid).get();

      if (!documentSnapshot.exists) {
        throw Exception("User document does not exist");
      }

      print("Document data: ${documentSnapshot.data()}");

      return UserModel.fromSnap(documentSnapshot);
    } catch (error) {
      print("Error in getUserDetails: $error");
      rethrow;
    }
  }

  Future<String> createUser({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String password,
    required String profession,
    required BuildContext context,
  }) async {
    String res = 'Some error occurred';
    try {
      if (firstName.isNotEmpty ||
          lastName.isNotEmpty ||
          phoneNumber.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          profession.isNotEmpty) {
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: email, password: password);

        UserModel userModel = UserModel(
          id: userCredential.user!.uid,
          image: '',
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          email: email,
          password: password,
          profession: profession,
          socialMediaLink: [],
        );
        _firestore.collection('users').doc(userCredential.user!.uid).set(
              userModel.toJson(),
            );
        infoSnackBar(
            context, 'Sign-Up in process', const Duration(milliseconds: 200));

        res = 'Successful';
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'no-internet') {
        infoSnackBar(context, 'No internet connectivity',
            const Duration(milliseconds: 200), Colors.red);
        infoSnackBar(context, _getErrorMessage(error.code),
            const Duration(milliseconds: 200), Colors.red);

        res = 'No internet connection';
      } else {
        res = error.message ?? 'Some error occurred';
      }
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    String res = 'Some error occurred';
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        res = 'Successful';
      } else {
        res = 'Login failed. Please check your credentials and try again.';
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'no-internet') {
        infoSnackBar(context, 'No internet connection',
            const Duration(milliseconds: 200), Colors.red);
        res = 'No internet connection';
      } else {
        res = _getErrorMessage(error.code);
        infoSnackBar(context, _getErrorMessage(error.code),
            const Duration(milliseconds: 200), Colors.red);
      }
    } catch (error) {
      res = 'An error occurred. Please try again later.';
    }
    return res;
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'weak-password':
        return 'The password should be at least 6 characters long.';
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Invalid password.';
      default:
        return 'An error occurred. Please try again later.';
    }
  }
}

// Future<String> signInWithGoogle(BuildContext context) async {
//   try {
//     final GoogleSignInAccount? googleSignInAccount =
//     await googleSignIn.signIn();
//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;
//
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );
//
//       final UserCredential userCredential =
//       await auth.signInWithCredential(credential);
//       final User? user = userCredential.user;
//
//       if (user != null) {
//         UserModel userModel = UserModel(
//           id: user.uid,
//           firstName: user.displayName ?? '',
//           lastName: '',
//           phoneNumber: '',
//           email: user.email ?? '',
//           password: '',
//         );
//
//         await _firestore.collection('users').doc(user.uid).set(
//           userModel.toJson(),
//           SetOptions(merge: true), // Merge data if user already exists
//         );
//
//         // Check if the user is signing in for the first time
//         if (userCredential.additionalUserInfo?.isNewUser ?? false) {
//           // Perform any additional actions for new users
//         }
//
//         return 'Successful';
//       } else {
//         return 'Sign-in failed. Please try again.';
//       }
//     } else {
//       return 'Sign-in canceled.';
//     }
//   } catch (error) {
//     return 'An error occurred. Please try again later.';
//   }
// }
//
// void signOutGoogle() async {
//   await googleSignIn.signOut();
//   print("User Signed Out");
// }
