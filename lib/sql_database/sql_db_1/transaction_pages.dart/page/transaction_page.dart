import 'package:animated_drawer/sql_database/sql_db_1/model/transaction.dart';
import 'package:flutter/material.dart';
import '../../db/transactions_database.dart';
import '../transaction_card.dart';
import 'edit_transaction_page.dart';
import 'transaction_details_page.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  late List<TransactionX> transactions;
  bool isLoading = false;
  Map _ico = {"ak": Icon(Icons.settings)};

  @override
  void initState() {
    super.initState();

    refreshTransactions();
  }

  @override
  void dispose() {
    TransactionXsDatabase.instance.close();
    super.dispose();
  }

  Future refreshTransactions() async {
    setState(() => isLoading = true);
    transactions = await TransactionXsDatabase.instance.readAllTransactionXs();
    List tr = transactions.reversed.toList();
    for (int i = 0; i < tr.length; i++) {
      try {
        print(tr[i].toString());
      } catch (e) {
        print('Exception : ' + e.toString());
      }
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          transactions.length.toString(),
          style: TextStyle(fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              refreshTransactions();
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
            // async {
            //   await TransactionXsDatabase.instance.deleteTable();
            //   refreshTransactions();
            // },
          ),
          IconButton(
            icon: Icon(Icons.data_array),
            onPressed: () {},
            // onPressed: () async {
            //   await TransactionXsDatabase.instance.deleteDB();
            //   refreshTransactions();
            // },
          ),
          const SizedBox(width: 12),
          const Icon(Icons.search),
          const SizedBox(width: 12)
        ],
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : transactions.isEmpty
                ? const Text(
                    "No Transactions",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )
                : buildTransactions(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.blue,
      //   child: const Icon(Icons.add),
      //   onPressed: () async {
      //     await Navigator.of(context).push(
      //       MaterialPageRoute(builder: (context) => AddEditTransactionXPage()),
      //     );

      //     refreshTransactions();
      //     setState(() {});
      //   },
      // ),
    );
  }

  // StaggeredGridView
  Widget buildTransactions() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];

        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  TransactionDetailPage(transactionId: transaction.id!),
            ));

            refreshTransactions();
          },
          child: TransactionCardWidget(transaction: transaction, index: index),
        );
      },
    );
  }
}
