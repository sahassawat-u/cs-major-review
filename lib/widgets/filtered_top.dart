// import 'package:flutter/material.dart';

// class FilteredTop extends StatelessWidget {
//   final List<String> uni;
//   final VoidCallback onTap_;
//   const FilteredTop({Key? key, required this.uni, required this.onTap_})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return 
//     uni.length != 0
//         ? Container(
//             width: double.infinity,
//             // decoration: BoxDecoration(border: Border.all(color: Color(0xff122F2D))),
//             // height: 90,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 for (var u in uni)
//                   GestureDetector(
//                     onTap: onTap_,
//                     child: Text(
//                       u,
//                     ),
//                   )
//               ],
//             ))
//         : Text("No match found", textAlign: TextAlign.center);
//   }
// }
