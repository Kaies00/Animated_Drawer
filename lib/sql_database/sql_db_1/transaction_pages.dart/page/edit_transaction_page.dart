import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../db/transactions_database.dart';
import '../../model/transaction.dart';
import '../transaction_form_wideget.dart';
import 'root_page.dart';
import 'transaction_page.dart';

class AddEditTransactionXPage extends StatefulWidget {
  final TransactionX? transaction;

  const AddEditTransactionXPage({
    Key? key,
    this.transaction,
  }) : super(key: key);
  @override
  _AddEditTransactionXPageState createState() =>
      _AddEditTransactionXPageState();
}

class _AddEditTransactionXPageState extends State<AddEditTransactionXPage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late String amount;
  late String account;
  late String description;
  late String category;
  late String transfertto;
  late String type;

  @override
  void initState() {
    super.initState();

    isImportant = widget.transaction?.isImportant ?? false;
    amount = widget.transaction?.amount ?? '';
    account = widget.transaction?.account ?? '';
    description = widget.transaction?.description ?? '';
    category = widget.transaction?.category ?? '';
    transfertto = widget.transaction?.transfertto ?? '';
    type = widget.transaction?.type ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: TransactionXFormWidget(
            isImportant: isImportant,
            amount: amount,
            account: account,
            description: description,
            onChangedImportant: (isImportant) =>
                setState(() => this.isImportant = isImportant),
            onChangedAmount: (amount) => setState(() => this.amount = amount),
            onChangedAccount: (account) =>
                setState(() => this.account = account),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
            onChangedCategory: (category) =>
                setState(() => this.category = category),
            onChangedTransfertTo: (transfertto) =>
                setState(() => this.transfertto = transfertto),
            onChangedType: (type) => setState(() => this.type = type),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = account.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateTransactionX,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateTransactionX() async {
    final isValid = _formKey.currentState!.validate();
    print("addOrUpdateTransactionX");
    print(isValid.toString());

    if (isValid) {
      final isUpdating = widget.transaction != null;

      if (isUpdating) {
        await updateTransactionX();
      } else {
        await addTransactionX();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateTransactionX() async {
    final transaction = widget.transaction!.copy(
      isImportant: isImportant,
      amount: amount,
      account: account,
      description: description,
    );

    await TransactionXsDatabase.instance.update(transaction);
  }

  Future addTransactionX() async {
    print("addTransactionX");
    final transaction = TransactionX(
      account: account,
      isImportant: true,
      amount: amount,
      description: description,
      createdTime: DateTime.now(),
      category: category,
      transfertto: '',
      type: type,
    );

    await TransactionXsDatabase.instance.create(transaction);
  }
}
