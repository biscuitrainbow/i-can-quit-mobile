import 'dart:async';

import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/data/model/user.dart';
import 'package:i_can_quit/ui/widget/button/ripple_button.dart';

class RegisterScreen extends StatefulWidget {
  static const String route = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  FocusNode _nameFocusNode;
  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;

  final _formKey = GlobalKey<FormState>();

  void _showMainScreen() {
    // Navigator.of(context).pushReplacementNamed(MainScreen.route);
  }

  void _register() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    final user = User.register(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    // final completer = loadingThenPushReplaceCompleter(context, MainScreen.route, 'กำลังสมัครสมาชิก..', 'สมัครสมาชิกสำเร็จ', 'สมัครสมาชิกล้มเหลว ');
    // widget.viewModel.onRegister(user, completer);
  }

  @override
  void initState() {
    super.initState();

//    _nameController = TextEditingController(text: 'natthapon');
//    _emailController = TextEditingController(text: 'premium@gmail.com');
//    _passwordController = TextEditingController(text: '123456');

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("สร้างบัญชีผู้ใช้")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'ชื่อ'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (String value) => FocusScope.of(context).requestFocus(_emailFocusNode),
                  validator: (String value) {
                    if (value.isEmpty) return "กรุณากรอกชื่อ";

                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'อีเมลล์'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (String value) => FocusScope.of(context).requestFocus(_passwordFocusNode),
                  validator: (String value) {
                    if (value.isEmpty) return 'กรุณากรอกอีเมลล์';
                    // if (!isEmail(value)) return 'รูปแบบอีเมลล์ไม่ถูกต้อง';

                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'รหัสผ่าน'),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (String value) => _register(),
                  validator: (String value) {
                    if (value.isEmpty) return 'กรุณากรอกรหัสผ่าน';

                    return null;
                  },
                ),
              ),
              SizedBox(height: 24.0),
              RippleButton(
                text: "สร้างบัญชีผู้ใช้",
                backgroundColor: ColorPalette.primary,
                highlightColor: ColorPalette.primarySplash,
                textColor: Colors.white,
                onPress: () => _register(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
