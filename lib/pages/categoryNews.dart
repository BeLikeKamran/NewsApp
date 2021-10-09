import 'package:flutter/material.dart';
import 'package:myapp/Model/ArticleModel.dart';
import 'package:myapp/pages/BlogTile.dart';
import 'package:myapp/service/news.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Flutter",
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.w600),
              ),
              Text(
                "News",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
              )
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: _loading
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
                      )
                    ],
                  ),
                ),
              ));
  }
}
