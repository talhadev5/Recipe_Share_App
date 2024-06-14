import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/modules/allrecipes/saves_recipes.dart';
import 'package:recipe_app/modules/auth/login/view.dart';
import 'package:recipe_app/modules/profile/edit_profile.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/custom_appbar.dart';
import 'logic.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final logic = Get.put(ProfileLogic());

  final state = Get.find<ProfileLogic>().state;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileLogic>(builder: (logic) {
      return Scaffold(
        backgroundColor: AppColors.customScaffoldColor,
        appBar: const CustomAppbar(text: 'Profile', leading: Icon(null)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * .01,
              ),
              Row(
                children: [
                  SizedBox(
                    width: Get.width * .05,
                  ),
                  CircleAvatar(
                    radius: 45,
                    backgroundColor:
                        logic.imagePick != null ? null : Colors.grey,
                    backgroundImage: logic.imagePick != null
                        ? FileImage(logic.imagePick!)
                        : null,
                    child: logic.imagePick == null
                        ? const Icon(Icons.person, color: Colors.white)
                        : null,
                  ),
                  SizedBox(
                    width: Get.width * .05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.nameController!.text,
                        style: state.nameTextStyle,
                      ),
                      Text(
                        state.emailController!.text,
                        style: state.emailTextStyle,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: Get.height * .04,
              ),
              Card.outlined(
                color: AppColors.customWhiteColor,
                child: ListTile(
                  onTap: () {
                    Get.to(() => EditProfile());
                  },
                  title: Text(
                    'Edit Profile',
                    style: state.headingsTextStyle,
                  ),
                  trailing: const Icon(Icons.navigate_next),
                ),
              ),
              SizedBox(
                height: Get.height * .01,
              ),
              Card.outlined(
                color: AppColors.customWhiteColor,
                child: ListTile(
                  onTap: () {
                    Get.to(() => SaveRecipesPage());
                  },
                  title: Text(
                    'Save Recipes',
                    style: state.headingsTextStyle,
                  ),
                  trailing: const Icon(Icons.navigate_next),
                ),
              ),
              SizedBox(
                height: Get.height * .01,
              ),
              Card.outlined(
                color: AppColors.customWhiteColor,
                child: ListTile(
                  onTap: () {
                    auth.signOut().then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false);
                    }).onError((error, stackTrace) {
                      // Handle sign out error
                    });
                  },
                  title: Text(
                    'Log Out',
                    style: state.headingsTextStyle,
                  ),
                  trailing: const Icon(
                    Icons.power_settings_new,
                    color: AppColors.customRedColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
