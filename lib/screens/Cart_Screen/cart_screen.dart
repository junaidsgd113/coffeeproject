import 'dart:io';

import 'package:coffeeproject/core/Model/productmodel.dart';
import 'package:coffeeproject/core/Riverpod/cartscreen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/custom_text.dart';

// ignore: must_be_immutable
class CartScreen extends ConsumerStatefulWidget {
   CartScreen({super.key,this.product});
Product ? product;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product> cartprovider=ref.watch(cartscreenprovider);
    return Scaffold(
        backgroundColor: const Color(0xffF4F6F8),
        appBar: AppBar(
            backgroundColor: const Color(0xffF4F6F8),
            toolbarHeight: 60,
            elevation: 0,
            leading: BackButton(
              color: const Color(0xff222222),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: LayoutBuilder(builder: (context, constraints) {
              return Center(
                  child: Text(
                'My Cart',
                style: TextStyle(
                    fontSize: constraints.maxWidth < 600 ? 20 : 30,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    color: Colors.black),
              ));
            }),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Color(0xff222222),
                  ))
            ]),
        body: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 23,
            ),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: cartprovider.length,
                itemBuilder: (context, index) {
                  return Container(
                      height: 126,
                      width: 350,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 3, color: Color(0xffF1F1F1)))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 23, bottom: 24),
                            child: Container(
                              height: 80,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 1,
                                        blurStyle: BlurStyle.normal)
                                  ]),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                   File(widget.product?.image??''),
                                  
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                   Padding(
                                    padding: EdgeInsets.only(top: 12, left: 14),
                                    child: SizedBox(
                                      width: 142,
                                      child: Text(
                                          cartprovider[index].title??'',
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              color: Color(0xff828282))),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                    ),
                                    child: IconButton(
                                        onPressed: () {
                                            ref
                                          .read(cartscreenprovider
                                              .notifier)
                                          .removeproductfromdb(
                                              cartprovider[index],);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                        )),
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4, left: 14),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 90,
                                      child: customText(const Color(0xff222222),
                                          'NGN${widget.product?.price ??''}', FontWeight.w700, 16),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 108,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                                blurRadius: 0.5,
                                                blurStyle: BlurStyle.normal)
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
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
                              )
                            ],
                          ),
                        ],
                      ));
                })),
                
                    bottomNavigationBar: LayoutBuilder(builder: (context, constraints) {
        return 
             InkWell(
                onTap: () {},
                child: Container(
                  height: 80,
                  width: 375,
                  decoration: const BoxDecoration(color: Color(0xffF4F6F8)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 164,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 22.0, top: 21),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customText(const Color(0xff828282), 'Total price',
                                    FontWeight.w500, 14),
                              //  customText(const Color(0xff828282), "NGN $totalPrice",
                                  //  FontWeight.w700, 16),
                              ]),
                        ),
                      ),
                      Container(
                        height: 56,
                        width: 172,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: const Color(0xff222222),
                        ),
                        child: customText(
                            const Color(0xffFFFFFF), 'Order', FontWeight.w700, 16),
                      ),
                    ],
                  ),
                ),
              ); 
                 }  ));
  }
}
