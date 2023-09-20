import 'package:coffeeproject/core/riverpod/adjustquantity_provider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../../core/models/product/product.dart';
import '../../core/riverpod/dashboard_screen_providers/monthlyfinance_provider.dart';

import '../../core/riverpod/dashboard_screen_providers/piegraph_provider.dart';
import '../../widgets/custom_text.dart';

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
    List<Product> monthlyFinance = ref.watch(monthlyFinanceProvider);

    final provider = ref.watch(adjustQuantityprovider);
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
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => CartScreen(),
                          //     ));
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
                    .format(DateTime.fromMillisecondsSinceEpoch(widget.product.createdatdate))),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  Container(
                    height: 30,
                    width: 116,
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
                            size: 13,
                          ),
                          onPressed: () {
                            ref
                                .read(adjustQuantityprovider.notifier)
                                .decreseSegmentedValue();
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          child: Text('${provider.quantity}'),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            size: 14,
                          ),
                          onPressed: () {
                            ref
                                .read(adjustQuantityprovider.notifier)
                                .increseSegmentedValue(
                                    widget.product.totalquantity,
                                    widget.product.soldquantity);
                          },
                        )
                      ],
                    ),
                  )
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
                    height: 160,
                    child: ExpandableText(
                      widget.product.description.toString(),
                      expandText: 'Read more',
                      collapseText: 'Read less',
                      maxLines: 3,
                      style: const TextStyle(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff828282)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
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
                            'Rs.${widget.product.soldprice.toString()}',
                            FontWeight.w700,
                            16),
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                    width: 108,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey,
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 0.5, blurStyle: BlurStyle.normal)
                        ]),
                    child: TextButton(
                        onPressed: () {
                          if (monthlyFinance.contains(widget.product)) {
                            if (widget.product.soldquantity >=
                                widget.product.totalquantity) {
                              Fluttertoast.showToast(
                                  msg: 'Cannot buy, already sold all',
                                  backgroundColor: Colors.red);
                            } else {
                             
                              ref
                                  .read(pieGraphProvider.notifier)
                                  .updateDateSoldProducts(
                                      widget.product.id,DateTime.now());
                                       ref
                                  .read(monthlyFinanceProvider.notifier)
                                  .updatedDateSoldProducts(
                                      widget.product.id,DateTime.now());
                              ref
                                  .read(adjustQuantityprovider.notifier)
                                  .updateSoldQuantity(widget.product.id,
                                      widget.product.soldquantity);
                                  
                                  
                              ref
                                  .read(adjustQuantityprovider.notifier)
                                  .resetquentity();
                              Fluttertoast.showToast(
                                  msg: ' Buy a product',
                                  backgroundColor: Colors.red);
                            }
                          } else {
                           
                            ref
                                .read(adjustQuantityprovider.notifier)
                                .updateSoldQuantity(widget.product.id,
                                    widget.product.soldquantity);
                                

                            ref
                                .read(pieGraphProvider.notifier)
                                .addSoldProduct(widget.product);
                              ref
                                .read(monthlyFinanceProvider.notifier)
                                .addSoldProducts(widget.product);
                         
                                 ref
                                  .read(monthlyFinanceProvider.notifier)
                                  .updatedDateSoldProducts(
                                      widget.product.id, DateTime.now(),);
                                      ref
                                  .read(pieGraphProvider.notifier)
                                  .updateDateSoldProducts(
                                      widget.product.id, DateTime.now(),);
                          
                            ref
                                .read(adjustQuantityprovider.notifier)
                                .resetquentity();

                            Fluttertoast.showToast(
                                msg: 'Buy a product',
                                backgroundColor: Colors.red);
                          }
                        },
                        child: const Center(
                            child: Text(
                          'Buy',
                          style: TextStyle(color: Colors.white),
                        ))),
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
