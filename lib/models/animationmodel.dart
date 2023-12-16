import 'dart:convert';
import 'package:http/http.dart' as http;

// Sesuaikan dengan model yang sebenarnya
class AnimationModal {
  final String id;
  final String nama;
  final String imageURL;
  final String kategori;
  final String tahun;
  final String durasi;
  final String deskripsi;
  final String rating;

  AnimationModal({
    required this.id,
    required this.nama,
    required this.imageURL,
    required this.kategori,
    required this.tahun,
    required this.durasi,
    required this.deskripsi,
    required this.rating,
  });
}

// ...

Future<List<AnimationModal>> fetchAnimationData() async {
  final response = await http.get(
      Uri.parse('https://restapi-movie-default-rtdb.firebaseio.com/movie/animation.json'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    List<AnimationModal> animationList = [];

    data.forEach((id, value) {
      animationList.add(AnimationModal(
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

    return animationList;
  } else {
    throw Exception('Failed to load isekai data');
  }
}
