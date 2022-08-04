// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/material.dart';

// class bottomNav extends StatefulWidget {
//   const bottomNav({Key? key}) : super(key: key);

//   @override
//   State<bottomNav> createState() => _bottomNavState();
// }

// class _bottomNavState extends State<bottomNav> {
//   int _selectedIndex = 0;

//   List<Widget> _widgetOptions = <Widget>[
//     buyScreen(),
//     sellScreen(),
//     cartScreen(),
//     profileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(
//               Feather.home,
//               color: kGoodLightGray,
//             ),
//             title: Text('HOME'),
//             activeIcon: Icon(
//               Feather.home,
//               color: kGoodPurple,
//             ),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               FontAwesome.calendar,
//               color: kGoodLightGray,
//             ),
//             title: Text('CALENDAR'),
//             activeIcon: Icon(
//               FontAwesome.calendar,
//               color: kGoodPurple,
//             ),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               EvilIcons.user,
//               color: kGoodLightGray,
//               size: 36,
//             ),
//             title: Text('PROFILE'),
//             activeIcon: Icon(
//               EvilIcons.user,
//               color: kGoodPurple,
//               size: 36,
//             ),
//           ),
//         ],
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//       body: _widgetOptions.elementAt(_selectedIndex),
//     );
//   }
// }
