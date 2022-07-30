import 'package:flutter/material.dart';

class Song {
  final String rank;
  final String name;
  final String Artists;
  final String imageUrl;

  const Song({
    @required this.rank,
    @required this.name,
    @required this.Artists,
    @required this.imageUrl,
  });
}
