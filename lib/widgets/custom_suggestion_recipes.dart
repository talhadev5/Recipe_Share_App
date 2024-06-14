import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:recipe_app/utils/colors.dart';

// ignore: must_be_immutable
class SuggestionRecipes extends StatelessWidget {
  String? title;
  String? description;
  String? imageUrl;
  final VoidCallback? onTap;
  final VoidCallback? onLongTap;

  SuggestionRecipes({
    super.key,
    this.title,
    this.description,
    this.imageUrl,
    this.onTap,
    this.onLongTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongTap,
      onTap: onTap,
      child: Container(
        // width: 165,
        width: Get.width * .45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: AppColors.customWhiteColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.customShadowColor,
                offset: const Offset(0, 1),
                spreadRadius: 1,
                blurRadius: 2,
              )
            ]),
        child: Column(
          children: [
            Container(
                height: 134,
                decoration: BoxDecoration(
                    color: AppColors.customHintTextColor,
                    borderRadius: BorderRadius.circular(5.r)),
                child: imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(5.r),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                color: AppColors.customThemeColor,
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.photo_outlined)),
                        ),
                      )
                    : const SizedBox(
                        child: Center(child: Icon(Icons.photo_outlined)),
                      )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    description!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: Get.height * .02,
                  ),
                  // Text(
                  //   '\$$price',
                  //   style: const TextStyle(
                  //     fontWeight: FontWeight.w500,
                  //     fontSize: 14,
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * .01,
            ),
          ],
        ),
      ),
    );
  }
}
