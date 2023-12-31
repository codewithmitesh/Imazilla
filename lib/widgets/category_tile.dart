// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '/view/search_query.dart';

class CategoryTile extends StatelessWidget {
  final String imgUrl, category;

  const CategoryTile({Key? key, required this.imgUrl, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchQuery(queryController: category),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(15),
            ),
        child: Stack(
          // fit: StackFit.expand,
          children: [
            ClipRRect(
              // borderRadius: BorderRadius.circular(50),
              child: Image.network(
                imgUrl,
                fit: BoxFit.cover,
                height: 50,
                width: 100,
              ),
            ),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black26],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                category,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
