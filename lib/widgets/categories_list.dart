import 'package:flutter/material.dart';
import 'package:hostel_management_project/data/dummy_data.dart';
import 'package:hostel_management_project/widgets/card.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
          ),
          itemBuilder: (ctx, index) {
            return CardDesign(
              content: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      categories[index].image,
                      height: 64,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      categories[index].title,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              elevation: 1,
              radiusValue: 12,
              color: Colors.white70,
            );
          }),
    );
  }
}
