import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/homeScreen.dart';
import 'package:http/http.dart';
import './global_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final url = "https://jsonplaceholder.typicode.com/photos";
  var _postsJson = [];

  void fetchPosts() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;
      setState(() {
        _postsJson = jsonData;
      });
    } catch (err) {
      // add error widget here
    }
  }

  @override
  void initState() {
    
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text('SpotiStats'),
            bottom: TabBar(
              unselectedLabelColor: Colors.grey[100],
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Color.fromARGB(255, 7, 255, 16),
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              isScrollable: true,
              enableFeedback: true,
              indicatorWeight: 3,
              indicatorColor: Color.fromARGB(255, 7, 255, 16),
              tabs: [
                Tab(
                  icon: Icon(Icons.home_filled),
                  text: 'Overview',
                ),
                Tab(
                  icon: Icon(Icons.trending_up_rounded),
                  text: 'Top',
                ),
                Tab(
                  icon: Icon(Icons.align_vertical_bottom_rounded),
                  text: 'Stats',
                ),
                Tab(
                  icon: Icon(Icons.people_alt_outlined),
                  text: 'Friends',
                ),
                Tab(
                  icon: Icon(Icons.public_rounded),
                  text: 'Global',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              HomeScreen(),
              HomeScreen(),
              HomeScreen(),
              HomeScreen(),
              Global(),
              //CategoriesScreen(),
              //FavouritesScreen(),
            ],
          ),
        ));
  }
}