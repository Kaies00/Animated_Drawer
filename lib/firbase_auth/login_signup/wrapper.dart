import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/principales_screen/page_container.dart';
import '../models/Userr.dart';
import 'authenticate/authentication.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userr>(context);
    if (user == null || user.uid == "0000") {
      return Authenticate();
    } else {
      return PageContainer();
    }
  }
}
