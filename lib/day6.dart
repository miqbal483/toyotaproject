// import 'package:flutter/material.dart';

// class Day6 extends StatefulWidget {
//   const Day6({super.key});

//   @override
//   State<Day6> createState() => _day6();
// }

// class _day6 extends State<Day6> {
//   //simulasi load data dari api
//   Future<Image> fetchData() async {
//     await Future.delayed(const Duration(seconds: 5)); // Simulasi delay
//     //
//     return Image.asset('assets/image/veloz.jpg');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('fure builder example'),
//       ),
//       body: FutureBuilder(
//         future: fetchData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 'error: ${snapshot.error}',
//               ),
//             );
//           } else if (snapshot.hasData) {
//             final items = snapshot.data!;
//             return ListView.builder(
//                 itemCount: items.length
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(
//                       items.[index],
//                       ),
//                   );
//                 });
//           }
//         },
//       ),
//     );
//   }
// }
