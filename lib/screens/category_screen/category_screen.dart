import 'package:coffeeproject/core/riverpod/categoryscreen_provider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/category/category.dart';

// ignore: must_be_immutable
class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    List<Category> categoryprovider = ref.watch(categoryScreenProvider);
    return Scaffold(
      backgroundColor: const Color(0xffF4F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xffF4F6F8),
        toolbarHeight: 60,
        elevation: 0,
        title: const Center(
            child: Text(
          'Categorys',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              color: Colors.black),
        )),
      ),
      body: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: SizedBox(
              width: 500,
              child: ListView.builder(
                  itemCount: categoryprovider.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      elevation: 4,
                      child: ExpansionTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        childrenPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        expandedCrossAxisAlignment: CrossAxisAlignment.end,
                        maintainState: true,
                        title: Text(categoryprovider[index].title.toString()),
                        // contents
                        children: [
                          ExpandableText(
                            categoryprovider[index].description.toString(),
                            expandText: 'Read more',
                            collapseText: 'Read less',
                            maxLines: 3,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                overflow: TextOverflow.ellipsis,
                                color: Color(0xff828282)),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              ref
                                  .read(categoryScreenProvider.notifier)
                                  .deletCategory(categoryprovider[index]);
                            },
                            icon: const Icon(Icons.delete),
                            label: const Text(
                              'Remove',
                            ),
                            style:
                                TextButton.styleFrom(foregroundColor: Colors.red),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          )),
    );
  }
}
