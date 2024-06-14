import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:recipe_app/widgets/custom_snackbar.dart';

import 'state.dart';

class DasboardLogic extends GetxController {
  final DasboardState state = DasboardState();
  int sliderIndex = 0;
  Future<List<Map<String, dynamic>>> fetchRecipes() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('adminrecipes').get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

// delete.........
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> deleteRecipe(String id) async {
    try {
      await firestore.collection('adminrecipes').doc(id).delete();
      showSnackBar('Message', 'Recipe deleted successfully!');
    } catch (e) {
      log('Error deleting recipe: $e');
    }
  }
}
