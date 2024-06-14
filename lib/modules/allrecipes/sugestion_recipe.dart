import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/modules/allrecipes/logic.dart';
import 'package:recipe_app/widgets/custom_appbar.dart';

class SuggesetedRecipePage extends StatelessWidget {
  SuggesetedRecipePage({super.key});

  final logic = Get.put(AllrecipesLogic());

  final state = Get.find<AllrecipesLogic>().state;

  final _formKey = GlobalKey<FormState>();

  final _answers = <String, String>{};

  final List<Map<String, String>> _questions = [
    {'question': 'What is your favorite ingredient?', 'key': 'ingredient'},
    {'question': 'Do you have any dietary restrictions?', 'key': 'diet'},
    {'question': 'What type of cuisine do you prefer?', 'key': 'cuisine'},
  ];

  _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showRecipe(context);
    }
  }

  void _showRecipe(BuildContext context) {
    String recipe = _matchRecipe();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Recipe Suggestion'),
          content: Text(recipe),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _matchRecipe() {
    // Example matching logic based on user answers
    if (_answers['ingredient']!.toLowerCase() == 'chicken' &&
        _answers['diet']!.toLowerCase() == 'none' &&
        _answers['cuisine']!.toLowerCase() == 'italian') {
      return 'Grilled Chicken Parmesan';
    } else if (_answers['ingredient']!.toLowerCase() == 'tofu' &&
        _answers['diet']!.toLowerCase() == 'vegan' &&
        _answers['cuisine']!.toLowerCase() == 'asian') {
      return 'Stir-Fried Tofu with Vegetables';
    } else {
      return 'No matching recipe found.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        text: 'Save Recipes',
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
              children: _questions.map((question) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: question['question'],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please answer this question';
                  }
                  return null;
                },
                onSaved: (value) {
                  _answers[question['key']!] = value!;
                },
              ),
            );
          }).toList()
              // ..add(
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: ElevatedButton(
              //       onPressed: _submitForm(context),
              //       child: Text('Find Recipe'),
              //     ),
              //   ),
              // ),
              ),
        ),
      ),
    );
  }
}
