import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/custom_appbar.dart';

import 'logic.dart';

// ignore: must_be_immutable
class IngredientsPage extends StatelessWidget {
  IngredientsPage({super.key});

  final logic = Get.put(IngredientsLogic());
  final state = Get.find<IngredientsLogic>().state;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IngredientsLogic>(builder: (logic) {
      return Scaffold(
        appBar: const CustomAppbar(
          text: 'Ingredients',
          leading: Icon(null),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 55,
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      logic.filterIngredients(value);
                    },
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.customThemeColor)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.customThemeColor,
                        ),
                      ),
                      labelStyle: TextStyle(color: AppColors.customThemeColor),
                      labelText: 'Search...',
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.customThemeColor,
                      ),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: logic.ingredientsList.length,
                itemBuilder: (context, index) {
                  final ingredient = logic.ingredientsList[index];
                  if (ingredient == null) {
                    return Container(); // Handle null ingredient
                  }

                  final name = ingredient['name'];
                  final alternatives =
                      ingredient['alternatives'] as List<String>;

                  // Filter based on the search query
                  if (searchController.text.isNotEmpty &&
                      !name
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                    return Container(); // Return an empty container if the name doesn't match the search query
                  }

                  return ListTile(
                    title: Text(
                      name ??
                          '', // Use a default value or empty string if name is null
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        'Alternatives: ${alternatives?.join(", ") ?? ''}'), // Use null-aware operator
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
