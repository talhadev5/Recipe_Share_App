import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:recipe_app/modules/allrecipes/logic.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/utils/constant.dart';
import 'package:recipe_app/widgets/app_progressbar.dart';
import 'package:recipe_app/widgets/custom_appbar.dart';
import 'package:recipe_app/widgets/custom_snackbar.dart';

// ignore: must_be_immutable
class RecipeDetails extends StatefulWidget {
  String? image;
  String? name;
  String? catagory;
  String? ingred;
  String? instruction;
  bool? isSaved = false;
  final VoidCallback? onSave;
  RecipeDetails(
      {super.key,
      this.image,
      this.catagory,
      this.isSaved,
      this.onSave,
      this.ingred,
      this.instruction,
      this.name});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  bool isLiked = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  get formKey => _formKey;

  bool isDisliked = false;
  bool dataloading = false;
  TextEditingController feedbackController = TextEditingController();
  final logic = Get.put(AllrecipesLogic());

  final state = Get.find<AllrecipesLogic>().state;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllrecipesLogic>(builder: (logic) {
      return AppLoadingWidget(
        inAsyncCall: dataloading,
        child: Scaffold(
          appBar: CustomAppbar(
            text: 'Details',
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: Get.height * .3,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: CachedNetworkImage(
                          imageUrl: widget.image.toString(),
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                color: AppColors.customThemeColor,
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.photo_outlined)),
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          // Toggle the saved state
                          widget.isSaved == !widget.isSaved!;
                          // Call the onSave callback if provided
                          widget.onSave?.call();
                          widget.isSaved == true;
                        });
                        showSnackBar('Message', 'Recipe are Saved Successful!');
                      },
                      icon: Icon(widget.isSaved == true
                          ? Icons.bookmark
                          : Icons.bookmark_border),
                      color: widget.isSaved == true
                          ? AppColors.customThemeColor
                          : Colors.grey,
                      iconSize: 35,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recipe Name:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.name.toString(),
                        // style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Category Name:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.catagory.toString(),
                        // style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * .02,
                  ),
                  const Text(
                    'Ingredients:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.ingred.toString(),
                    // style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: Get.height * .02,
                  ),
                  const Text(
                    'Instruction:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ReadMoreText(
                    widget.instruction.toString(),
                    trimMode: TrimMode.Line,
                    trimLines: 5,
                    colorClickableText: Colors.pink,
                    trimCollapsedText: 'Read more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.customThemeColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: formKey,
                    child: TextFormField(
                      validator: (value) {
                        if ((value ?? "").isEmpty) {
                          return ErrorStrings.notEmpty;
                        }
                        return null;
                      },
                      controller: feedbackController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your feedback',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked;
                            if (isLiked) {
                              isDisliked = false; // Reset dislike if liked
                            }
                          });
                        },
                        icon: Icon(
                          isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                          color: isLiked ? Colors.blue : null,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isDisliked = !isDisliked;
                            if (isDisliked) {
                              isLiked = false; // Reset like if disliked
                            }
                          });
                        },
                        icon: Icon(
                          isDisliked
                              ? Icons.thumb_down
                              : Icons.thumb_down_outlined,
                          color: isDisliked ? Colors.red : null,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          dataloading = true;

                          final fireStore = FirebaseFirestore.instance
                              .collection('feedbacks');
                          String id =
                              DateTime.now().millisecondsSinceEpoch.toString();

                          try {
                            await fireStore.doc(id).set({
                              'id': id,
                              'feed_back': feedbackController.text.trim(),
                            });
                            // Handle success, e.g., show a success message
                            showSnackBar(
                                'Message', 'Feedback Send successfully');
                            // Clear the text controllers and image picker
                            feedbackController.clear();
                          } catch (error) {
                            // Handle error, e.g., show an error message
                            showSnackBar('Message', 'Failed to add recipe');
                            log(error.toString());
                          } finally {
                            dataloading = false;
                          }
                          logic.update();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Send Feedback',
                          style: TextStyle(color: AppColors.customThemeColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
