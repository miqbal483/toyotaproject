// import 'package:flutter/material.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// class Latihanlagi extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false, // Hilangkan tulisan "debug" di layar
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Layout Sederhana"), // Judul aplikasi
//           backgroundColor: Colors.blue, // Warna merah
//         ),
//         body: Column(
//           mainAxisAlignment:
//               MainAxisAlignment.center, // Pusatkan semua di tengah
//           children: [
//             // Kotak besar
//             Container(
//               width: 150, // Ukuran lebar kotak
//               height: 150, // Ukuran tinggi kotak
//               color: Colors.blue, // Warna kotak merah
//             ),
//             SizedBox(height: 30), // Jarak antara kotak dan tombol
//             Row(
//               mainAxisAlignment:
//                   MainAxisAlignment.center, // Atur tombol di tengah
//               children: [
//                 // Tombol 1
//                 Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     color: Colors.greenAccent, // Warna tombol
//                     shape: BoxShape.circle, // Bentuk tombol lingkaran
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Tombol 1", // Tulisan di tombol
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 20), // Jarak antar tombol
//                 // Tombol 2
//                 Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     color: Colors.greenAccent,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Tombol 2",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 20), // Jarak antar tombol
//                 // Tombol 3
//                 Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     color: Colors.greenAccent,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Tombol 3",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
