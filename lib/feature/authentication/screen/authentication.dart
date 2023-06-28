// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:peacemaker/HomePage.dart';
import 'package:peacemaker/feature/authentication/cubit/authetication_cubit.dart';
import 'package:peacemaker/feature/authentication/cubit/authetication_state.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

bool _isLogin = true;

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();
  AutheticationCubit? authenticationCubit;

  @override
  void initState() {
    authenticationCubit = BlocProvider.of<AutheticationCubit>(context);

    super.initState();
  }

  void pageRoute() async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const HomePage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20), //
          child: Center(
            child: BlocConsumer<AutheticationCubit, AutheticationState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is AutheticationRegisterLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is AutheticationRegisterError) {
                  Fluttertoast.showToast(msg: state.msg);
                }

                if (state is AuthenticationLoginError) {
                  Fluttertoast.showToast(msg: state.msg);
                }
                if (state is AutheticationRegisterSuccess) {
                  Fluttertoast.showToast(
                      msg:
                          '${state.credential.user?.email ?? 'customemail@gmail.com'} Registered Successfully ');
                  WidgetsFlutterBinding.ensureInitialized();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
                } else if (state is AuthenticationLoginSuccess) {
                  Fluttertoast.showToast(msg: 'Login Successful.');
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const HomePage())));
                  });
                }
                return Column(
                  children: [
                    SizedBox(
                      child: TextField(
                        controller: _email,
                        decoration: const InputDecoration(
                            label: Text('Email'),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (!_isLogin)
                      SizedBox(
                        child: TextField(
                          controller: _username,
                          decoration: const InputDecoration(
                              label: Text('Username'),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                        ),
                      ),
                    if (!_isLogin)
                      const SizedBox(
                        height: 20,
                      ),
                    SizedBox(
                      child: TextField(
                        controller: _password,
                        decoration: const InputDecoration(
                            label: Text('Password'),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_isLogin) {
                            authenticationCubit?.loginUser(
                              _email.text,
                              _password.text,
                            );
                          } else if (!_isLogin) {
                            BlocProvider.of<AutheticationCubit>(context)
                                .registerUser(_email.text, _password.text,
                                    _username.text);
                          }
                        },
                        style: const ButtonStyle(
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30))),
                        child: Text(_isLogin ? 'Login' : 'Register'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: const Text('Don\'t have a account?Signup!')),
                    const Divider(
                      height: 50,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.phone_android_sharp,
                                  color: Colors.blue,
                                  size: 35,
                                ))),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.email,
                              color: Colors.blue,
                              size: 35,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
