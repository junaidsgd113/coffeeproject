import 'package:coffeeproject/core/models/category/category.dart';
import 'package:coffeeproject/core/riverpod/categoryscreen_provider.dart';
import 'package:coffeeproject/core/riverpod/homescreen_provider.dart';
import 'package:coffeeproject/core/riverpod/imagepicker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../core/models/product/product.dart';
import '../../core/service/firestorage_service.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_textfield.dart';

final selectCategoryProvider = StateProvider<Category?>((ref) => null);

// ignore: must_be_immutable
class AddNewProductScreen extends ConsumerStatefulWidget {
  AddNewProductScreen({
    this.product,
    super.key,
  });
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
  TextEditingController autualpriceController = TextEditingController();
  TextEditingController totalquantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    categoryController.text = widget.product?.category ?? '';
    titleController.text = widget.product?.title ?? '';
    descriptionController.text = widget.product?.description ?? '';
    priceController.text = widget.product?.soldprice.toString() ?? '';
    ratingController.text = widget.product?.rating.toString() ?? '';
    totalquantityController.text =
        widget.product?.totalquantity.toString() ?? '';
    autualpriceController.text = widget.product?.actualprice.toString() ?? '';
    var selectcategory = ref.watch(selectCategoryProvider);
    final selectimage = ref.watch(imageProvider);
    List<Category> selectcetegoryfromlist = ref.watch(categoryScreenProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Center(
              child:
                  customText(Colors.black, 'Add Product', FontWeight.w600, 16)),
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.black,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Container(
              width: 400,
              height: 550,
              decoration: BoxDecoration(
                  color: const Color(0xFFE0F2F1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(blurRadius: 1, blurStyle: BlurStyle.normal)
                  ]),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 50,
                        child: CustomWidgets.textField(
                          labeltext: 'Enter Title',
                          textController: titleController,
                          keyboard: TextInputType.text,
                          hintstyle: const TextStyle(
                              color: Colors.white, fontSize: 12),
                          textStyle: const TextStyle(color: Colors.blue),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 50,
                        child: CustomWidgets.textField(
                          labeltext: 'Enter Description',
                          textController: descriptionController,
                          keyboard: TextInputType.text,
                          hintstyle: const TextStyle(
                              color: Colors.white, fontSize: 12),
                          textStyle: const TextStyle(color: Colors.blue),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 50,
                        child: CustomWidgets.textField(
                          labeltext: 'Enter Sale Price',
                          textController: priceController,
                          keyboard: TextInputType.number,
                          hintstyle: const TextStyle(
                              color: Colors.white, fontSize: 12),
                          textStyle: const TextStyle(color: Colors.blue),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 50,
                        child: CustomWidgets.textField(
                          labeltext: 'Enter Actual Price',
                          textController: autualpriceController,
                          keyboard: TextInputType.number,
                          hintstyle: const TextStyle(
                              color: Colors.white, fontSize: 12),
                          textStyle: const TextStyle(color: Colors.blue),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 50,
                        child: CustomWidgets.textField(
                          labeltext: 'Enter Total Quantity',
                          textController: totalquantityController,
                          keyboard: TextInputType.number,
                          hintstyle: const TextStyle(
                              color: Colors.white, fontSize: 12),
                          textStyle: const TextStyle(color: Colors.blue),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 50,
                        child: CustomWidgets.textField(
                          labeltext: 'Enter Rating',
                          textController: ratingController,
                          keyboard: TextInputType.number,
                          hintstyle: const TextStyle(
                              color: Colors.white, fontSize: 12),
                          textStyle: const TextStyle(color: Colors.blue),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: DropdownButtonFormField<Category>(
                          menuMaxHeight: 200,
                          
                          dropdownColor: Colors.white,
                          // itemHeight: 20,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.blue)),
                              labelText: 'Catogory'),
                          value: selectcategory,
                          onChanged: (Category? newValue) {
                            selectcategory = newValue;
                            ref.read(selectCategoryProvider.notifier).state =
                                newValue;
                          },
                          items: selectcetegoryfromlist
                              .map<DropdownMenuItem<Category>>(
                                (Category category) =>
                                    DropdownMenuItem<Category>(
                                  value: category,
                                  child: Text(category.title.toString(),
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12)),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 34,
                                width: 145,
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextButton(
                                  onPressed: () async {
                                    await ref
                                        .read(imageProvider.notifier)
                                        .imagePicker();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    alignment: Alignment.center,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Select Image',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 34,
                                width: 145,
                                decoration: BoxDecoration(
                                    color: Colors.brown,
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextButton(
                                  onPressed: () async {
                                    var randomid = const Uuid().v1();
                                    final firebase = FireStorageService();
                                    final imageUrl = await firebase.uploadImage(
                                        selectimage!, randomid);
                                    Product newproduct = Product(
                                      category:
                                          selectcategory?.title.toString(),
                                      title: titleController.text,
                                      soldprice:
                                          int.parse(priceController.text),
                                      description: descriptionController.text,
                                      rating:
                                          double.parse(ratingController.text),
                                      totalquantity: int.parse(
                                          totalquantityController.text),
                                      actualprice:
                                          int.parse(autualpriceController.text),
                                      timestamp: DateTime.now(),
                                      id: widget.product == null
                                          ? randomid
                                          : widget.product?.id ?? '',
                                      image: imageUrl,
                                    );
                                    (widget.product == null)
                                        ? ref
                                            .read(homeScreenProvider.notifier)
                                            .addProduct(newproduct)
                                        : ref
                                            .read(homeScreenProvider.notifier)
                                            .updatedProduct(newproduct);
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    alignment: Alignment.center,
                                  ),
                                  child: Text(
                                    (widget.product == null)
                                        ? 'Add product'
                                        : 'update product',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 100,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: (widget.product != null)
                                  ? Image.network(
                                      widget.product?.image ?? '',
                                      height: 70,
                                      width: 100,
                                      scale: 1,
                                      fit: BoxFit.cover,
                                    )
                                  : (selectimage != null)
                                      ? Image.memory(
                                          selectimage,
                                          height: 70,
                                          width: 100,
                                          scale: 1,
                                          fit: BoxFit.cover,
                                        )
                                      : const SizedBox(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
