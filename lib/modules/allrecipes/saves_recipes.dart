// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:recipe_app/modules/allrecipes/details.dart';
// import 'package:recipe_app/modules/allrecipes/logic.dart';
// import 'package:recipe_app/utils/colors.dart';
// import 'package:recipe_app/widgets/custom_appbar.dart';

// class SaveRecipesPage extends StatelessWidget {
//   SaveRecipesPage({super.key});
//   final logic = Get.put(AllrecipesLogic());

//   final state = Get.find<AllrecipesLogic>().state;
//   void deleteRecipe(String docId) async {
//     await FirebaseFirestore.instance
//         .collection('saved_recipes')
//         .doc(docId)
//         .delete();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbar(
//         text: 'Save Recipes',
//         leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: const Icon(Icons.arrow_back)),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream:
//             FirebaseFirestore.instance.collection('saved_recipes').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return const Center(child: Text('Something went wrong'));
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No saved recipes'));
//           }

//           return ListView(
//             children: snapshot.data!.docs.map((DocumentSnapshot document) {
//               Map<String, dynamic> data =
//                   document.data() as Map<String, dynamic>;
//               var isBookmarked = true.obs;
//               return Card(
//                 child: ListTile(
//                     trailing: IconButton(
//                       icon: Icon(
//                         isBookmarked.value
//                             ? Icons.bookmark
//                             : Icons.bookmark_outline,
//                         color: AppColors.customThemeColor,
//                       ),
//                       onPressed: () {
//                         deleteRecipe(document.id);
//                         isBookmarked.value = false;
//                       },
//                     ),
//                     onTap: () {
//                       Get.to(() => RecipeDetails(
//                             name: data['recipe_name'] ?? 'No Name',
//                             image: data['image_url'],
//                             instruction: data['instructions'] ?? 'instructions',
//                             ingred: data['ingredients'] ?? 'ingredients',
//                             catagory: data['category_name'] ?? 'category_name',
//                           ));
//                     },
//                     title: Text(
//                       data['recipe_name'] ?? 'No Name',
//                     ),
//                     subtitle: Text(
//                       data['ingredients'] ?? 'No Ingredients',
//                       style: const TextStyle(overflow: TextOverflow.ellipsis),
//                       maxLines: 1,
//                     ),
//                     leading: data['image_url'] != null
//                         ? Image.network(data['image_url'].toString())
//                         : Container(
//                             height: 45,
//                             width: 45,
//                             color: Colors.grey,
//                           )
//                     // leading: ClipRRect(
//                     //   borderRadius: BorderRadius.circular(5.r),
//                     //   child: CachedNetworkImage(
//                     //     imageUrl: data['image_url'] ?? '',
//                     //     fit: BoxFit.cover,
//                     //     progressIndicatorBuilder:
//                     //         (context, url, downloadProgress) => Center(
//                     //       child: CircularProgressIndicator(
//                     //           color: AppColors.customThemeColor,
//                     //           value: downloadProgress.progress),
//                     //     ),
//                     //     errorWidget: (context, url, error) =>
//                     //         const Center(child: Icon(Icons.photo_outlined)),
//                     //   ),
//                     // ),

//                     ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/modules/allrecipes/details.dart';
import 'package:recipe_app/modules/allrecipes/logic.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/custom_appbar.dart';
import 'package:recipe_app/widgets/custom_snackbar.dart';

class SaveRecipesPage extends StatelessWidget {
  SaveRecipesPage({super.key});
  final logic = Get.put(AllrecipesLogic());
  final state = Get.find<AllrecipesLogic>().state;

  // Method to delete a recipe from Firestore
// Method to delete a recipe from Firestore and show a Snackbar
  void deleteRecipe(String docId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('saved_recipes')
          .doc(docId)
          .delete();
      showSnackBar('message', 'Recipe successfully removed from saved recipes');
    } catch (e) {
      showSnackBar(
          'message', 'Failed to remove recipe. Please try again later');
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(
        appBar: CustomAppbar(
          text: 'Save Recipes',
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: const Center(child: Text('Please log in to view saved recipes')),
      );
    }

    return Scaffold(
      appBar: CustomAppbar(
        text: 'Save Recipes',
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('saved_recipes')
            .where('user_id', isEqualTo: user.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No saved recipes'));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              var isBookmarked = true.obs;
              return Obx(() => Card(
                    child: ListTile(
                      trailing: IconButton(
                        icon: Icon(
                          isBookmarked.value
                              ? Icons.bookmark
                              : Icons.bookmark_outline,
                          color: AppColors.customThemeColor,
                        ),
                        onPressed: () {
                          deleteRecipe(document.id, context);
                          isBookmarked.value = false;
                          showSnackBar(
                              'Message', 'Recipe are Unsaved Successful!');
                        },
                      ),
                      onTap: () {
                        Get.to(() => RecipeDetails(
                              name: data['recipe_name'] ?? 'No Name',
                              image: data['image_url'],
                              instruction:
                                  data['instructions'] ?? 'instructions',
                              ingred: data['ingredients'] ?? 'ingredients',
                              catagory:
                                  data['category_name'] ?? 'category_name',
                            ));
                      },
                      title: Text(data['recipe_name'] ?? 'No Name'),
                      subtitle: Text(
                        data['ingredients'] ?? 'No Ingredients',
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                        maxLines: 1,
                      ),
                      leading: data['image_url'] != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(5.r),
                              child: CachedNetworkImage(
                                imageUrl: data['image_url'] ?? '',
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.customThemeColor,
                                    value: downloadProgress.progress,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                        child: Icon(Icons.photo_outlined)),
                              ),
                            )
                          : Container(
                              height: 45,
                              width: 45,
                              color: Colors.grey,
                            ),
                    ),
                  ));
            }).toList(),
          );
        },
      ),
    );
  }
}
