import 'package:flutter/material.dart';

class RecipeCategoryWidget extends StatelessWidget {
  const RecipeCategoryWidget({
    Key? key,
    required this.categoryImageUrl,
    required this.categoryTitle,
    this.onPressed,
  }) : super(key: key);

  final String categoryImageUrl;
  final String categoryTitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Positioned(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  categoryImageUrl,
                  fit: BoxFit.cover,
                  height: 250,
                  width: double.infinity,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black54,
                      Colors.black45,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )
                ),
                padding: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    categoryTitle,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}