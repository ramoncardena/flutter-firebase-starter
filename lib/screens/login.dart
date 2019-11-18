import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/services.dart';

enum FormType { login, register }

class LoginScreen extends StatefulWidget {
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  AuthService _auth = AuthService();
  FormType _formType = FormType.login;
  String _email, _password;

  // Validation function for the form fields
  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  // Function to change the form type login <-> register
  void switchFormState(String state) {
    // formKey.currentState.reset();

    if (state == 'register') {
      setState(() {
        _formType = FormType.register;
      });
    } else {
      setState(() {
        _formType = FormType.login;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Divider(
                height: 50.0,
              ),
              FlutterLogo(
                size: 100,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: buildTitle() + buildInputs() + buildButtons(),
                ),
              ),
              FlatButton(
                child: Text('Privacy Policy'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildTitle() {
    if (_formType == FormType.login) {
      return [
        Text(
          'Firebase Starter',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 38,
              decoration: TextDecoration.none),
        ),
        Text(
          'ENTER YOUR CREDENTIALS',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        Divider(height: 20, color: Colors.transparent),
      ];
    } else {
      return [
        Text(
          'Firebase Starter',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 38,
              decoration: TextDecoration.none),
        ),
        Text(
          'REGISTER YOUR ACCOUNT',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        Divider(height: 20, color: Colors.transparent),
      ];
    }
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        decoration: const InputDecoration(
          hintText: 'Your email to sign in...',
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),
        onSaved: (value) => _email = value,
      ),
      Divider(height: 20, color: Colors.transparent),
      TextFormField(
        decoration: const InputDecoration(
          hintText: 'Your password...',
          labelText: 'Password',
          border: OutlineInputBorder(),
        ),
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
      Divider(height: 20, color: Colors.transparent),
    ];
  }

  List<Widget> buildButtons() {
    if (_formType == FormType.login) {
      return [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10),
          child: FlatButton(
            padding: EdgeInsets.all(25),
            color: Colors.black45,
            onPressed: () async {
              if (validate()) {
                var user =
                    await _auth.signInWithEmailAndPassword(_email, _password);
                if (user != null) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              }
            },
            child: Text('SIGN IN', textAlign: TextAlign.center),
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10),
          child: FlatButton.icon(
            padding: EdgeInsets.all(25),
            icon: Icon(FontAwesomeIcons.google, color: Colors.white),
            color: Colors.black45,
            onPressed: () async {
              var user = await _auth.googleSignIn();
              if (user != null) {
                Navigator.pushReplacementNamed(context, '/home');
              }
            },
            label: Expanded(
              child: Text('GOOGLE SIGN-IN', textAlign: TextAlign.center),
            ),
          ),
        ),
        FlatButton(
          child: Text(
            'Register a New Account',
          ),
          onPressed: () {
            switchFormState('register');
          },
        ),
        // LoginButton(text: 'Continue as Guest', loginMethod: auth.anonLogin)
      ];
    } else {
      return [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10),
          child: FlatButton(
            padding: EdgeInsets.all(25),
            color: Colors.black45,
            onPressed: () async {
              if (validate()) {
                var user = await _auth.createUserWithEmailAndPassword(
                    _email, _password);
                if (user != null) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              }
            },
            child: Text('SIGN UP', textAlign: TextAlign.center),
          ),
        ),
        FlatButton(
          child: Text(
            'Return to Sign In',
          ),
          onPressed: () {
            switchFormState('login');
          },
        )
      ];
    }
  }
}
