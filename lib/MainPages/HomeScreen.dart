import 'package:flutter/material.dart';
import 'package:myapp/MainPages/Drwer.dart';
import 'package:myapp/Model/ArticleModel.dart';
import 'package:myapp/Model/CategoryModel.dart';
import 'package:myapp/pages/BlogTile.dart';
import 'package:myapp/pages/CategoryTile.dart';
import 'package:myapp/service/data.dart';
import 'package:myapp/service/news.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            Text(" News",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      drawer: Drwer(),
      body:  _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    //  categories
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 70,
                      child: ListView.builder(
                          itemCount: categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              imageUrl: categories[index].imageUrl,
                              categoryName: categories[index].categoryName,
                            );
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          itemCount: articles.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return BlogTile(
                                imageUrl: articles[index].urlToImage,
                                title: articles[index].title,
                                desc: articles[index].description,
                                url: articles[index].url);
                          }),
                    )]
    ))));
  }
}
