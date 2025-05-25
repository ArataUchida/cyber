import 'package:flutter/material.dart';
import 'package:cyber/feature/filter_page/filter_page.dart';

class ProductSearchWidget extends StatelessWidget{
  const ProductSearchWidget ({super.key});

  @override
  Widget build(BuildContext context){
    return Padding(padding: EdgeInsets.only(top: 40),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Filters ボタン
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => const FilterPage())
              );
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 16),
          ),
          child: Row(
            children: [
              Text('Filters'),
              SizedBox(width: 15),
              Icon(Icons.tune),
            ],
          ),
        ),

        // By rating ボタン
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 16),
          ),
          child: Row(
            children: [
              Text('By rating',),
              SizedBox(width: 15),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ],
    ),
    
    );
  }
}