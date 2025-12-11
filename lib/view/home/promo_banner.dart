import 'package:app_eyewear/view/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int i) {
        return Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          width: MediaQuery.of(context).size.width - 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              'assets/images/promocoes/promo-${i + 1}.png',
              fit: BoxFit.cover,
            ),
          ),
          foregroundDecoration: BoxDecoration(
            border: Border.all(width: 3, color: Layout.light(.8)),
            borderRadius: BorderRadius.circular(25),
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
}
