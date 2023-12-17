import 'package:ui/models/movie_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<MovieModal>> fetchRomanceData() async {
  final response = await http.get(
      Uri.parse('https://restapi-movie-default-rtdb.firebaseio.com/movie/romance.json'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    List<MovieModal> romanceList = [];

    data.forEach((id, value) {
      romanceList.add(MovieModal(
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

    return romanceList;
  } else {
    throw Exception('Failed to load isekai data');
  }
}