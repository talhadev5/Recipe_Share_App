import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/controller/controller.dart';
import 'package:recipe_app/modules/allrecipes/details.dart';
import 'package:recipe_app/modules/auth/login/view.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/custom_appbar.dart';
import 'package:recipe_app/widgets/custom_suggestion_recipes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'logic.dart';

class DasboardPage extends StatefulWidget {
  const DasboardPage({super.key});

  @override
  State<DasboardPage> createState() => _DasboardPageState();
}

class _DasboardPageState extends State<DasboardPage> {
  final logic = Get.put(DasboardLogic());

  final state = Get.find<DasboardLogic>().state;
  late Future<List<Map<String, dynamic>>> recipesFuture;

  @override
  void initState() {
    super.initState();
    recipesFuture = logic.fetchRecipes();
    userRole = Get.find<GeneralController>().getUserRole();
  }

  String? userRole;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DasboardLogic>(builder: (logic) {
      return Scaffold(
        appBar: CustomAppbar(
          text: 'Dasboard',
          leading: const Icon(null),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: userRole == 'admin'
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          auth.signOut();
                          Get.offAll(() => LoginPage());
                        });
                      },
                      icon: const Icon(Icons.logout))
                  : const SizedBox(),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * .02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Food Competitions',
                    style: state.textTextStyle,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              // Slider...............
              CarouselSlider(
                items: [
                  Image.asset('assets/baner1.png'),
                  Image.asset('assets/baner2.png'),
                  Image.asset('assets/baner3.png'),
                ],
                options: CarouselOptions(
                  height: 180,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayCurve: Curves.easeInOutCirc,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  pauseAutoPlayOnTouch: true,
                  onPageChanged: (index, reason) {
                    logic.sliderIndex = index;
                    logic.update();
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: AnimatedSmoothIndicator(
                  activeIndex: logic.sliderIndex,
                  count: 3,
                  effect: const WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    dotColor: AppColors.customHintTextColor,
                    activeDotColor: AppColors.customThemeColor,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * .02,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Recommend Recipes',
                    style: state.textTextStyle,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: recipesFuture,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No recipes found'));
                    }

                    return Wrap(
                      spacing: 15,
                      runSpacing: 10,
                      children: snapshot.data!.map((data) {
                        return SuggestionRecipes(
                          onLongTap: () {
                            final userRole =
                                Get.find<GeneralController>().getUserRole();
                            log(userRole);
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
                          },
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
                          title: data['recipe_name'] ?? 'No Name',
                          description: data['ingredients'] ?? 'No Ingredients',
                          imageUrl: data['image_url'],
                        );
                      }).toList(),
                    );
                  }),

              SizedBox(
                height: Get.height * .15,
              ),
            ],
          ),
        ),
      );
    });
  }
}
