import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/LoginModel.dart';
import 'package:shop_app/Network/local/Chache_Helper.dart';
import 'package:shop_app/component/component.dart';
import 'package:shop_app/modules/shop_app_login/shop_login_screen.dart';
import 'package:shop_app/modules/shop_home/Cubit/HomeCubit.dart';
import 'package:shop_app/modules/shop_home/Cubit/HomeStates.dart';

import '../Home_Layout.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is ShopUpdateProfileSuccessState) {
          if (!state.Updateprofilemodel.status!) {
            CircularProgressIndicator();
          }
          showToast(msg: "${state.Updateprofilemodel.message!}");
        }
      },
      builder: (context, state) {
        var model = HomeCubit.get(context).profilemodel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return Scaffold(
            body: ConditionalBuilder(
          condition: HomeCubit.get(context).profilemodel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (state is ShopProfileLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultForm(
                        controller: nameController,
                        type: TextInputType.name,
                        text: "Name",
                        prefixIcon: Icons.person,
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
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        text: "Email-Controller ",
                        prefixIcon: Icons.email,
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
                        controller: phoneController,
                        type: TextInputType.phone,
                        text: "Phone",
                        prefixIcon: Icons.phone,
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
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[400],
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              HomeCubit.get(context).updateProfileData(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text);
                            }
                          },
                          child: const Text(
                            "UPDATE",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[400],
                        ),
                        child: TextButton(
                          onPressed: () {
                            Cache_Helper.removeKeyFromSharedPref(key: 'token')
                                .then((value) {
                              NavigateAndRep(context, LoginScreen());
                            });
                          },
                          child: const Text(
                            "LOGOUT",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        ));
      },
    );
  }
}
//LOGOUT Button
