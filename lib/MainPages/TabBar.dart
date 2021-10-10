import 'package:flutter/material.dart';
import 'package:myapp/MainPages/Favourite.dart';
import 'package:myapp/MainPages/HomeScreen.dart';
import 'package:myapp/Model/NewsModel.dart';
import 'package:myapp/User/Profile.dart';
import 'package:myapp/pages/CategoryList.dart';
import 'package:search_page/search_page.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key key}) : super(key: key);
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchPage<NEWS>(
                    onQueryUpdate: (s) => print(s),
                    items: news,
                    searchLabel: 'Search News',
                    suggestion: Center(
                      child: Text('Filter news by date, day or time'),
                    ),
                    failure: Center(
                      child: Text('No News found :('),
                    ),
                    filter: (report) => [
                      report.top,
                      report.surname,
                      report.news.toString(),
                    ],
                    builder: (report) => ListTile(
                      title: Text(report.top),
                      subtitle: Text(report.surname),
                      trailing: Text('${report.news} yo'),
                    ),
                  ),
                );
              },
              icon: Icon(Icons.search))
        ],
        title: Text("International News",
            style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w600)),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.star_rate), text: "Headlines"),
            Tab(
              icon: Icon(Icons.category),
              text: "Category",
            ),
            Tab(
              icon: Icon(Icons.favorite),
              text: "Favourite",
            ),
            Tab(
              icon: Icon(Icons.person),
              text: "Profile",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          HomeScreen(),
          CategoryList(),
          FavouriteScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
