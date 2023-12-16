import 'package:flutter/material.dart';

class IncomeCategory {
  late final String category;
  late final Widget incomeIcon;

  IncomeCategory({
    required this.category,
    required this.incomeIcon,
  });

  factory IncomeCategory.fromMap(Map<String, dynamic> map) => IncomeCategory(
        category: map['category'],
        incomeIcon: map['depenseIcon'],
      );
}
