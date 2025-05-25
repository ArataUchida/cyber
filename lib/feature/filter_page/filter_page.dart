import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber/feature/filter_page/slider_widget.dart';
import 'package:cyber/feature/filter_page/bland_widget.dart';
import 'package:cyber/feature/filter_page/memory_widget.dart';

class FilterPage extends ConsumerWidget{
  const FilterPage ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'assets/images/Logo.png',
            width: 100,
            height: 40,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: [
          Row(
            children: [
              const BackButton(),
              const Text('Filter',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            ],
          ),
          const ExpansionTile(
            title: Text('Price',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            children: [
              PriceSlider(),
            ],
          ),
          Divider(color: Colors.grey,thickness: 1,),
          ExpansionTile(
            title: Text('Bland',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            children: [
              BrandFilterWidget(),
            ],
          ),
          Divider(color: Colors.grey,thickness: 1,),
          ExpansionTile(
            title: Text('Built-in memory',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            children: [
              MemoryFilterWidget(),
            ]
          ),
          Divider(color: Colors.grey,thickness: 1,),
          const ExpansionTile(
            title: Text('Protection class',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            children: [],
          ),
          Divider(color: Colors.grey,thickness: 1,),
          const ExpansionTile(
            title: Text('Screen diagonal',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            children: [],
          ),
          Divider(color: Colors.grey,thickness: 1,),
          const ExpansionTile(
            title: Text('Screen type',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            children: [],
          ),
          Divider(color: Colors.grey,thickness: 1,),
          const ExpansionTile(
            title: Text('Battery capacity',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            children: [],
          ),
          Divider(color: Colors.grey,thickness: 1,),
        ],
      ),
    );
  }
}

