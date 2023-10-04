import 'package:flutter/material.dart';

import '../../widgets/custom_text.dart';

class AdvertisementCard extends StatelessWidget {
  const AdvertisementCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 200.0, left: 16, right: 16),
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 1, blurStyle: BlurStyle.normal)
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        height: 36,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(8),
                            color: Colors.red),
                        child: Center(
                            child: customText(
                                const Color(0xffFFFFFF),
                                'Promo',
                                FontWeight.w600,
                                14)),
                      ),
                    customText(Colors.black, 'Buy one get  one Free', FontWeight.w900, 24),
                      
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 160,
                child: Image.asset(
                  'assets/images/coffecup.png',
                  fit: BoxFit.cover,
                ),
              ),
               
            ],
            
          ),
        ),
      ),
    );
  }
}