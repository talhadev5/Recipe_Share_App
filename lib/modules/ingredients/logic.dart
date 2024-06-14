import 'package:get/get.dart';

import 'state.dart';

class IngredientsLogic extends GetxController {
  final IngredientsState state = IngredientsState();
  final List<Map<String, dynamic>> ingredientsList = [
    {
      'name': 'Salt',
      'alternatives': ['Kosher Salt', 'Sea Salt', 'Himalayan Salt']
    },
    {
      'name': 'Pepper',
      'alternatives': ['White Pepper', 'Cayenne Pepper', 'Paprika']
    },
    {
      'name': 'Olive Oil',
      'alternatives': ['Canola Oil', 'Vegetable Oil', 'Sunflower Oil']
    },
    {
      'name': 'Garlic',
      'alternatives': ['Garlic Powder', 'Shallots', 'Chives']
    },
    {
      'name': 'Onion',
      'alternatives': ['Shallots', 'Leeks', 'Green Onions']
    },
    {
      'name': 'Butter',
      'alternatives': ['Margarine', 'Coconut Oil', 'Ghee']
    },
    {
      'name': 'Flour',
      'alternatives': ['Whole Wheat Flour', 'Almond Flour', 'Coconut Flour']
    },
    {
      'name': 'Sugar',
      'alternatives': ['Honey', 'Maple Syrup', 'Agave Nectar']
    },
    {
      'name': 'Eggs',
      'alternatives': ['Flax Eggs', 'Chia Eggs', 'Apple Sauce']
    },
    {
      'name': 'Milk',
      'alternatives': ['Almond Milk', 'Soy Milk', 'Coconut Milk']
    },
    {
      'name': 'Tomatoes',
      'alternatives': ['Tomato Paste', 'Canned Tomatoes', 'Sun-Dried Tomatoes']
    },
    {
      'name': 'Basil',
      'alternatives': ['Oregano', 'Thyme', 'Parsley']
    },
    {
      'name': 'Parmesan Cheese',
      'alternatives': ['Pecorino Romano', 'Grana Padano', 'Asiago']
    },
    {
      'name': 'Chicken Breast',
      'alternatives': ['Turkey Breast', 'Tofu', 'Seitan']
    },
    {
      'name': 'Beef',
      'alternatives': ['Lamb', 'Pork', 'Turkey']
    },
    {
      'name': 'Potatoes',
      'alternatives': ['Sweet Potatoes', 'Yams', 'Turnips']
    },
    {
      'name': 'Carrots',
      'alternatives': ['Parsnips', 'Sweet Potatoes', 'Butternut Squash']
    },
    {
      'name': 'Celery',
      'alternatives': ['Fennel', 'Carrots', 'Bell Peppers']
    },
    {
      'name': 'Lettuce',
      'alternatives': ['Spinach', 'Kale', 'Arugula']
    },
    {
      'name': 'Lemon',
      'alternatives': ['Lime', 'Vinegar', 'Citric Acid']
    },
    {
      'name': 'Chocolate Chips',
      'alternatives': ['Carob Chips', 'Cocoa Nibs', 'Dark Chocolate']
    },
    {
      'name': 'Vanilla Extract',
      'alternatives': ['Almond Extract', 'Maple Extract', 'Vanilla Bean']
    },
    {
      'name': 'Yeast',
      'alternatives': ['Baking Powder', 'Baking Soda', 'Sourdough Starter']
    },
    {
      'name': 'Coconut Milk',
      'alternatives': ['Coconut Cream', 'Heavy Cream', 'Evaporated Milk']
    },
    {
      'name': 'Brown Sugar',
      'alternatives': ['Coconut Sugar', 'Maple Sugar', 'Molasses']
    },
    {
      'name': 'Tomato Sauce',
      'alternatives': ['Marinara Sauce', 'Pesto Sauce', 'White Sauce']
    },
    {
      'name': 'Mozzarella Cheese',
      'alternatives': ['Provolone Cheese', 'Cheddar Cheese', 'Fontina Cheese']
    },
    {
      'name': 'Broth',
      'alternatives': ['Stock', 'Bouillon', 'Vegetable Broth']
    },
    {
      'name': 'Rice',
      'alternatives': ['Quinoa', 'Couscous', 'Barley']
    },
    {
      'name': 'Pasta',
      'alternatives': ['Zucchini Noodles', 'Spaghetti Squash', 'Rice Noodles']
    },
    {
      'name': 'Cumin',
      'alternatives': ['Ground Coriander', 'Chili Powder', 'Curry Powder']
    },
    {
      'name': 'Paprika',
      'alternatives': ['Smoked Paprika', 'Chipotle Powder', 'Cayenne Pepper']
    },
    {
      'name': 'Cilantro',
      'alternatives': ['Parsley', 'Basil', 'Mint']
    },
    {
      'name': 'Ginger',
      'alternatives': ['Ground Ginger', 'Fresh Turmeric', 'Cinnamon']
    },
    {
      'name': 'Thyme',
      'alternatives': ['Rosemary', 'Sage', 'Marjoram']
    },
    {
      'name': 'Black Beans',
      'alternatives': ['Kidney Beans', 'Pinto Beans', 'Cannellini Beans']
    },
    {
      'name': 'Corn',
      'alternatives': ['Frozen Corn', 'Canned Corn', 'Fresh Corn']
    },
    {
      'name': 'Red Bell Pepper',
      'alternatives': [
        'Green Bell Pepper',
        'Yellow Bell Pepper',
        'Orange Bell Pepper'
      ]
    },
    {
      'name': 'Mushrooms',
      'alternatives': [
        'Portobello Mushrooms',
        'Shiitake Mushrooms',
        'Cremini Mushrooms'
      ]
    },
    {
      'name': 'Spinach',
      'alternatives': ['Kale', 'Collard Greens', 'Swiss Chard']
    },
    {
      'name': 'Artichokes',
      'alternatives': ['Hearts of Palm', 'Asparagus', 'Broccoli']
    },
    {
      'name': 'Zucchini',
      'alternatives': ['Yellow Squash', 'Eggplant', 'Cucumber']
    },
    {
      'name': 'Cabbage',
      'alternatives': ['Napa Cabbage', 'Savoy Cabbage', 'Red Cabbage']
    },
    {
      'name': 'Green Beans',
      'alternatives': ['Snap Peas', 'Asparagus', 'Broccoli']
    },
    {
      'name': 'Cauliflower',
      'alternatives': ['Broccoli', 'Romanesco', 'Cabbage']
    },
    {
      'name': 'Brussels Sprouts',
      'alternatives': ['Cabbage', 'Kale', 'Broccoli']
    },
    {
      'name': 'Eggplant',
      'alternatives': ['Zucchini', 'Yellow Squash', 'Cucumber']
    },
    {
      'name': 'Radishes',
      'alternatives': ['Turnips', 'Daikon Radish', 'Beets']
    },
    {
      'name': 'Asparagus',
      'alternatives': ['Broccolini', 'Green Beans', 'Snow Peas']
    },
    {
      'name': 'Parsnips',
      'alternatives': ['Carrots', 'Turnips', 'Sweet Potatoes']
    },
    {
      'name': 'Turnips',
      'alternatives': ['Rutabaga', 'Parsnips', 'Carrots']
    },
    {
      'name': 'Beets',
      'alternatives': ['Radishes', 'Turnips', 'Carrots']
    },
    {
      'name': 'Sweet Potatoes',
      'alternatives': ['Yams', 'Butternut Squash', 'Acorn Squash']
    },
    {
      'name': 'Butternut Squash',
      'alternatives': ['Acorn Squash', 'Kabocha Squash', 'Pumpkin']
    },
    {
      'name': 'Acorn Squash',
      'alternatives': [
        'Butternut Squash',
        'Kabocha Squash',
      ]
    }
  ];
 
  List<Map<String, dynamic>> _filteredIngredients = [];

  List<Map<String, dynamic>> get ingredientsLists => ingredientsList;

  List<Map<String, dynamic>> get filteredIngredients => _filteredIngredients;

  Future<void> initializeLogic() async {
    // Simulate some asynchronous initialization process
    await Future.delayed(const Duration(seconds: 2));

    // Set initial filtered ingredients to all ingredients
    _filteredIngredients.addAll(ingredientsList);
  }

  filterIngredients(String searchQuery) {
    _filteredIngredients.clear(); // Clear the previous filtered list

    if (searchQuery.isEmpty) {
      // If the search query is empty, show all ingredients
      _filteredIngredients.addAll(ingredientsList);
    } else {
      // Filter ingredients based on the search query
      _filteredIngredients.addAll(ingredientsList.where((ingredient) =>
          ingredient['name']
              .toLowerCase()
              .contains(searchQuery.toLowerCase())));
    }

    update(); 
  }

}
