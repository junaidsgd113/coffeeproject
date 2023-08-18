import 'package:flutter/material.dart';

import '../../widgets/custom_text.dart';

class AppBarText extends StatelessWidget {
  const AppBarText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.coffee_rounded,
                  color: Colors.white,
                  size: 38,
                ),
                customText(Colors.white, 'Coffee',
                    FontWeight.w800, 24)
              ],
            ),
            customText(
                Colors.white,
                'Arabica, Robusta, Excelsa and Liberica.',
                FontWeight.normal,
                12)
          ],
        ),
        SizedBox(
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/coffee.jpg',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
