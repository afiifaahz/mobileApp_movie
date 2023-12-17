import 'package:ui/models/movie_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<MovieModal>> fetchHorrorData() async {
  final response = await http.get(
      Uri.parse('https://restapi-movie-default-rtdb.firebaseio.com/movie/horror.json'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    List<MovieModal> horrorList = [];

    data.forEach((id, value) {
      horrorList.add(MovieModal(
        id: id,
        nama: value['nama'],
        imageURL: value['imageURL'],
        kategori: value['kategori'],
        tahun: value['tahun'],
        durasi: value['durasi'],
        deskripsi: value['deskripsi'],
        rating: value['rating'],
      ));
    });

    return horrorList;
  } else {
    throw Exception('Failed to load isekai data');
  }
}