import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage("assets/images/fleur.jpeg")),
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FormBuilderTextField(
                        name: 'email',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email()
                        ]),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )),

                            //filled: true,
                            fillColor: Colors.white,
                            labelStyle:
                                TextStyle(fontSize: 20, color: Colors.white),
                            label: Text("Email"),
                            hintText: "placeholder",
                            icon: Icon(Icons.email, color: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: FormBuilderTextField(
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.min(4),
                        ]),
                        name: 'password',
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            //filled: true,
                            fillColor: Colors.white,
                            labelStyle:
                                TextStyle(fontSize: 20, color: Colors.white),
                            label: Text("Password"),
                            hintText: "Mot de passe",
                            icon: Icon(Icons.lock, color: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GFButton(
                          shape: GFButtonShape.pills,
                          fullWidthButton: true,
                          textColor: Colors.white,
                          size: GFSize.LARGE,
                          color: GFColors.SUCCESS,
                          text: "LOGIN",
                          onPressed: () {
                            if (_formKey.currentState!.saveAndValidate()) {
                              print(_formKey.currentState!.value);
                            } else {
                              print("Your login or password is incorrect");
                            }
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        '---OR---',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GFButton(
                          shape: GFButtonShape.pills,
                          type: GFButtonType.outline,
                          fullWidthButton: true,
                          textColor: Colors.white,
                          size: GFSize.LARGE,
                          color: GFColors.SUCCESS,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Login With Google Account",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Image.asset("assets/images/h.png"),
                              ],
                            ),
                          ),
                          onPressed: () {}),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
