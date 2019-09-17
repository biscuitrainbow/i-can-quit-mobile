import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_event.dart';
import 'package:i_can_quit/bloc/authentication/authentication_state.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/ui/screen/user/user_register_screen.dart';
import 'package:i_can_quit/ui/util/string_util.dart';
import 'package:i_can_quit/ui/widget/button/ripple_button.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController;
  TextEditingController _passwordController;

  FocusNode _emailNode;
  FocusNode _passwordNode;

  void _showRegister(BuildContext context) {
    Navigator.of(context).pushNamed(RegisterScreen.route);
  }

  void _login(AuthenticationBloc bloc) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    bloc.dispatch(AuthenticationLogin(email: _emailController.text, password: _passwordController.text));

    // Completer<Null> completer = loadingCompleter(context, 'กำลังเข้าสู่ระบบ..', 'เข้าสู่ระบบสำเร็จ', 'เข้าสู่ระบบไม่สำเร็จ');

    // widget.viewModel.onLogin(
    //   _emailController.text,
    //   _passwordController.text,
    //   completer,
    // );
  }

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailNode = FocusNode();
    _passwordNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _emailNode.dispose();
    _passwordNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    final _header = Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16.0),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          // Icon(
          //   AssetIcon.salt,
          //   color: Theme.of(context).primaryColor,
          //   size: 120.0,
          // ),
          SizedBox(height: 16.0),
          Text(
            'iCanQuit',
            key: Key('__app_name__'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.0,
              color: ColorPalette.primary,
            ),
          ),
        ],
      ),
    );

    final _form = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            child: TextFormField(
              validator: (String value) {
                if (value.isEmpty) return 'กรุณากรอกอีเมลล์';
                if (!isEmail(value)) return 'รูปแบบอีเมลล์ไม่ถูกต้อง';

                return null;
              },
              controller: _emailController,
              focusNode: _emailNode,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'อีเมลล์'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (String value) => FocusScope.of(context).requestFocus(_passwordNode),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            child: TextFormField(
              validator: (String value) => value.isEmpty ? 'กรุณากรอกรหัสผ่าน' : null,
              controller: _passwordController,
              focusNode: _passwordNode,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'รหัสผ่าน'),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (String value) => _login(authenticationBloc),
            ),
          ),
          SizedBox(height: 24.0),
          RippleButton(
            text: "เข้าสู่ระบบ",
            backgroundColor: ColorPalette.primary,
            highlightColor: ColorPalette.primarySplash,
            textColor: Colors.white,
            onPress: () => _login(authenticationBloc),
          ),
          SizedBox(height: 24.0),
          RippleButton(
            text: "สร้างบัญชีผู้ใช้",
            backgroundColor: Colors.white,
            textColor: ColorPalette.primary,
            highlightColor: ColorPalette.primarySplash,
            onPress: () => _showRegister(context),
          ),
        ],
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            _header,
            _form,
          ],
        ),
      ),
    );
  }
}
