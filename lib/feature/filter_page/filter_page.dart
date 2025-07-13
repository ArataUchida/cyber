import 'package:cyber/feature/filter_page/bland_widget.dart';
import 'package:cyber/feature/filter_page/memory_widget.dart';
import 'package:cyber/feature/filter_page/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterPage extends ConsumerWidget{
  const FilterPage ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              BackButton(),
              Text('Filter',style: TextStyle(
                fontSize: 25, 
                fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      //body: Container(
      body: ColoredBox(
        color: Colors.white,
        child: ListView(
          children: const [
            ExpansionTile(
              initiallyExpanded: true,
              title: Text('Price（レンジスライダー）',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              children: [
                PriceSlider(),
              ],
            ),
            ExpansionTile(
              initiallyExpanded: true,
              title: Text('Keyword（テキスト）',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              children: [
                BrandFilterWidget(),
              ],
            ),
            ExpansionTile(
              initiallyExpanded: true,
              title: Text('Storage\n（チェックリスト）',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              children: [
                MemoryFilterWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
