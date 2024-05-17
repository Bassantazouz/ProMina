import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_mina/view/home/view_modal_home.dart';
import '../../core/utils/base_request_state.dart';
import '../../core/utils/dialog_utils.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '';

  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeViewModel>(context).getPhotos();
    super.initState();
  }
 HomeViewModel homeViewModel =HomeViewModel();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            return      BlocProvider.of<HomeViewModel>(context).getPhotos();

          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                        height: h,
                        child: Image.asset("assets/images/Group 14.png",fit:BoxFit.fill ,)),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const  Text(
                                "Welcome\n Mina",
                                style: TextStyle(
                                    fontSize:32 ,
                                    color: Color(0xFF4A4A4A),
                                    fontWeight: FontWeight.w300
                                ),
                              ),
                              Image.asset("assets/images/Ellipse 1641.png")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)

                                ),
                                padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                child: Row(
                                  children: [
                                    Container(
                                      padding:const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color:const Color(0xffC83B3B),
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow:[
                                            BoxShadow(
                                              offset: const Offset(5,0 ),
                                              blurRadius: 3 ,
                                              color: const Color(0xffC83B3B).withOpacity(0.3),                                      )
                                          ]
                                      ),
                                      child:const Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,

                                      ),
                                    ),
                                    SizedBox(width: w * 0.02,),
                                    const Text(
                                      "log out",
                                      style: TextStyle(
                                          color: Color(0xFF4A4A4A),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300
                                      ),

                                    )
                                  ],
                                ),

                              ),
                              BlocListener<HomeViewModel,BaseRequestStates>(
                                listener: (context,state){
                                  if (state is ImageUploadLoading) {
                                    Navigator.pop(context);
                                    showLoading(context);
                                  }
                                  else if (state is ImageUploadSuccess) {
                                    hideLoading(context);
                                    showInvalidUserSnackbar(context,"Successfully",color:Colors.green);
                                    BlocProvider.of<HomeViewModel>(context).getPhotos();
                                  }else if (state is ImageUploadFailure) {
                                    hideLoading(context);
                                    showInvalidUserSnackbar(context,state.error,);
                                    BlocProvider.of<HomeViewModel>(context).getPhotos();
                                  }
                                },
                                child: InkWell(
                                  onTap: (){
                                    showDialog(
                                      context:context ,
                                      builder: (BuildContext context) {
                                        var h = MediaQuery.of(context).size.height;

                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                          alignment: Alignment.center,
                                          content: Container(
                                            height: h * 0.30,
                                            // padding: EdgeInsets.symmetric(horizontal: 30),
                                            // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10), // Add border radius if needed
                                            ),
                                            child: ClipRect(
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      InkWell(
                                                        onTap: (){
                                                          BlocProvider.of<HomeViewModel>(context).getImageFromGallery();
                                                        },
                                                        child: Container(
                                                          padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 13),
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(15),

                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Image.asset("assets/images/gallery.png"),
                                                              const SizedBox(width: 5,),
                                                              const   Text("Gallery",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(0xFF4A4A4A)),)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                        SizedBox(height: h *0.03,),
                                                      InkWell(
                                                        onTap: (){
                                                          BlocProvider.of<HomeViewModel>(context).getImageFromCamera();
                                                        },
                                                        child: Container(
                                                          padding:const EdgeInsets.symmetric(horizontal: 20),
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(15),

                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Image.asset("assets/images/3.png"),
                                                              const   Text("Camera",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(0xFF4A4A4A)),)
                                                            ],
                                                          ),
                                                        ),
                                                      )

                                                    ]
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );

                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)

                                    ),
                                    padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color:const Color(0xffFFA004),
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow:[
                                                BoxShadow(
                                                  offset: const Offset(0,5),
                                                  blurRadius: 3 ,
                                                  color: const Color(0xffFFA004).withOpacity(0.3),                                      )
                                              ]
                                          ),
                                          child: const Icon(
                                            Icons.arrow_upward_outlined,
                                            color: Colors.white,

                                          ),
                                        ),
                                        SizedBox(width: w*0.02,),
                                        const Text(
                                          "upload",
                                          style: TextStyle(
                                              color: Color(0xFF4A4A4A),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300
                                          ),

                                        )
                                      ],
                                    ),

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                         SizedBox(
                           height: MediaQuery.of(context).size.height * 0.65,
                           child: BlocBuilder<HomeViewModel,BaseRequestStates>(
                            builder: (context,state){
                              if(state is GetPhotoLoadingState){
                                return const Center(child:  CircularProgressIndicator());
                              }
                              if(state is GetPhotoSuccessState) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: GridView.count(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 8.0,
                                    mainAxisSpacing: 8.0,
                                    children: state.data!.data!.images!.map((
                                        image) {
                                      return Container(
                                        padding: const EdgeInsets.all(5),
                                        margin:const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                           color: Colors.white
                                        ),
                                        child:  Image.network(image,errorBuilder: (context, error, stackTrace) {
                                          return Container(color: Colors.white,); // Replace 'default_image.png' with your default image asset
                                        },),
                                      );
                                    }).toList(),
                                  ),
                                );
                              }else{
                                return const Text("something went wrong please try again");
                              }
                            },
                                                 ),
                         ),
                        InkWell(
                          onTap: (){
                            BlocProvider.of<HomeViewModel>(context).getPhotos();

                          },
                          child: Container(
                            padding:const EdgeInsets.all(10),
                            margin:const EdgeInsets.symmetric(vertical: 20,horizontal: 20),

                            decoration: BoxDecoration(
                                color: const Color(0xFF7BB3FF),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:const Center(
                              child: Text(
                                "Get photo",
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
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}
