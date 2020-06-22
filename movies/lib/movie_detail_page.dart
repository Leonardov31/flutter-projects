import 'package:flutter/material.dart';

import 'models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  final String imgPath = 'https://image.tmdb.org/t/p/w500';

  const MovieDetailScreen({this.movie});

  @override
  Widget build(BuildContext context) {
    String path;
    if (movie.posterPath != null) {
      path = imgPath + movie.posterPath;
    } else {
      path =
          'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    }

    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 16, top: 10),
                height: screenHeight / 1.5,
                child: Image.network(path),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(movie.overview),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
