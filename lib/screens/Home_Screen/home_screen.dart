import 'package:coffeeproject/core/riverpod/homescreen_provider.dart';
import 'package:coffeeproject/screens/addProduct_screen/addproduct_screen.dart';
import 'package:coffeeproject/screens/category_screen/addcategory_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/product/product.dart';
import '../../core/riverpod/categoryscreen_provider.dart';
import '../detail_screen/deatail_screen.dart';
import 'advertisement_card.dart';
import 'appbar_text.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await ref
            .read(homeScreenProvider.notifier)
            .fetchProducts();
             await ref.read(categoryScreenProvider.notifier).fetchCategorys();
  
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Product> homeprovider = ref.watch(homeScreenProvider);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: SpeedDial(
          backgroundColor: Colors.blueGrey,
            animatedIcon: AnimatedIcons.menu_close,
      children: [
         SpeedDialChild(
          child: Icon(Icons.add),
           backgroundColor: Colors.blueGrey,
          labelBackgroundColor:Colors.blueGrey, 
          labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
          label: 'Add Product',
          onTap: () {
             Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNewProductScreen()));
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.category),
          label: 'Add Category',
          backgroundColor: Colors.blueGrey,
          labelBackgroundColor:Colors.blueGrey, 
          labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
          onTap: () {
             Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNewCategoryScreen()));
          },
        ),
       
      ],
             
            ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Container(
                      height: 260,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            const AppBarText(),
                            const SizedBox(
                              height: 30,
                            ),
                            TextField(
                              style: const TextStyle(color: Colors.white),
                              // autofocus: true,
                              controller: textEditingController,
                              onChanged: (value) {
                                ref
                                    .read(homeScreenProvider.notifier)
                                    .searchProducts(value);
                              },
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xff313131),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none),
                                  hintText: 'Search Products...',
                                  hintStyle: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.white)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const AdvertisementCard(),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (MediaQuery.of(context).size.width < 500)
                        ? 2
                        : (MediaQuery.of(context).size.width < 900)
                            ? 4
                            : 7,
                    childAspectRatio: 1 / 1.5,
                    crossAxisSpacing: 14,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddNewProductScreen(
                                      product: homeprovider[index],
                                    ),
                                  ),
                                );
                              },
                              onLongPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(homeprovider[index]),
                                  ),
                                );
                              },
                              child: Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(
                                                0,
                                                2.0,
                                              ),
                                            ),
                                          ],
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.white),
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height: 120,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          blurRadius: 1,
                                                          blurStyle:
                                                              BlurStyle.normal)
                                                    ]),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    child: Image.network(
                                                      homeprovider[index]
                                                          .image!,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          const Center(
                                                              child: Text(
                                                                  'error')),
                                                    )),
                                              ),
                                              Positioned(
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                        child: IconButton(
                                                          onPressed: () {
                                                            ref
                                                                .read(homeScreenProvider
                                                                    .notifier)
                                                                .deleteProducts(
                                                                    homeprovider[
                                                                        index]);
                                                          },
                                                          icon: const Icon(
                                                            Icons.cancel,
                                                            color: Colors.red,
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 8, 0, 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        homeprovider[index]
                                                            .category
                                                            .toString(),
                                                        style: const TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color: Color(
                                                                0xff18191F)),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 2, 0, 0),
                                                        child: Text(
                                                          homeprovider[index]
                                                              .title
                                                              .toString(),
                                                          style: const TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              color: Color(
                                                                  0xff828282)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 4, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Rs.${homeprovider[index].soldprice}',
                                                        style: const TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color: Color(
                                                                0xff828282),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                      size: 16,
                                                    ),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 8.0),
                                                        child: SizedBox(
                                                            width: 30,
                                                            child: Text(
                                                              homeprovider[
                                                                      index]
                                                                  .rating
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            )))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }, childCount: homeprovider.length),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
