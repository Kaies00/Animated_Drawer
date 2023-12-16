import 'package:animated_drawer/screens/principales_screen/page_container.dart';
import 'package:animated_drawer/services/auth.dart';
import 'package:animated_drawer/sql_database/list_from_db_page.dart';
import 'package:animated_drawer/sql_database/sql_db_1/db/transactions_database.dart';
import 'package:animated_drawer/sql_database/sql_db_1/transaction_pages.dart/page/transaction_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'budget_tracker/pages/input_budget/calculator.dart';
import 'budget_tracker/pages/root_app.dart';
import 'firbase_auth/login_signup/wrapper.dart';
import 'firbase_auth/models/Userr.dart';
import 'sql_database/sql_db_1/pages/notes_page.dart';
import 'sql_database/sql_db_1/transaction_pages.dart/page/root_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Userr>.value(
      value: AuthServices().user,
      initialData: Userr("0000"),
      child: GetMaterialApp(
        home:
            RootTransactionPage() /*RootApp()*/ /*TransactionsPage()*/ /*Wrapper()*/,
      ),
    );
  }
}
