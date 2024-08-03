// ignore_for_file: unused_label

import 'package:flutter/material.dart';
import 'package:tugas_project4_giziqu/NewsPage.dart';
import 'package:tugas_project4_giziqu/SearchPage.dart';
import 'package:tugas_project4_giziqu/user/landingpage/landing_page.dart';
import '../../user/ProfilePage.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LandingPage()),
              );
            },
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewsPage()),
              );
            },
            icon: const Icon(Icons.newspaper),
          ),
          const SizedBox(width: 50),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:tugas_project4_giziqu/NewsPage.dart';
// import 'package:tugas_project4_giziqu/SearchPage.dart';
// import 'package:tugas_project4_giziqu/user/ProfilePage.dart';
// import 'package:tugas_project4_giziqu/user/landingpage/landing_page.dart';

// class BottomAppBarWidget extends StatefulWidget {
//   const BottomAppBarWidget({Key? key}) : super(key: key);

//   @override
//   _BottomAppBarWidgetState createState() => _BottomAppBarWidgetState();
// }

// class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
//   int _selectedIndex = 0;
//   final PageController _pageController = PageController();

//   final List<Widget> _pages = [
//     const LandingPage(),
//     const NewsPage(),
//     const SearchPage(),
//     const ProfilePage(),
//   ];

//   void _onItemTapped(int index) {
//     if (_selectedIndex != index) {
//       setState(() {
//         _selectedIndex = index;
//         _pageController.jumpToPage(index);
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         children: _pages,
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.white,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildBottomNavigationItem(
//               index: 0,
//               icon: Icons.home,
//               label: 'Beranda',
//             ),
//             _buildBottomNavigationItem(
//               index: 1,
//               icon: Icons.newspaper,
//               label: 'Berita',
//             ),
//             const SizedBox(width: 50),
//             _buildBottomNavigationItem(
//               index: 2,
//               icon: Icons.search,
//               label: 'Cari',
//             ),
//             _buildBottomNavigationItem(
//               index: 3,
//               icon: Icons.person,
//               label: 'Profil',
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBottomNavigationItem({
//     required int index,
//     required IconData icon,
//     required String label,
//   }) {
//     final isSelected = _selectedIndex == index;
//     return GestureDetector(
//       onTap: () => _onItemTapped(index),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             color: isSelected ? Colors.green : Colors.black,
//             size: isSelected ? 25.0 : 20.0,
//           ),
//           Text(
//             label,
//             style: TextStyle(
//               color: isSelected ? Colors.green : Colors.black,
//               fontSize: isSelected ? 14.0 : 12.0,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
