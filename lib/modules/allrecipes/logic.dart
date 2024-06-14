import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:recipe_app/widgets/custom_snackbar.dart';

import 'state.dart';

class AllrecipesLogic extends GetxController {
  final AllrecipesState state = AllrecipesState();
  // delete.........
FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> deleteRecipe(String id) async {
    try {
      await firestore.collection('recipes').doc(id).delete();
      showSnackBar('Message','Recipe deleted successfully!');
    } catch (e) {
      log('Error deleting recipe: $e');
    }
  }
  
}
