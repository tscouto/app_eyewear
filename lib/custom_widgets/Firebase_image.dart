// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class FirebaseImage extends StatelessWidget {
//   final String imagePath;
//   final Image Function(BuildContext, String ) builder;

//   const FirebaseImage({
//     super.key,
//     required this.imagePath,
//     required this.builder,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: FirebaseFirestore.instance.getDownloadURL(key: imagePath);
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.data != null) {
//           return this.builder(context, snapshot.data);
//         }
//           return Center(child: CircularProgressIndicator());
        
//       },
//     );
//   }
// }


//  FirebaseImage(
//                         imagePath: 'banner/prod-${i + 1}.jpg',
//                         builder: (BuildContext context, String imageSrc) {
//                           return Image.network(
//                             imageSrc,
//                             fit: BoxFit.cover,
//                             alignment: Alignment.center,
//                             width: MediaQuery.of(context).size.width - 40,
//                           );
//                         },
//                       ),