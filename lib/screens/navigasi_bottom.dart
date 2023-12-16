import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ui/screens/home_screen.dart';
import 'package:ui/screens/list_allMovie.dart';

class NavigasiBottom extends StatelessWidget {
  const NavigasiBottom({Key? key});

  @override
  Widget build(BuildContext context) {
    return _bottomNavigationBar(context);
  }

  Container _bottomNavigationBar(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 40, 40, 78),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _iconFromFeather(FeatherIcons.home, () {
            // Aksi navigasi ke halaman Home
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }),
          _iconFromFeather(FeatherIcons.list, () {
            // Aksi navigasi ke halaman List
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ListViewAllMovie()),
            );
          }),
          // Tambahkan ikon dan aksi navigasi lainnya sesuai kebutuhan
        ],
      ),
    );
  }

  Widget _iconFromFeather(IconData icon, Function onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Icon(
        icon,
        size: 25,
        color: Colors.white,
      ),
    );
  }
}
