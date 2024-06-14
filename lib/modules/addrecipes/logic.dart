import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/widgets/custom_snackbar.dart';

import 'state.dart';

class AddrecipesLogic extends GetxController {
  final AddrecipesState state = AddrecipesState();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool dataloading = false;
  get formKey => _formKey;
  File? imagePick;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    // image = File(pickedFile!.path);

    if (pickedFile != null) {
      imagePick = File(pickedFile.path);
      update();
      return showSnackBar('Message', 'Image picked successfully');
    } else {
      showSnackBar('Message', 'No image picked');
    }
  }

  addRecipe() async {
    if (_formKey.currentState!.validate()) {
      dataloading = true;
      update();
      String? imageUrl;
      if (imagePick != null) {
        // Upload the image to Firebase Storage
        String imageId = DateTime.now().millisecondsSinceEpoch.toString();
        UploadTask uploadTask = FirebaseStorage.instance
            .ref()
            .child('recipe_images')
            .child(imageId)
            .putFile(imagePick!);

        TaskSnapshot taskSnapshot = await uploadTask;
        imageUrl = await taskSnapshot.ref.getDownloadURL();
      }
      final fireStore = FirebaseFirestore.instance.collection('recipes');
      String id = DateTime.now().millisecondsSinceEpoch.toString();

      try {
        await fireStore.doc(id).set({
          'id': id,
          'recipe_name': state.recipeNameController!.text.trim(),
          'category_name': state.categoryController!.text.trim(),
          'ingredients': state.ingrediController!.text.trim(),
          'instructions': state.instructionController!.text.trim(),
          'image_url': imageUrl,
        });
        // Handle success, e.g., show a success message
        showSnackBar('Message', 'Recipe added successfully');
        // Clear the text controllers and image picker
        state.recipeNameController!.clear();
        state.categoryController!.clear();
        state.ingrediController!.clear();
        state.instructionController!.clear();
        imagePick = null;
        update();
      } catch (error) {
        // Handle error, e.g., show an error message
        showSnackBar('Message', 'Failed to add recipe');
        log(error.toString());
      } finally {
        dataloading = false;
        update();
      }
    }
  }
// .................admin ADD POST 
 addAdminRecipe() async {
    if (_formKey.currentState!.validate()) {
      dataloading = true;
      update();
      String? imageUrl;
      if (imagePick != null) {
        // Upload the image to Firebase Storage
        String imageId = DateTime.now().millisecondsSinceEpoch.toString();
        UploadTask uploadTask = FirebaseStorage.instance
            .ref()
            .child('Adminrecipe_images')
            .child(imageId)
            .putFile(imagePick!);

        TaskSnapshot taskSnapshot = await uploadTask;
        imageUrl = await taskSnapshot.ref.getDownloadURL();
      }
      final fireStore = FirebaseFirestore.instance.collection('adminrecipes');
      String id = DateTime.now().millisecondsSinceEpoch.toString();

      try {
        await fireStore.doc(id).set({
          'id': id,
          'recipe_name': state.recipeNameController!.text.trim(),
          'category_name': state.categoryController!.text.trim(),
          'ingredients': state.ingrediController!.text.trim(),
          'instructions': state.instructionController!.text.trim(),
          'image_url': imageUrl,
        });
        // Handle success, e.g., show a success message
        showSnackBar('Message', 'Recipe added successfully');
        // Clear the text controllers and image picker
        state.recipeNameController!.clear();
        state.categoryController!.clear();
        state.ingrediController!.clear();
        state.instructionController!.clear();
        imagePick = null;
        update();
      } catch (error) {
        // Handle error, e.g., show an error message
        showSnackBar('Message', 'Failed to add recipe');
        log(error.toString());
      } finally {
        dataloading = false;
        update();
      }
    }
  }

}
