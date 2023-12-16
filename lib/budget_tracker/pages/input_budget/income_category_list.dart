import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'income_category.dart';

final List<IncomeCategory> incomeCategoryList = [
  IncomeCategory(
      category: 'Allowance', incomeIcon: Icon(FontAwesomeIcons.landmark)),
  IncomeCategory(category: 'Award', incomeIcon: Icon(FontAwesomeIcons.award)),
  IncomeCategory(
      category: 'Bonus',
      incomeIcon: const Icon(FontAwesomeIcons.handHoldingUsd)),
  IncomeCategory(
      category: 'Gaz', incomeIcon: const Icon(FontAwesomeIcons.chartLine)),
  IncomeCategory(
      category: 'Dividend', incomeIcon: const Icon(FontAwesomeIcons.chartLine)),
  IncomeCategory(
      category: 'Investement',
      incomeIcon: const Icon(FontAwesomeIcons.commentsDollar)),
  IncomeCategory(
      category: 'Lottery', incomeIcon: const Icon(FontAwesomeIcons.diceTwo)),
  IncomeCategory(
      category: 'Salary', incomeIcon: Icon(FontAwesomeIcons.fileInvoiceDollar)),
  IncomeCategory(
      category: 'Tips',
      incomeIcon: const Icon(FontAwesomeIcons.solidHandPointDown)),
  IncomeCategory(category: 'Others', incomeIcon: Icon(FontAwesomeIcons.coins)),
];
