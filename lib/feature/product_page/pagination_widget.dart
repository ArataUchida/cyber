import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {

  const PaginationWidget({
    required this.currentPage, required this.totalPages, required this.onPageChanged, super.key,
  });
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  @override
  Widget build(BuildContext context) {
    final pageButtons = <Widget>[];

    pageButtons.add(
      IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
      ),
    );

    // 数字ボタン
    for (var i = 1; i <= totalPages; i++) {
      if (i <= 3 || i == totalPages || (i >= currentPage - 1 && i <= currentPage + 1)) {
        pageButtons.add(
          GestureDetector(
            onTap: () => onPageChanged(i),
            child: Container(
              width: 36,
              height: 36,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: i == currentPage ? Colors.black : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                '$i',
                style: TextStyle(
                  color: i == currentPage ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      } else if (i == 4 && currentPage > 5) {
        pageButtons.add(const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('...'),
        ),);
      } else if (i == totalPages - 1 && currentPage < totalPages - 4) {
        pageButtons.add(const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('...'),
        ),);
      }
    }

    pageButtons.add(
      IconButton(
        icon: const Icon(Icons.chevron_right),
        onPressed: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: pageButtons,
    );
  }
}