import 'package:coffeeproject/core/Model/productmodel.dart';

import 'package:coffeeproject/core/Riverpod/homescreen_provider.dart';
import 'package:coffeeproject/core/Riverpod/imagepicker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:uuid/uuid.dart';

import '../../core/Riverpod/selectcategory_provider.dart';
import '../../widgets/custom_text.dart';

// ignore: must_be_immutable
class AddNewProductScreen extends ConsumerStatefulWidget {
  AddNewProductScreen({super.key, this.product});
  Product? product;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddNewProductScreenState();
}

class _AddNewProductScreenState extends ConsumerState<AddNewProductScreen> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  String? downloadUrl;
  //  final now_date = DateFormat('d - M - yyyy ').format(DateTime.now());
  //String selectedCategory = "Arabica";
  @override
  Widget build(BuildContext context) {
    final selectimage = ref.watch(imageProvider);
    final selectcategory=ref.watch(selectedCategoryProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Center(
              child: customText(
                  Colors.black, 'AddNewProduct', FontWeight.w600, 16)),
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 23, right: 16, top: 24),
            
                child: DropdownButton<String>(
               
                  value: selectcategory, // Currently selected category
                  onChanged: (newValue) {
                    setState(() {
                      ref.read(selectedCategoryProvider.notifier).setSelectedCategory(newValue!);
                    });
                  },
                  items: <String>[
                    'Arabica',
                    'Robusta',
                    'Excelsa',
                    'Liberica'
                  ]
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(color: Colors.black)),
                        ),
                      )
                      .toList(),
                
                  ),
                ),
             
              Container(
                  margin: const EdgeInsets.only(left: 23, right: 16, top: 24),
                  child: TextField(
                    controller: titleController,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(color: Colors.white),
                    // maxLength: 400,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                      hintText: 'Enter title',
                      hintStyle:
                          const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )),
              Container(
                  margin: const EdgeInsets.only(left: 23, right: 16, top: 24),
                  child: TextField(
                    keyboardType: TextInputType.name,

                    style: const TextStyle(color: Colors.white),
                    controller: descriptionController,
                    // maxLength: 400,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none),
                        hintText: 'Enter description',
                        hintStyle:
                            const TextStyle(color: Colors.white, fontSize: 12)),
                  )),
              Container(
                  margin: const EdgeInsets.only(left: 23, right: 16, top: 24),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: priceController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none),
                        hintText: 'Enter price',
                        hintStyle:
                            const TextStyle(color: Colors.white, fontSize: 12)),
                  )),
              Container(
                  margin: const EdgeInsets.only(left: 23, right: 16, top: 24),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: ratingController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none),
                        hintText: 'Enter rating',
                        hintStyle:
                            const TextStyle(color: Colors.white, fontSize: 12)),
                  )),
              const SizedBox(
                height: 24,
              ),
              Container(
                height: 50,
                width: 260,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(50)),
                child: TextButton(
                  onPressed: () async {
                    downloadUrl =
                        await ref.read(imageProvider.notifier).imagePicker();
                  },
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                  ),
                  child: const Text(
                    'Select Image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (selectimage != null)
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.memory(
                      selectimage,
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    )),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 260,
                decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(50)),
                child: TextButton(
                  onPressed: () {
                    var Randomid = Uuid().v1();
                    Product newproduct = Product(
                      category: selectcategory,
                      title: titleController.text,
                      price: priceController.text,
                      description: descriptionController.text,
                      rating: ratingController.text,
                      id: Randomid,
                      image: downloadUrl!,
                      date: DateTime.now(),
                    );
                    ref
                        .read(homescreenprovider.notifier)
                        .addProduct(newproduct);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                  ),
                  child: const Text(
                    'Add product',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
