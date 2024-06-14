import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/utils/constant.dart';
import 'package:recipe_app/widgets/app_progressbar.dart';
import 'package:recipe_app/widgets/custom_appbar.dart';
import 'package:recipe_app/widgets/custom_button.dart';
import 'package:recipe_app/widgets/custom_formfield.dart';

import 'logic.dart';

class ForgotPage extends StatelessWidget {
  ForgotPage({super.key});

  final logic = Get.put(ForgotLogic());
  final state = Get.find<ForgotLogic>().state;
  

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotLogic>(builder: (logic) {
      return AppLoadingWidget(
        inAsyncCall: logic.dataloading,
        child: Scaffold(
          appBar: CustomAppbar(
              text: 'Forgot',
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back))),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: logic.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * .04,
                    ),
                    Text(
                      'Forgot Password!',
                      style: state.titleTextStyle,
                    ),
                    SizedBox(
                      height: Get.height * .04,
                    ),
                    CustomFormField(
                      prefixIcon: const Icon(Icons.email),
                      helperText: 'Email',
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
                      height: Get.height * .02,
                    ),
                    const Text.rich(TextSpan(
                        text: ' * ',
                        style: TextStyle(
                            color: AppColors.customRedColor,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text:
                                'We will send you a message to set or reset your new password',
                            style: TextStyle(
                                color: AppColors.customBlackColor,
                                fontWeight: FontWeight.normal),
                          )
                        ])),
                    SizedBox(
                      height: Get.height * .04,
                    ),
                    CustomButton(
                        label: 'Forgot',
                        backgroundColor: AppColors.customThemeColor,
                        onTap: () {
                          // Get.to(() => const CustomBottomBar());
                          logic.forgot();
                        },
                        labelStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
