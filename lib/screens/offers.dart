// import 'dart:convert';
// import 'package:eventsapp/models/offers_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

// class Offers_Screen extends StatefulWidget {
//   @override
//   State<Offers_Screen> createState() => _Offers_ScreenState();
// }

// class _Offers_ScreenState extends State<Offers_Screen> {
//   Future<offers> getData() async {
//     final response =
//         await http.get(Uri.parse('http://192.168.1.110:8000/api/offer/'));

//     if (response.statusCode == 200) {
//       // If the server did return a 200 OK response,
//       // then parse the JSON.
//       return offer.fromJson(jsonDecode(response.body));
//     } else {
//       // If the server did not return a 200 OK response,
//       // then throw an exception.
//       throw Exception('Failed to load offers');
//     }
//   }

//   late Future<offer> futureOffer;

//   @override
//   void initState() {
//     super.initState();
//     futureOffer = getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Color(0XFFE4AAAD),
//           actions: [Icon(Icons.local_offer_outlined)],
//           title: Text('END OF SEASON')),
//       body: Center(
//           child: Padding(
//         padding: const EdgeInsets.all(20),
//         /*   child: FutureBuilder<offer>(
//                 future: futureOffer,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     if (snapshot.data == null) {
//                       return Text('Loading ...');
//                     } else {
//                       returnchild: Column(
//                         children: [
//                           Text(
//                               'The value of the offer will be deducted when the bill is paid in the hall'),
//                           Expanded(
//                             child: ListView.builder(
//                                 // itemCount: snapshot.data.,
//                                 itemCount: 3,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return Column(
//                                     children: [
//                                       SizedBox(
//                                         height: 50,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Icon(Icons.description),
//                                           SizedBox(
//                                             width: 6,
//                                           ),
//                                           Text('Description'),
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             // snapshot.data!.description,
//                                             'This is Mother day offer',
//                                             style: TextStyle(
//                                                 color: Colors.black54),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceAround,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Icon(Icons.local_offer_outlined),
//                                               SizedBox(
//                                                 width: 6,
//                                               ),
//                                               Text('Offer Name'),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Icon(Icons
//                                                   .money_off_csred_outlined),
//                                               SizedBox(
//                                                 width: 6,
//                                               ),
//                                               Text('Offer Value'),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceAround,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 //   snapshot.data!.name,
//                                                 'Mother day',
//                                                 style: TextStyle(
//                                                     color: Colors.black54),
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 //  snapshot.data!.value.toString(),
//                                                 '40',
//                                                 style: TextStyle(
//                                                     color: Colors.black54),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: 10.0,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceAround,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Icon(Icons.date_range_outlined),
//                                               SizedBox(
//                                                 width: 6,
//                                               ),
//                                               Text('Offer Start Date'),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Icon(Icons.date_range_outlined),
//                                               SizedBox(
//                                                 width: 6,
//                                               ),
//                                               Text('Offer End Date'),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceAround,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 //    snapshot.data!.start_date.toString(),
//                                                 '2022-05-14 00:00:01',
//                                                 style: TextStyle(
//                                                     color: Colors.black54),
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 // snapshot.data!.end_date.toString(),
//                                                 '2022-05-14 23:59:59',
//                                                 style: TextStyle(
//                                                     color: Colors.black54),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Icon(Icons.meeting_room_outlined),
//                                           SizedBox(
//                                             width: 6,
//                                           ),
//                                           Text('Hall Name'),
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             // snapshot.data!.halls,
//                                             'Cleopatra Hall, Al Saja Hall',
//                                             style: TextStyle(
//                                                 color: Colors.black54),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   );
//                                 }),
//                           ),
//                         ],
//                       ))));
//                     }
//                   } else if (snapshot.hasError) {
//                     return Text('${snapshot.error}');
//                   }
//                   return const CircularProgressIndicator();*/
//         /*   Column(
//                 children: [
//                   Text(
//                     'END OF SEASON',
//                     style: Theme.of(context).textTheme.headline5!.copyWith(
//                           color: Colors.black,
//                         ),
//                   ),
//                   Image(
//                     image: AssetImage('assets/images/on_board/image4.jpg'),
//                     height: 165,
//                     width: 400,
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),*/
//         //
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.description),
//                 SizedBox(
//                   width: 6,
//                 ),
//                 Text('Description'),
//               ],
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'This is Mother day offer',
//                   style: TextStyle(color: Colors.black54),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.local_offer_outlined),
//                     SizedBox(
//                       width: 6,
//                     ),
//                     Text('Offer Name'),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Icon(Icons.money_off_csred_outlined),
//                     SizedBox(
//                       width: 6,
//                     ),
//                     Text('Offer Value'),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       'Mother Day',
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                     // Text('$snapshot.data!.name'),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       '40',
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10.0,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.date_range_outlined),
//                     SizedBox(
//                       width: 6,
//                     ),
//                     Text('Offer Start Date'),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Icon(Icons.date_range_outlined),
//                     SizedBox(
//                       width: 6,
//                     ),
//                     Text('Offer End Date'),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       '2022-05-14 00:00:01',
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       '2022-05-14 23:59:59',
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.meeting_room_outlined),
//                 SizedBox(
//                   width: 6,
//                 ),
//                 Text('Hall Name'),
//               ],
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Cleopatra Hall, Al Saja Hall',
//                   style: TextStyle(color: Colors.black54),
//                 ),
//               ],
//             ),
//             Container(
//               width: 200,
//               child: Divider(
//                 height: 20,
//                 color: Colors.black,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.description),
//                 SizedBox(
//                   width: 6,
//                 ),
//                 Text('Description'),
//               ],
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'This is Ramadan offer',
//                   style: TextStyle(color: Colors.black54),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.local_offer_outlined),
//                     SizedBox(
//                       width: 6,
//                     ),
//                     Text('Offer Name'),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Icon(Icons.money_off_csred_outlined),
//                     SizedBox(
//                       width: 6,
//                     ),
//                     Text('Offer Value'),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       'Ramadan',
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       '50',
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10.0,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.date_range_outlined),
//                     SizedBox(
//                       width: 6,
//                     ),
//                     Text('Offer Start Date'),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Icon(Icons.date_range_outlined),
//                     SizedBox(
//                       width: 6,
//                     ),
//                     Text('Offer End Date'),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       '2022-08-11 10:00:00',
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       '2022-08-14 10:00:00',
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.meeting_room_outlined),
//                 SizedBox(
//                   width: 6,
//                 ),
//                 Text('Hall Name'),
//               ],
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Al Saja Hall',
//                   style: TextStyle(color: Colors.black54),
//                 ),
//               ],
//             ),
//             Container(
//               width: 200,
//               child: Divider(
//                 height: 20,
//                 color: Colors.black,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.description),
//                 SizedBox(
//                   width: 6,
//                 ),
//                 Text('Description'),
//               ],
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'This is Halloween offer',
//                   style: TextStyle(color: Colors.black54),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.local_offer_outlined),
//                     SizedBox(
//                       width: 6,
//                     ),
//                     Text('Offer Name'),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Icon(Icons.money_off_csred_outlined),
//                     SizedBox(
//                       width: 6,
//                     ),
//                     Text('Offer Value'),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       'Halloween',
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       '30',
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10.0,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.date_range_outlined),
//                     SizedBox(
//                       width: 6,
//                     ),
//                     Text('Offer Start Date'),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Icon(Icons.date_range_outlined),
//                     SizedBox(
//                       width: 6,
//                     ),
//                     Text('Offer End Date'),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       '2022-11-11 13:30:00',
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       '2022-11-13 13:30:00',
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.meeting_room_outlined),
//                 SizedBox(
//                   width: 6,
//                 ),
//                 Text('Hall Name'),
//               ],
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   // snapshot.data!.halls,
//                   'Cleopatra Hall',
//                   style: TextStyle(color: Colors.black54),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       )),
//       // ],
//       //  ),
//       /*  })
//             // ),
//             //],
//             //  );
//             ),
//         //},
//       ),*/
//     );

//     // ));
//   }
// }
