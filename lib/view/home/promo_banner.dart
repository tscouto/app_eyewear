import 'package:app_eyewear/model/banner_model.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context ) {
    // return FutureBuilder(
    //   future: FirebaseStorage.instance
    //       .ref('banner/prod-1.jpg')
    //       .getDownloadURL(),
    //   builder: (BuildContext context, AsyncSnapshot<List<BannerModel>> snapshot) {
    //     if (snapshot.data != null) {
    //       // return this.builder(context, snapshot.data);
    //       return Center(child: CircularProgressIndicator());
    //     }

    //  if (snapshot.data.isEmpty) {
    //       return const Center(child: Container(
    //         decoration: BoxDecoration(
    //           color: Layout.light(),
    //           borderRadius: BorderRadius.circular(25),
    //         ),
    //         padding: EdgeInsets.all(15),
    //         margin: const EdgeInsets.symmetric(horizontal: 20),
    //         width: double.infinity,
    //         child: ChipRRect(
    //           borderRadius: BorderRadius.circular(25),
    //           child: Image.asset('assets/images/promocoes/promo-${i + 1}.png', fit: BoxFit.contain,))),
    //       ); 
    //     }

    return Swiper(
      itemBuilder: (BuildContext context, int i) {
      //  var item = snapshot.data![i];
        return Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          width: MediaQuery.of(context).size.width - 40,
          foregroundDecoration: BoxDecoration(
            border: Border.all(width: 3, color: Layout.light(.8)),
            borderRadius: BorderRadius.circular(25),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            // child: Image.network(
            //   'https://app-eyewear-banners.s3.sa-east-1.amazonaws.com/banners/prod-1.jpg',
            //   fit: BoxFit.cover,
            // ),
            child: Image.asset(
              'assets/images/promocoes/promo-${i + 1}.png',
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      itemCount: 3,
      autoplay: true,
      duration: 700,
      curve: Curves.easeInOutBack,
      pagination: SwiperPagination(),
      scale: .9,
      viewportFraction: 0.85,
    );
  }

  Future<List<BannerModel>> buscarListaDeBanners() async {
    final result = <BannerModel>[];

    final banners = await FirebaseFirestore.instance
        .collection('banner')
        .where('excluido', isEqualTo: false)
        .where('data_final', isGreaterThanOrEqualTo: Timestamp.now())
        .get();

    for (var item in banners.docs) {
      final banner = BannerModel.fromJson(
        item.reference,
        item.data() as Map<String, dynamic>,
      );

      if(banner.dataInicial!.compareTo(Timestamp.now()) != -1) {
        continue;
      }
      if(banner.dataFinal!.compareTo(Timestamp.now()) != 1) {
        continue;
      }
      result.add(banner);
    }

    return result;
  }
}
