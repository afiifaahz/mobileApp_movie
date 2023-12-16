import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/models/category_movie.dart';
import 'package:ui/screens/list_movie.dart';
import 'package:ui/screens/list_movie2.dart';
import 'package:ui/screens/list_movie3.dart';
import 'package:ui/screens/list_movieA.dart';


class KategoriCard extends StatelessWidget {
  int selectedCategory = 0; // Ganti dengan nilai default atau sesuaikan dengan logika aplikasi Anda

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final isSelected = selectedCategory == index;
          final targetColor =
              isSelected ? Colors.white : Color.fromARGB(255, 46, 45, 46).withOpacity(.3);

          return GestureDetector(
            onTap: () {
              // Aksi berdasarkan kategori yang dipilih
              handleCategoryTap(context, kategoriM[index].name);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF818AF9) : const Color(0xFFF6F6F6),
                border: isSelected
                    ? Border.all(
                        color: const Color(0xFFF1E5E5).withOpacity(.22),
                        width: 2,
                      )
                    : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  kategoriM[index].name,
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: targetColor,
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemCount: kategoriM.length,
      ),
    );
  }

  void handleCategoryTap(BuildContext context, String categoryName) {
    // Ganti dengan logika atau aksi yang sesuai untuk setiap kategori
    if (categoryName == "Action") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListViewMovie(),
        ),
      );
    } else if (categoryName == "Romance") {
      // Tambahkan aksi untuk kategori Romance
       Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListViewMovieR(),
        ),
      );
    } else if (categoryName == "Horror") {
      // Tambahkan aksi untuk kategori Horror
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListViewMovieH(),
        ),
      );
    } else if (categoryName == "Animation") {
      // Tambahkan aksi untuk kategori Animation
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListViewMovieAnn(),
        ),
      );
    }
    // Anda dapat menambahkan logika untuk kategori lain jika diperlukan
  }
}
