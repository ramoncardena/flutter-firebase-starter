import 'package:flutter/material.dart';
import '../services/services.dart';

class HomeScreen extends StatelessWidget {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Firebase Starter for Flutter'),
      ),
      body: Center(
        child: FlatButton(
            child: Text('logout'),
            color: Colors.red,
            onPressed: () async {
              await auth.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            }),
      ),
    );
  }
}
