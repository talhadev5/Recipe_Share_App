import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/utils/constant.dart';
import 'package:recipe_app/widgets/app_progressbar.dart';
import 'package:recipe_app/widgets/custom_appbar.dart';
import 'package:recipe_app/widgets/custom_button.dart';
import 'package:recipe_app/widgets/custom_textfield.dart';

import 'logic.dart';

class AddrecipesPage extends StatelessWidget {
  AddrecipesPage({super.key});

  final logic = Get.put(AddrecipesLogic());
  final state = Get.find<AddrecipesLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddrecipesLogic>(builder: (logic) {
      return AppLoadingWidget(
        inAsyncCall: logic.dataloading,
        child: Scaffold(
            appBar: const CustomAppbar(
              text: 'Post Recipes',
              leading: Icon(null),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: logic.formKey,
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          'Share New Recipe',
                          style: state.titleTextStyle,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Recipe Name',
                                    style: state.textTextStyle,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * .015,
                                ),
                                CustomTextField(
                                  helperText: 'Add Name',
                                  validator: (value) {
                                    if ((value ?? "").isEmpty) {
                                      return ErrorStrings.nameReq;
                                    }
                                    return null;
                                  },
                                  textEditingController:
                                      state.recipeNameController!,
                                  textInputType: TextInputType.name,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Get.width * .03,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Category',
                                    style: state.textTextStyle,
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * .015,
                                ),
                                CustomTextField(
                                  helperText: 'Add Category',
                                  validator: (value) {
                                    if ((value ?? "").isEmpty) {
                                      return ErrorStrings.notEmpty;
                                    }
                                    return null;
                                  },
                                  textEditingController:
                                      state.categoryController!,
                                  textInputType: TextInputType.name,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                            onPressed: () {
                              logic.getImage();
                            },
                            icon: const Icon(
                              Icons.add_a_photo_outlined,
                              color: AppColors.customThemeColor,
                            ),
                            label: const Text(
                              'Add Image',
                              style:
                                  TextStyle(color: AppColors.customThemeColor),
                            )),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ingredients',
                          style: state.textTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * .015,
                      ),
                      CustomTextField(
                        // maxline: 5,
                        helperText: 'Ingredients',
                        validator: (value) {
                          if ((value ?? "").isEmpty) {
                            return ErrorStrings.notEmpty;
                          }
                          return null;
                        },
                        textEditingController: state.ingrediController!,
                        textInputType: TextInputType.streetAddress,
                      ),
                      SizedBox(
                        height: Get.height * .02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Instructions',
                          style: state.textTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * .015,
                      ),
                      CustomTextField(
                        maxline: 5,
                        helperText: 'Instructions',
                        validator: (value) {
                          if ((value ?? "").isEmpty) {
                            return ErrorStrings.notEmpty;
                          }
                          return null;
                        },
                        textEditingController: state.instructionController!,
                        textInputType: TextInputType.streetAddress,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              elevation: 0,
              color: Colors.transparent,
              child: CustomButton(
                  label: 'Post',
                  backgroundColor: AppColors.customThemeColor,
                  onTap: () {
                    logic.addRecipe();
                  },
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.customWhiteColor,
                  )),
            )),
      );
    });
  }
}
