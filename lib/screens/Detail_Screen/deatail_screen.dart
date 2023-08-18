import 'package:coffeeproject/core/Model/productmodel.dart';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_text.dart';
import '../Cart_Screen/cart_screen.dart';

// ignore: must_be_immutable
class DetailScreen extends ConsumerStatefulWidget {
  Product product;
  DetailScreen(
    this.product, {
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          toolbarHeight: 50,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Center(
              child: customText(Colors.black, 'Detail', FontWeight.w600, 16)),
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.black,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: IconButton(
                  onPressed: () {},
                  icon: Stack(
                    children: [
                      IconButton(
                        iconSize: 24,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartScreen(),
                              ));
                        },
                        icon: const Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.black,
                        ),
                      ),
                      const Positioned(
                          bottom: 8,
                          left: 3,
                          child: Stack(
                            children: [
                              Icon(
                                Icons.brightness_1,
                                size: 20,
                                color: Colors.red,
                              ),
                              Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '0',
                                        //cartlist.length.toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      )))
                            ],
                          ))
                    ],
                  )),
            ),
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 240,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(blurRadius: 0, blurStyle: BlurStyle.normal)
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.product.image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                 
                    child: Text(DateFormat('d - M - yyyy h:mm a ')
                        .format(widget.product.date)),
                  ),
                   const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                
                    width: 210,
                    child: Text(
                      widget.product.category.toString(),
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontStyle: FontStyle.normal,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: customText(const Color(0xff828282),
                    widget.product.title.toString(), FontWeight.w600, 14),
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 16,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  customText(Colors.black, widget.product.rating.toString(),
                      FontWeight.w600, 12),
                  customText(const Color(0xff828282), '(2500 reviews)',
                      FontWeight.w500, 12),
                ],
              ),
              const SizedBox(
                height: 21,
              ),
              Container(
                width: 327,
                height: 2,
                color: const Color(0xffF1F1F1),
              ),
              const SizedBox(
                height: 7,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(Colors.black, 'Description', FontWeight.w600, 16),
                  SizedBox(
                    height: 120,
                    child: ExpandableText(
                      widget.product.description.toString(),
                      expandText: 'Read more',
                      collapseText: 'Read less',
                      maxLines: 3,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff828282)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      customText(const Color(0xff222222), 'Price',
                          FontWeight.w700, 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: customText(
                            const Color(0xff828282),
                            'NGN${widget.product.price.toString()}',
                            FontWeight.w700,
                            16),
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                    width: 108,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 0.5, blurStyle: BlurStyle.normal)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.minimize,
                            size: 14,
                          ),
                          onPressed: () {},
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          child: const Text('2'),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            size: 18,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
