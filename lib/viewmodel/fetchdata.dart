import 'package:ui/models/movie_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<MovieModal>> fetchMovieData() async {
  final response = await http.get(
      Uri.parse('https://restapi-movie-default-rtdb.firebaseio.com/movie.json'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    List<MovieModal> movieList = [];

    // Iterasi melalui setiap kategori
    data.forEach((kategori, moviesInCategory) {
      // Iterasi melalui setiap film dalam kategori tertentu
      moviesInCategory.forEach((id, value) {
        movieList.add(MovieModal(
          id: id,
          nama: value['nama'],
          imageURL: value['imageURL'],
          kategori: kategori, // Menambahkan informasi kategori
          tahun: value['tahun'],
          durasi: value['durasi'],
          deskripsi: value['deskripsi'],
          rating: value['rating'],
        ));
      });
    });

    return movieList;
  } else {
    throw Exception('Failed to load movie data');
  }
}

