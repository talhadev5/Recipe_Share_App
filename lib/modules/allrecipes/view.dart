// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:recipe_app/controller/controller.dart';
// import 'package:recipe_app/modules/allrecipes/details.dart';
// import 'package:recipe_app/utils/colors.dart';
// import 'package:recipe_app/widgets/custom_appbar.dart';
// import 'package:recipe_app/widgets/custom_suggestion_recipes.dart';

// import 'logic.dart';

// class AllrecipesPage extends StatefulWidget {
//   const AllrecipesPage({super.key});

//   @override
//   State<AllrecipesPage> createState() => _AllrecipesPageState();
// }

// class _AllrecipesPageState extends State<AllrecipesPage> {
//   final logic = Get.put(AllrecipesLogic());

//   final state = Get.find<AllrecipesLogic>().state;

//   TextEditingController searchController = TextEditingController();
//   List<Map<String, dynamic>> filteredRecipes = [];
//   final Set<String> savedRecipeIds = {};
//   late Stream<QuerySnapshot> recipesStream;

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedRecipes();
//     recipesStream =
//         FirebaseFirestore.instance.collection('recipes').snapshots();
//   }

//   Future<void> _loadSavedRecipes() async {
//     QuerySnapshot snapshot =
//         await FirebaseFirestore.instance.collection('saved_recipes').get();
//     setState(() {
//       savedRecipeIds.addAll(snapshot.docs.map((doc) => doc.id));
//     });
//   }

//   void filterRecipe(String query, AsyncSnapshot<QuerySnapshot> snapshot) {
//     setState(() {});
//   }

//   Future<void> saveRecipe(Map<String, dynamic> recipeData) async {
//     await FirebaseFirestore.instance
//         .collection('saved_recipes')
//         .add(recipeData);
//     setState(() {
//       savedRecipeIds.add(recipeData['id']);
//     });
//   }

//   Future<void> removeRecipe(String id) async {
//     // Remove from Firestore
//     var snapshots = await FirebaseFirestore.instance
//         .collection('saved_recipes')
//         .where('id', isEqualTo: id)
//         .get();
//     for (var doc in snapshots.docs) {
//       await doc.reference.delete();
//     }

//     // Remove from local state
//     setState(() {
//       savedRecipeIds.remove(id);
//     });
//   }

//   void filterRecipes(String query, AsyncSnapshot<QuerySnapshot> snapshot) {
//     setState(() {
//       filteredRecipes = snapshot.data!.docs
//           .where((document) =>
//               (document.data() as Map<String, dynamic>)['recipe_name']
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()))
//           .map((document) => document.data() as Map<String, dynamic>)
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AllrecipesLogic>(builder: (logic) {
//       return Scaffold(
//         appBar: const CustomAppbar(
//           text: 'Recipes',
//           leading: Icon(null),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: Get.height * .02,
//                 ),
//                 StreamBuilder<QuerySnapshot>(
//                   stream: recipesStream,
//                   builder: (BuildContext context,
//                       AsyncSnapshot<QuerySnapshot> snapshot) {
//                     if (snapshot.hasError) {
//                       return const Center(child: Text('Something went wrong'));
//                     }

//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(
//                           child: CircularProgressIndicator(
//                         color: AppColors.customThemeColor,
//                       ));
//                     }

//                     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                       return const Center(child: Text('No recipes found'));
//                     }

//                     // Filter the data based on search query
//                     List<DocumentSnapshot> filteredData =
//                         snapshot.data!.docs.where((document) {
//                       String recipeName = (document.data()
//                               as Map<String, dynamic>)['recipe_name'] ??
//                           '';
//                       return recipeName
//                           .toLowerCase()
//                           .contains(searchController.text.toLowerCase());
//                     }).toList();

//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 55,
//                           child: TextFormField(
//                             controller: searchController,
//                             onChanged: (value) {
//                               filterRecipes(value, snapshot);
//                             },
//                             decoration: const InputDecoration(
//                               focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: AppColors.customThemeColor)),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: AppColors.customThemeColor,
//                                 ),
//                               ),
//                               labelStyle:
//                                   TextStyle(color: AppColors.customThemeColor),
//                               labelText: 'Search Recipes',
//                               prefixIcon: Icon(
//                                 Icons.search,
//                                 color: AppColors.customThemeColor,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: Get.height * .04,
//                         ),
//                         if (filteredData.isEmpty)
//                           const Center(child: Text('No match found'))
//                         else
//                           Wrap(
//                             spacing: 17,
//                             runSpacing: 10,
//                             children:
//                                 filteredData.map((DocumentSnapshot document) {
//                               Map<String, dynamic> data =
//                                   document.data() as Map<String, dynamic>;
//                               String recipeId = document.id;
//                               bool isSaved = savedRecipeIds.contains(recipeId);
//                               return SuggestionRecipes(
//                                 title: data['recipe_name'] ?? 'No Name',
//                                 description:
//                                     data['ingredients'] ?? 'No Ingredients',
//                                 imageUrl: data['image_url'],
//                                 onLongTap: () {
//                                   final userRole = Get.find<GeneralController>()
//                                       .getUserRole();

//                                   if (userRole == 'admin') {
//                                     showDialog(
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: const Text('Delete Recipe?'),
//                                           content: const Text(
//                                               'Are you sure you want to delete this recipe?'),
//                                           actions: [
//                                             TextButton(
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                               },
//                                               child: const Text('Cancel'),
//                                             ),
//                                             TextButton(
//                                               onPressed: () {
//                                                 logic.deleteRecipe(data['id']);
//                                                 Navigator.of(context).pop();
//                                               },
//                                               child: const Text('Delete'),
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     );
//                                   }
//                                   logic.update();
//                                 },
//                                 onTap: () {
//                                   Get.to(() => RecipeDetails(
//                                         isSaved: isSaved,
//                                         onSave: () {
//                                           if (isSaved) {
//                                             removeRecipe(recipeId);
//                                           } else {
//                                             saveRecipe(
//                                                 {'id': recipeId, ...data});
//                                           }
//                                           logic.update();
//                                         },
//                                         name: data['recipe_name'] ?? 'No Name',
//                                         image: data['image_url'],
//                                         instruction: data['instructions'] ??
//                                             'instructions',
//                                         ingred: data['ingredients'] ??
//                                             'ingredients',
//                                         catagory: data['category_name'] ??
//                                             'category_name',
//                                       ));
//                                 },
//                               );
//                             }).toList(),
//                           ),
//                       ],
//                     );
//                   },
//                 ),
//                 SizedBox(
//                   height: Get.height * .15,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controller/controller.dart';
import 'package:recipe_app/modules/allrecipes/details.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/custom_appbar.dart';
import 'package:recipe_app/widgets/custom_suggestion_recipes.dart';
import 'logic.dart';

class AllrecipesPage extends StatefulWidget {
  const AllrecipesPage({super.key});

  @override
  State<AllrecipesPage> createState() => _AllrecipesPageState();
}

class _AllrecipesPageState extends State<AllrecipesPage> {
  final logic = Get.put(AllrecipesLogic());
  final state = Get.find<AllrecipesLogic>().state;

  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredRecipes = [];
  final Set<String> savedRecipeIds = {};
  late Stream<QuerySnapshot> recipesStream;

  @override
  void initState() {
    super.initState();
    _loadSavedRecipes();
    recipesStream =
        FirebaseFirestore.instance.collection('recipes').snapshots();
  }

  Future<void> _loadSavedRecipes() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('saved_recipes')
        .where('user_id', isEqualTo: user.uid)
        .get();
    setState(() {
      savedRecipeIds.addAll(snapshot.docs.map((doc) => doc.id));
    });
  }

  Future<void> saveRecipe(Map<String, dynamic> recipeData) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    await FirebaseFirestore.instance.collection('saved_recipes').add({
      ...recipeData,
      'user_id': user.uid,
    });
    setState(() {
      savedRecipeIds.add(recipeData['id']);
    });
  }

  Future<void> removeRecipe(String id) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    // Remove from Firestore
    var snapshots = await FirebaseFirestore.instance
        .collection('saved_recipes')
        .where('id', isEqualTo: id)
        .where('user_id', isEqualTo: user.uid)
        .get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }

    // Remove from local state
    setState(() {
      savedRecipeIds.remove(id);
    });
  }

  void filterRecipes(String query, AsyncSnapshot<QuerySnapshot> snapshot) {
    setState(() {
      filteredRecipes = snapshot.data!.docs
          .where((document) =>
              (document.data() as Map<String, dynamic>)['recipe_name']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .map((document) => document.data() as Map<String, dynamic>)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllrecipesLogic>(builder: (logic) {
      return Scaffold(
        appBar: const CustomAppbar(
          text: 'Recipes',
          leading: Icon(null),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * .02,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: recipesStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: AppColors.customThemeColor,
                      ));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No recipes found'));
                    }

                    // Filter the data based on search query
                    List<DocumentSnapshot> filteredData =
                        snapshot.data!.docs.where((document) {
                      String recipeName = (document.data()
                              as Map<String, dynamic>)['recipe_name'] ??
                          '';
                      return recipeName
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase());
                    }).toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 55,
                          child: TextFormField(
                            controller: searchController,
                            onChanged: (value) {
                              filterRecipes(value, snapshot);
                            },
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.customThemeColor)),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.customThemeColor,
                                ),
                              ),
                              labelStyle:
                                  TextStyle(color: AppColors.customThemeColor),
                              labelText: 'Search Recipes',
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.customThemeColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * .04,
                        ),
                        if (filteredData.isEmpty)
                          const Center(child: Text('No match found'))
                        else
                          Wrap(
                            spacing: 17,
                            runSpacing: 10,
                            children:
                                filteredData.map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;
                              String recipeId = document.id;
                              bool isSaved = savedRecipeIds.contains(recipeId);
                              return SuggestionRecipes(
                                title: data['recipe_name'] ?? 'No Name',
                                description:
                                    data['ingredients'] ?? 'No Ingredients',
                                imageUrl: data['image_url'],
                                onLongTap: () {
                                  final userRole = Get.find<GeneralController>()
                                      .getUserRole();

                                  if (userRole == 'admin') {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Delete Recipe?'),
                                          content: const Text(
                                              'Are you sure you want to delete this recipe?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                logic.deleteRecipe(data['id']);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Delete'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                  logic.update();
                                },
                                onTap: () {
                                  Get.to(() => RecipeDetails(
                                        isSaved: isSaved,
                                        onSave: () {
                                          if (isSaved) {
                                            removeRecipe(recipeId);
                                          } else {
                                            saveRecipe(
                                                {'id': recipeId, ...data});
                                          }
                                          logic.update();
                                        },
                                        name: data['recipe_name'] ?? 'No Name',
                                        image: data['image_url'],
                                        instruction: data['instructions'] ??
                                            'instructions',
                                        ingred: data['ingredients'] ??
                                            'ingredients',
                                        catagory: data['category_name'] ??
                                            'category_name',
                                      ));
                                },
                              );
                            }).toList(),
                          ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: Get.height * .15,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
