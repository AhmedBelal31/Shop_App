import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Models/LoginModel.dart';
import 'package:shop_app/modules/shop_app_login/shop_login_screen.dart';
import 'package:shop_app/style/color.dart';
import 'package:shop_app/style/constant.dart';
import '../../component/component.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class shop_register extends StatelessWidget {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel.status!) {
              NavigateAndRep(context, LoginScreen());
            }
            showToast(msg: "${state.registerModel.message}");
          }
        },
        builder: (context, state) {
          var cubitobj = ShopLoginCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: defaultColor),
            ),
            body: ConditionalBuilder(
              condition: state is! ShopRegisterLoadingState,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("REGISTER",
                              style: TextStyle(fontSize: 40)),
                          const Text(
                            "Register Now To Browse Our Hot Offers",
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          defaultForm(
                            controller: usernameController,
                            type: TextInputType.name,
                            prefixIcon: Icons.person,
                            text: "User Name",
                            onchange: (value) {},
                            onsubmit: (value) {},
                            Validator: (value) {
                              if (value.isEmpty) {
                                return "User Name Must Not Be Empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultForm(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            prefixIcon: Icons.email,
                            text: "Email-Address",
                            onchange: (value) {},
                            onsubmit: (value) {},
                            Validator: (value) {
                              if (value.isEmpty) {
                                return "Email-Address Must Not Be Empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultForm(
                              isSecure: cubitobj.isPassword,
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              prefixIcon: Icons.lock,
                              suffixIcon: cubitobj.Suffix,
                              text: "Password",
                              onchange: (value) {},
                              onsubmit: (value) {},
                              Validator: (value) {
                                if (value.isEmpty) {
                                  return "Password Must Not Be Empty";
                                } else {
                                  return null;
                                }
                              },
                              onTap: () {
                                cubitobj.showpassword();
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultForm(
                            controller: phoneController,
                            type: TextInputType.phone,
                            prefixIcon: Icons.phone,
                            text: "Phone",
                            onchange: (value) {},
                            onsubmit: (value) {},
                            Validator: (value) {
                              if (value.isEmpty) {
                                return "Phone Must Not Be Empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DefaultButton(
                            onpress: () {
                              if (formKey.currentState!.validate()) {
                                // cubobj.insertIntoDataBase(
                                //     username:usernameController.text,
                                //     email: emailController.text,
                                //     password: passwordController.text,
                                //     phone: phoneController.text
                                // ).then((value) {
                                //   Fluttertoast.showToast(
                                //       msg: "REGISTER SUCCESSFULLY" ,
                                //       toastLength: Toast.LENGTH_LONG,
                                //       gravity: ToastGravity.BOTTOM,
                                //       timeInSecForIosWeb: 3,
                                //       backgroundColor:defaultColor,
                                //       textColor: Colors.white,
                                //       fontSize: 16.0
                                //   );
                                // });
                                // cubobj.getDatabase(database);
                                //
                                // NavigateTo(context,shopLogin());
                                cubitobj.registerUser(
                                    name: usernameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text);
                              }
                            },
                            text: "REGISTER",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
