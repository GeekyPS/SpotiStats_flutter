import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final url = "https://jsonplaceholder.typicode.com/photos";
  var _postsJson = [];

  void fetchPosts() async {
    try {
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;
    
      setState(() {
        _postsJson = jsonData;
      });
    } catch (err) {}
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black87, Colors.black],
        ),
      ),
      child: ListView.builder(
          itemCount: _postsJson.length,
          itemBuilder: (context, index) {
            final posts = _postsJson[index];
            return ListTile(
              leading: Image.network(posts['url']),
              title: Text(
                posts['title'],
                style: TextStyle(color: Colors.white),
              ),
            );
          }),
    );
  }
}
