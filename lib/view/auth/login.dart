import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_mina/core/utils/dialog_utils.dart';
import 'package:pro_mina/core/widget/customized_field.dart';
import 'package:pro_mina/data/repo/auth_repo/auth_repo_impl.dart';
import 'package:pro_mina/data/repo/auth_repo/data_sources/auth_online_data_source.dart';
import 'package:pro_mina/domain/use_cases/login_usecase.dart';
import 'package:pro_mina/view/auth/view_modal.dart';
import 'package:pro_mina/view/home/home.dart';
import '../../core/utils/base_request_state.dart';
class LoginScreen extends StatelessWidget {
  static String routeName = "/login";
  LoginViewModel loginViewModel = LoginViewModel(LoginUseCase(AuthRepoImpl(AuthOnlineDataSourceImpl(), Connectivity())));

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
   var h = MediaQuery.of(context).size.height;

   return Scaffold(
      body: BlocListener(
        bloc: loginViewModel,
        listener: (context,state){
          if (state is LoginLoadingState) {
            showLoading(context);
          } else if (state is LoginErrorState) {
            hideLoading(context);
            showInvalidUserSnackbar(context,"Invalid Account");
          } else if (state is LoginSuccessState) {
            hideLoading(context);
            showInvalidUserSnackbar(context,"Successfully",color:Colors.green);

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return const HomeScreen();
            }));
          }

        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Stack(
                children: [
                  Image.asset("assets/images/Group 16.png"),
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical:70),
                   child: Column(
                     children: [
                       SizedBox(height: h*0.08,),
                     const  Center(
                         child:  Text(
                            "    My \nGellary ",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A4A4A)

                            ),
                          ),
                       ),

                         Container(
                           height: h * .45,
                           padding:const EdgeInsets.symmetric(horizontal: 30),
                           margin:const EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                           decoration: BoxDecoration(
                             color: Colors.white.withOpacity(0.6), // Adjust opacity as needed
                             borderRadius: BorderRadius.circular(10), // Add border radius if needed
                           ),
                           child: ClipRect(
                             child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Form(
                      key: loginViewModel.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         const Center(
                            child:  Text(
                              "Log in",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4A4A4A)

                              ),
                            ),
                          ),
                          SizedBox(
                            height: h *0.05,
                          ),
                          CustomizedField(
                            colorText:const Color(0xFF988F8C),
                            obscureText: false,
                            color: Colors.white,
                            hintText: "User Name ",
                            controller: loginViewModel.nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter UserName";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: h * 0.02,),
                          CustomizedField(
                            colorText: const Color(0xFF988F8C),
                            isPassword: true,
                            obscureText: true,
                            color: Colors.white,
                            hintText: "Password",
                            controller: loginViewModel.passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter password";
                              }
                              return null;
                            },
                          ),

                          InkWell(
                            onTap: (){
                              loginViewModel.login();
                            },
                            child: Container(
                              padding:const EdgeInsets.all(10),
                              margin:const EdgeInsets.symmetric(vertical: 20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFF7BB3FF),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child:const Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                             ),
                           ),
                         )
                     ],
                   ),
                 )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
