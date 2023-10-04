import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../core/models/category/category.dart';
import '../../core/riverpod/categoryscreen_provider.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_textfield.dart';

// ignore: must_be_immutable
class AddNewCategoryScreen extends ConsumerStatefulWidget {
  const AddNewCategoryScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends ConsumerState<AddNewCategoryScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Center(
              child: customText(
                  Colors.black, 'Add Category', FontWeight.w600, 16)),
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.black,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 80),
          child: Center(
            child: Container(
              // color: Color(0xFFE0F2F1),
              decoration: BoxDecoration(
                  color: const Color(0xFFE0F2F1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(blurRadius: 1, blurStyle: BlurStyle.normal)
                  ]),
              width: 400,
              height: 380,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Enter Title',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          Icon(
                            Icons.edit_calendar_sharp,
                            size: 20,
                          ),
                        ],
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
                        height: 20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Enter Description',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          Icon(
                            Icons.edit_calendar_sharp,
                            size: 20,
                          ),
                        ],
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
                        height: 30,
                      ),
                      Center(
                        child: Container(
                          height: 40,
                          width: 250,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: () {
                              var Randomid = const Uuid().v1();
                              if (titleController.text.isNotEmpty &&
                                  descriptionController.text.isNotEmpty) {
                                Category newcategory = Category(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  id: Randomid,
                                );
                                ref
                                    .read(categoryScreenProvider.notifier)
                                    .addCategory(newcategory);
                                Navigator.pop(context);
                              } else {
                                var snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text((titleController.text.isEmpty)
                                      ? "Please enter a title"
                                      : "Please enter a description"),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              alignment: Alignment.center,
                            ),
                            child: const Text(
                              'Add Category',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
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
