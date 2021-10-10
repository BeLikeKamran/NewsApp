import 'package:flutter/material.dart';
import 'package:myapp/Model/CategoryModel.dart';
import 'package:myapp/pages/CategoryTile.dart';
import 'package:myapp/service/data.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<CategoryModel> categories = <CategoryModel>[];

  @override
  void initState() {
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 90,
      child: ListView.builder(
          itemCount: categories.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return CategoryTile(
              imageUrl: categories[index].imageUrl,
              categoryName: categories[index].categoryName,
            );
          }),
    );
  }
}
