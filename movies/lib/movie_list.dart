import 'package:flutter/material.dart';
import 'package:movies/movie_detail_page.dart';
import 'package:movies/services/http_helper.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int moviesCount;
  List movies;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-11843339.jpg';
  String result;
  HttpHelper helper;
  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar = Text('Filmes');

  Future initialize() async {
    movies = List();
    movies = await helper.getUpcoming();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  Future search(text) async {
    movies = await helper.findMovies(text);
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: <Widget>[
          IconButton(
              icon: this.visibleIcon,
              onPressed: () {
                setState(() {
                  if (this.visibleIcon.icon == Icons.search) {
                    this.visibleIcon = Icon(Icons.cancel);
                    this.searchBar = TextField(
                      textInputAction: TextInputAction.search,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      onSubmitted: (String text) {
                        print(text);
                        search(text);
                      },
                    );
                  } else {
                    this.visibleIcon = Icon(Icons.search);
                    this.searchBar = Text('Filmes');
                  }
                });
              }),
        ],
      ),
      body: ListView.builder(
        itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
        itemBuilder: (BuildContext context, int position) {
          if (movies[position].posterPath != null) {
            image = NetworkImage(this.iconBase + movies[position].posterPath);
          } else {
            image = NetworkImage(this.defaultImage);
          }
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: image,
              ),
              title: Text(movies[position].title),
              subtitle: Text(
                'Data de lançamento: ' +
                    movies[position].releaseDate +
                    ' | Nota: ' +
                    movies[position].voteAverage.toString(),
              ),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (_) => MovieDetailScreen(
                    movie: movies[position],
                  ),
                );
                Navigator.push(context, route);
              },
            ),
          );
        },
      ),
    );
  }
}
