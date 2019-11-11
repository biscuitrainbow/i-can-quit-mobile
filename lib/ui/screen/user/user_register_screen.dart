import 'package:flutter/material.dart' hide TextField;
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_state.dart';
import 'package:i_can_quit/bloc/register/register_bloc.dart';
import 'package:i_can_quit/bloc/register/register_event.dart';
import 'package:i_can_quit/bloc/register/register_state.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:i_can_quit/data/model/user.dart';
import 'package:i_can_quit/ui/widget/button/ripple_button.dart';
import 'package:i_can_quit/ui/widget/form/text_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String route = '/register';

  final String email;
  final String name;

  const RegisterScreen({
    Key key,
    this.email,
    this.name,
  }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  FocusScopeNode _focusScopeNode = FocusScopeNode();

  final _formKey = GlobalKey<FormState>();

  void _showMainScreen() {
    // Navigator.of(context).pushReplacementNamed(MainScreen.route);
  }

  void _register(RegistrationBloc bloc) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    final user = User.register(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    bloc.add(Register(user: user));
  }

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: this.widget.name);
    _emailController = TextEditingController(text: this.widget.email);
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    final RegistrationBloc registrationBloc = BlocProvider.of<RegistrationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สร้างบัญชีผู้ใช้',
          style: TextStyle(color: ColorPalette.primary),
        ),
        iconTheme: IconThemeData(color: ColorPalette.primary),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<RegistrationBloc, RegisterState>(
            bloc: registrationBloc,
            listener: (context, state) {
              if (state is RegisterSuccess) {
                Navigator.of(context).pop();
              }
              
              if (state is RegisterError) {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text('สร้างบัญชีผู้ใช้ไม่สำเร็จ')));
              }
            },
          )
        ],
        child: BlocBuilder<RegistrationBloc, RegisterState>(
          bloc: registrationBloc,
          builder: (context, state) {
            if (state is RegisterLoading) {
              return Center(child: prefix0.CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: FocusScope(
                node: _focusScopeNode,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String value) => _focusScopeNode.nextFocus(),
                        hintText: 'ชื่อ - สกุล',
                        validator: (String value) {
                          if (value.isEmpty) return "กรุณากรอกชื่อ";

                          return null;
                        },
                      ),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String value) => _focusScopeNode.nextFocus(),
                        hintText: 'อีเมลล์',
                        validator: (String value) {
                          if (value.isEmpty) return 'กรุณากรอกอีเมลล์';

                          return null;
                        },
                      ),
                      TextField(
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        onFieldSubmitted: (String value) => _register(registrationBloc),
                        hintText: 'รหัสผ่าน',
                        validator: (String value) {
                          if (value.isEmpty) return 'กรุณากรอกรหัสผ่าน';

                          return null;
                        },
                      ),
                      SizedBox(height: 24.0),
                      RippleButton(
                        text: "สร้างบัญชีผู้ใช้",
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        decoration: Styles.primaryButtonDecoration,
                        onPress: () => _register(registrationBloc),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
