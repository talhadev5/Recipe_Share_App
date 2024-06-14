// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recipe_app/modules/profile/logic.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/utils/constant.dart';
import 'package:recipe_app/widgets/app_progressbar.dart';
import 'package:recipe_app/widgets/custom_appbar.dart';
import 'package:recipe_app/widgets/custom_button.dart';
import 'package:recipe_app/widgets/custom_textfield.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  final logic = Get.put(ProfileLogic());
  final state = Get.find<ProfileLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileLogic>(builder: (logic) {
      return AppLoadingWidget(
        inAsyncCall: logic.dataloading,
        child: Scaffold(
          appBar: CustomAppbar(
            text: 'Edit Profile',
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Form(
                key: logic.formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * .03,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50.r,
                            backgroundColor:
                                logic.imagePick != null ? null : Colors.grey,
                            backgroundImage: logic.imagePick != null
                                ? FileImage(logic.imagePick!)
                                : null,
                            child: logic.imagePick == null
                                ? const Icon(Icons.person, color: Colors.white)
                                : null,
                          ),
                          Positioned(
                            bottom: -7,
                            right: -7,
                            child: IconButton(
                                onPressed: () {
                                  logic.getImage();
                                },
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .04,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Full Name',
                        style: state.titleTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .015,
                    ),
                    CustomTextField(
                      helperText: 'Add Your Name',
                      validator: (value) {
                        if ((value ?? "").isEmpty) {
                          return ErrorStrings.nameReq;
                        }
                        return null;
                      },
                      textEditingController: state.nameController!,
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Phone Number',
                        style: state.titleTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .015,
                    ),
                    CustomTextField(
                      helperText: 'Add Your Number',
                      validator: (value) {
                        if ((value ?? "").isEmpty) {
                          return ErrorStrings.notEmpty;
                        }
                        return null;
                      },
                      textEditingController: state.phoneController!,
                      textInputType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email Address',
                        style: state.titleTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .015,
                    ),
                    CustomTextField(
                      helperText: 'Add Your Email',
                      validator: (value) {
                        if ((value ?? "").isEmpty) {
                          return ErrorStrings.emailReq;
                        } else if (!GetUtils.isEmail(value!)) {
                          return ErrorStrings.emailInvalid;
                        }
                        return null;
                      },
                      textEditingController: state.emailController!,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: Get.height * .08,
                    ),
                    CustomButton(
                        label: 'Save',
                        backgroundColor: AppColors.customThemeColor,
                        onTap: () {
                          logic.saveUserProfile();
                        },
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.customWhiteColor,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
