import 'package:flutter/material.dart' hide TextField;
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_can_quit/bloc/authentication/authentication_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_event.dart';
import 'package:i_can_quit/bloc/authentication/authentication_state.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:i_can_quit/ui/screen/user/user_register_screen.dart';
import 'package:i_can_quit/ui/util/string_util.dart';
import 'package:i_can_quit/ui/widget/button/ripple_button.dart';
import 'package:i_can_quit/ui/widget/form/text_field.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController;
  TextEditingController _passwordController;
  FocusScopeNode _focusScopeNode = FocusScopeNode();

  FocusNode _emailNode;
  FocusNode _passwordNode;

  void _showRegister(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen()));
  }

  void _login(AuthenticationBloc bloc) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    bloc.dispatch(LoginWithEmailAndPassword(email: _emailController.text, password: _passwordController.text));

    // Completer<Null> completer = loadingCompleter(context, 'กำลังเข้าสู่ระบบ..', 'เข้าสู่ระบบสำเร็จ', 'เข้าสู่ระบบไม่สำเร็จ');

    // widget.viewModel.onLogin(
    //   _emailController.text,
    //   _passwordController.text,
    //   completer,
    // );
  }

  void _loginWithFacebook(AuthenticationBloc bloc) {
    bloc.dispatch(LoginWithFacebook());
  }

  void _loginWithGoogle(AuthenticationBloc bloc) {
    bloc.dispatch(LoginWithGoogle());
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
              fontSize: 28.0,
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
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: 'อีเมลล์',
            validator: (String value) {
              if (value.isEmpty) return 'กรุณากรอกอีเมลล์';
              if (!isEmail(value)) return 'รูปแบบอีเมลล์ไม่ถูกต้อง';

              return null;
            },
            onFieldSubmitted: (String value) => _focusScopeNode.nextFocus(),
            textInputAction: TextInputAction.next,
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            keyboardType: TextInputType.text,
            hintText: 'รหัสผ่าน',
            validator: (String value) => value.isEmpty ? 'กรุณากรอกรหัสผ่าน' : null,
            onFieldSubmitted: (String value) => _login(authenticationBloc),
            textInputAction: TextInputAction.done,
          ),
          SizedBox(height: 24.0),
          RippleButton(
            text: "เข้าสู่ระบบ",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            decoration: Styles.primaryButtonDecoration,
            onPress: () => _login(authenticationBloc),
          ),
          SizedBox(height: 24.0),
          RippleButton(
            text: "เข้าสู่ระบบด้วย Google",
            textColor: Colors.grey.shade600,
            icon: Icon(FontAwesomeIcons.google, color: Colors.red, size: 20.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            onPress: () => _loginWithGoogle(authenticationBloc),
          ),
          SizedBox(height: 24.0),
          RippleButton(
            text: "เข้าสู่ระบบด้วย Facebook",
            textColor: Colors.grey.shade600,
            icon: Icon(FontAwesomeIcons.facebookF, color: Colors.blue, size: 20.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            onPress: () => _loginWithFacebook(authenticationBloc),
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
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: authenticationBloc,
        listener: (context, state) {
          if (state is NewSocialUserHasRegistered) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen(user: state.user)));
          }

          if (state is LoginError) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('เข้าสู่ระบบไม่สำเร็จ')));
          }
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: authenticationBloc,
          builder: (context, state) {
            if (state is LoginLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _header,
                  FocusScope(
                    node: _focusScopeNode,
                    child: _form,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
