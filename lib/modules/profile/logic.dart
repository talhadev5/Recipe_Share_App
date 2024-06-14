import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'state.dart';

class ProfileLogic extends GetxController {
  final ProfileState state = ProfileState();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  get formKey => _formKey;
  bool dataloading = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  File? imagePick;
  String? imagePath;
  @override
  void onInit() {
    super.onInit();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        state.nameController!.text = data['name'] ?? '';
        state.phoneController!.text = data['phone'] ?? '';
        state.emailController!.text = data['email'] ?? '';
        imagePath = data['image']
            .toString(); // Assuming 'image' is the field for image URL
        if (imagePath!.isNotEmpty) {
          imagePick = File(imagePath!);
        }
        update();
      }
    }
  }

  Future<void> getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePick = File(pickedFile.path);
      update();
    }
  }

  Future<void> saveUserProfile() async {
    final User? user = auth.currentUser;
    if (user != null) {
      dataloading = true;
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': state.nameController!.text,
          'phone': state.phoneController!.text,
          'email': state.emailController!.text,
          'image': imagePath!, // Assuming 'image' is the field for image URL
        }, SetOptions(merge: true));

        Get.snackbar('Success', 'Profile updated successfully');
        dataloading = false;
      } catch (e) {
        Get.snackbar('Error', 'Failed to update profile');
        dataloading = false;
      }
    }
  }
}
