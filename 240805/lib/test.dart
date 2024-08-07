// import 'package:flutter/material.dart';
//
// class Tabs extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: 289,
//           height: 30,
//           clipBehavior: Clip.antiAlias,
//           decoration: BoxDecoration(),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(4),
//                     topRight: Radius.circular(4),
//                   ),
//                   border: Border.only(
//                     left: BorderSide(color: Color(0xFF303030)),
//                     top: BorderSide(color: Color(0xFF303030)),
//                     right: BorderSide(color: Color(0xFF303030)),
//                     bottom: BorderSide(width: 1, color: Color(0xFF303030)),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       '발전량',
//                       style: TextStyle(
//                         color: Color(0xFF303030),
//                         fontSize: 16,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w400,
//                         height: 0.09,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(4),
//                     topRight: Radius.circular(4),
//                   ),
//                   border: Border.only(
//                     left: BorderSide(color: Color(0xFFB1B1B1)),
//                     top: BorderSide(color: Color(0xFFB1B1B1)),
//                     right: BorderSide(color: Color(0xFFB1B1B1)),
//                     bottom: BorderSide(width: 1, color: Color(0xFFB1B1B1)),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       '기상',
//                       style: TextStyle(
//                         color: Color(0xFF767676),
//                         fontSize: 16,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w400,
//                         height: 0.09,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(4),
//                     topRight: Radius.circular(4),
//                   ),
//                   border: Border.only(
//                     left: BorderSide(color: Color(0xFFB1B1B1)),
//                     top: BorderSide(color: Color(0xFFB1B1B1)),
//                     right: BorderSide(color: Color(0xFFB1B1B1)),
//                     bottom: BorderSide(width: 1, color: Color(0xFFB1B1B1)),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       '대기오염 물질',
//                       style: TextStyle(
//                         color: Color(0xFF767676),
//                         fontSize: 16,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w400,
//                         height: 0.09,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(4),
//                     topRight: Radius.circular(4),
//                   ),
//                   border: Border.only(
//                     left: BorderSide(color: Color(0xFFB1B1B1)),
//                     top: BorderSide(color: Color(0xFFB1B1B1)),
//                     right: BorderSide(color: Color(0xFFB1B1B1)),
//                     bottom: BorderSide(width: 1, color: Color(0xFFB1B1B1)),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       '조도',
//                       style: TextStyle(
//                         color: Color(0xFF767676),
//                         fontSize: 16,
//                         fontFamily: 'Inter',
//                         fontWeight: FontWeight.w400,
//                         height: 0.09,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(4),
//                     topRight: Radius.circular(4),
//                   ),
//                   border: Border.only(
//                     left: BorderSide(color: Color(0xFFB1B1B1)),
//                     top: BorderSide(color: Color(0xFFB1B1B1)),
//                     right: BorderSide(color: Color(0xFFB1B1B1)),
//                     bottom: BorderSide(width: 1, color: Color(0xFFB1B1B1)),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                   ,
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }