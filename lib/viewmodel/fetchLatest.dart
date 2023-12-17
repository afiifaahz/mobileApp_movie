import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ui/models/movie_model.dart';

Future<List<MovieModal>> fetchLatestData() async {
  final response = await http.get(
      Uri.parse('https://restapi-movie-default-rtdb.firebaseio.com/movie/latest.json'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    List<MovieModal> latestList = [];

    data.forEach((id, value) {
      latestList.add(MovieModal(
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

    return latestList;
  } else {
    throw Exception('Failed to load isekai data');
  }
}
