import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';

import '../../../budget_tracker/pages/input_budget/category_select_search.dart';

class TransactionXFormWidget extends StatefulWidget {
  final bool? isImportant;
  final String? amount;
  final String? account;
  final String? description;
  final String? category;
  final String? transfertto;
  final String? type;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<String> onChangedAmount;
  final ValueChanged<String> onChangedAccount;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedCategory;
  final ValueChanged<String> onChangedTransfertTo;
  final ValueChanged<String> onChangedType;

  const TransactionXFormWidget({
    Key? key,
    this.isImportant = false,
    this.amount = '',
    this.account = '',
    this.description = '',
    this.category = '',
    this.transfertto = '',
    this.type = '',
    required this.onChangedImportant,
    required this.onChangedAmount,
    required this.onChangedAccount,
    required this.onChangedDescription,
    required this.onChangedCategory,
    required this.onChangedTransfertTo,
    required this.onChangedType,
  }) : super(key: key);

  @override
  State<TransactionXFormWidget> createState() => _TransactionXFormWidgetState();
}

class _TransactionXFormWidgetState extends State<TransactionXFormWidget> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  int _selectedType = 0;
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'Select a Category';
  String _selectedAccount = 'Cash';
  String _description = 'Add a description';

  final List _accountList = [
    {"title": "Cash", "icon": const Icon(FontAwesomeIcons.wallet)},
    {"title": "bank", "icon": const Icon(FontAwesomeIcons.person)},
    {"title": "Cash", "icon": const Icon(FontAwesomeIcons.wallet)},
  ];
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row(
          //   children: [
          //     Switch(
          //       value: widget.isImportant ?? false,
          //       onChanged: widget.onChangedImportant,
          //     ),
          //     Expanded(
          //       child: Slider(
          //         value: 5,
          //         min: 0,
          //         max: 5,
          //         divisions: 5,
          //         onChanged: (amount) =>
          //             widget.onChangedAmount(amount.toString()),
          //       ),
          //     )
          //   ],
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(16),
          //   child: Column(
          //     children: [
          //       buildTitle(),
          //       const SizedBox(height: 8),
          //       buildDescription(),
          //       const SizedBox(height: 16),
          //     ],
          //   ),
          // ),
          buildCalculator(_size),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(10)),
          border: Border.all(
            color: Colors.red,
          )),
      child: TextFormField(
          maxLines: 1,
          initialValue: widget.account,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Account',
            hintStyle: TextStyle(color: Colors.white70),
          ),
          validator: (title) => title != null && title.isEmpty
              ? 'The title cannot be empty'
              : null,
          onChanged: widget.onChangedAccount),
    );
  }

  Widget buildDescription() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(10)),
          border: Border.all(
            color: Colors.red,
          )),
      child: TextFormField(
        maxLines: 5,
        initialValue: widget.description,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
          hintStyle: TextStyle(color: Color.fromRGBO(77, 76, 76, 0.6)),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: widget.onChangedDescription,
      ),
    );
  }

  Widget buildCalculator(Size size) {
    return SizedBox(
      height: size.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: List.generate(3, (index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedType = index;
                    if (_selectedType == 0) {
                      widget.onChangedType("Income");
                    } else if (_selectedType == 1) {
                      widget.onChangedType("Expense");
                    } else if (_selectedType == 2) {
                      widget.onChangedType("Transfert");
                    }
                  });
                },
                child: Container(
                  width: size.width / 3,
                  height: 45.0,
                  decoration: BoxDecoration(
                      color: _selectedType == index
                          ? const Color(0xff039be6)
                          : const Color(0xff04aaff)),
                  child: Center(
                    child: Text(
                      index == 0
                          ? "Income"
                          : index == 1
                              ? "Expense"
                              : "Transfert",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            }),
          ),
          Container(
            color: const Color(0xff04aaff),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize)),
          ),
          Container(
            color: const Color(0xff04aaff),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(double.parse(result).toStringAsFixed(2),
                style:
                    TextStyle(fontSize: resultFontSize, color: Colors.white)),
          ),
          Container(
            height: size.height * 0.1,
            color: const Color(0xff04aaff),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Date",
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                    TextButton(
                      onPressed: () {
                        _getDateFromUser(context);
                      },
                      child: Text(
                        DateFormat.yMd().format(_selectedDate),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const VerticalDivider(
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.white,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                    TextButton(
                      onPressed: () async {
                        _selectedCategory =
                            await Get.to(const CategorySelectSearch());
                        setState(() {});
                        widget.onChangedCategory(_selectedCategory);
                      },
                      child: Text(
                        _selectedCategory,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const VerticalDivider(
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.white,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Account",
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.defaultDialog(
                          title: "Select an Account : ",
                          content: Column(
                            children: List.generate(
                                _accountList.length,
                                (index) => ListTile(
                                      leading: _accountList[index]["icon"],
                                      title: Text(_accountList[index]["title"]),
                                      onTap: () {
                                        setState(() {
                                          _selectedAccount =
                                              _accountList[index]["title"];
                                          widget.onChangedAccount(
                                              _accountList[index]["title"]);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    )),
                          ),
                          actions: [
                            const Text("first choice"),
                            const Text("second choice"),
                          ],
                        );
                      },
                      child: Text(
                        _selectedAccount,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            color: const Color(0xff04aaff).withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  _description,
                  style: const TextStyle(
                      color: Color(0xff04aaff),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Colors.white38),
                      buildButton("x", 1, Colors.white38),
                      buildButton("/", 1, Colors.white38),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.white38),
                      buildButton("8", 1, Colors.white38),
                      buildButton("9", 1, Colors.white38),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.white38),
                      buildButton("5", 1, Colors.white38),
                      buildButton("6", 1, Colors.white38),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.white38),
                      buildButton("2", 1, Colors.white38),
                      buildButton("3", 1, Colors.white38),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.white38),
                      buildButton("0", 1, Colors.white38),
                      buildButton("00", 1, Colors.white38),
                    ])
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("*", 1, Colors.grey.withOpacity(0.5)),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.grey.withOpacity(0.5)),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.grey.withOpacity(0.5)),
                    ]),
                    TableRow(children: [
                      buildButton("/", 1, Colors.grey.withOpacity(0.5)),
                    ]),
                    TableRow(children: [
                      buildButton("=", 1, Colors.grey.withOpacity(0.5)),
                    ])
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(0.0),
        //     side: const BorderSide(
        //       color: Colors.grey,
        //       width: 1,
        //       style: BorderStyle.solid,
        //     )),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        double equationFontSize = 38.0;
        double resultFontSize = 48.0;
      } else if (buttonText == "x") {
        double equationFontSize = 48.0;
        double resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        double equationFontSize = 38.0;
        double resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('/', '/');

        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          widget.onChangedAmount(result);
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        }
        equation = equation + buttonText;
      }
    });
  }

  _getDateFromUser(BuildContext context) async {
    DateTime? _pickerDate = await showDatePicker(
        context: (context),
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate as DateTime;
        _showDialog();
      });
    } else {
      _showDialog();
    }
  }

  _showDialog() {
    Get.defaultDialog(
      onConfirm: () {},
      onCancel: () {},
      title: "Date Picker state",
      content: const Text("You should pick a date/time !! "),
    );
  }
}
