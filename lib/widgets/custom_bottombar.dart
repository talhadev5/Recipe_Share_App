// ignore_for_file: deprecated_member_use
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/modules/addrecipes/admin_post.dart';
import 'package:recipe_app/modules/addrecipes/view.dart';
import 'package:recipe_app/modules/allrecipes/view.dart';
import 'package:recipe_app/modules/dasboard/view.dart';
import 'package:recipe_app/modules/ingredients/view.dart';
import 'package:recipe_app/modules/profile/feedback.dart';
import 'package:recipe_app/modules/profile/view.dart';
import 'package:recipe_app/utils/colors.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

int selectedIndex = 0;
List<Widget> currentPages = [
  DasboardPage(),
  const AllrecipesPage(),
  AddrecipesPage(),
  IngredientsPage(),
   ProfilePage(),
];
bool selectCart = false;
List<TabItem> screenItems = [
  const TabItem(
    icon: Icons.home_outlined,
    title: 'Home',
  ),
  const TabItem(
    icon: Icons.fastfood_outlined,
    title: 'Recipes',
  ),
  const TabItem(
    icon: Icons.post_add,
    title: 'Add',
  ),
  const TabItem(
    icon: Icons.paste_outlined,
    title: 'Ingredients',
  ),
  const TabItem(
    icon: Icons.person_outline,
    title: 'Profile',
  ),
];

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.customScaffoldColor,
      bottomNavigationBar: BottomBarCreative(
          highlightStyle: HighlightStyle(
            background: selectCart == true
                ? AppColors.customBlackColor
                : AppColors.customThemeColor,
            elevation: 1,
          ),
          enableShadow: true,
          isFloating: true,
          items: screenItems,
          indexSelected: selectedIndex,
          // paddingVertical: 25,
          onTap: (int index) => setState(() {
                selectedIndex = index;
                if (selectedIndex == 2) {
                  selectCart == true;
                }
              }),
          backgroundColor: AppColors.customWhiteColor,
          color: AppColors.customBlackColor,
          colorSelected: AppColors.customThemeColor),
      body: IndexedStack(
        index: selectedIndex,
        children: currentPages,
      ),
    );
  }
}

// admin bottom bar..............
class CustomAdminBottomBar extends StatefulWidget {
  const CustomAdminBottomBar({super.key});

  @override
  State<CustomAdminBottomBar> createState() => _CustomAdminBottomBarState();
}

int aselectedIndex = 0;
List<Widget> acurrentPages = [
  DasboardPage(),
  const AllrecipesPage(),
  AddAdminRecipesPage(),
  IngredientsPage(),
  FeedbackPage(),
];
bool aselectCart = false;
List<TabItem> ascreenItems = [
  const TabItem(
    icon: Icons.home_outlined,
    title: 'Home',
  ),
  const TabItem(
    icon: Icons.fastfood_outlined,
    title: 'Recipes',
  ),
  const TabItem(
    icon: Icons.post_add,
    title: 'Add',
  ),
  const TabItem(
    icon: Icons.paste_outlined,
    title: 'Ingredients',
  ),
  const TabItem(
    icon: Icons.feedback_outlined,
    title: 'Feedback',
  ),
];

class _CustomAdminBottomBarState extends State<CustomAdminBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.customScaffoldColor,
      bottomNavigationBar: BottomBarCreative(
          highlightStyle: HighlightStyle(
            background: aselectCart == true
                ? AppColors.customBlackColor
                : AppColors.customThemeColor,
            elevation: 1,
          ),
          enableShadow: true,
          isFloating: true,
          items: ascreenItems,
          indexSelected: aselectedIndex,
          // paddingVertical: 25,
          onTap: (int index) => setState(() {
                aselectedIndex = index;
                if (aselectedIndex == 2) {
                  aselectCart == true;
                }
              }),
          backgroundColor: AppColors.customWhiteColor,
          color: AppColors.customBlackColor,
          colorSelected: AppColors.customThemeColor),
      body: IndexedStack(
        index: aselectedIndex,
        children: acurrentPages,
      ),
    );
  }
}
