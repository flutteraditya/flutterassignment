
import 'dart:developer';

import 'package:crudapp/comtroller/apiops.dart';
import 'package:crudapp/model/modalclass.dart';
import 'package:crudapp/view/userlist.dart';
import 'package:field_validation/Source_Code/FlutterValidation.dart';
import 'package:flutter/material.dart';
import 'package:crudapp/comtroller/submitdata.dart';

class GetInfoPage extends StatefulWidget {
  final bool isUpdate;
  const GetInfoPage({super.key,required this.isUpdate});

  @override
  // ignore: no_logic_in_create_state
  State<GetInfoPage> createState() => _GetInfoPageState(isUpdate: isUpdate);
}

TextEditingController panController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController add1Controller = TextEditingController();
TextEditingController add2Controller = TextEditingController();
TextEditingController postcodeController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController stateController = TextEditingController();
FlutterValidation validation = FlutterValidation();

class _GetInfoPageState extends State<GetInfoPage> {
  bool isUpdate;
  _GetInfoPageState({required this.isUpdate});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  PanInfo? user;
  PostCodeInfo? postcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Info"),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
          children: [
            const SizedBox(height: 30, width: double.infinity,),
            SizedBox(
              height: 50,
              width: 330,
              child: TextFormField(
                controller: panController,
                validator: (value) => (value == null || value.isEmpty) ? 
                "please enter pan number": 
                (validation.panValidate(content:value)) ? 
                null:
                "please enter valid pan",
                onFieldSubmitted:(value) async{
                  if(validation.panValidate(content:value)){
                    user = await postPanData(value);
                    if(user!.status == "Success"){
                      nameController.text = user!.name!; 
                      setState(() {
                        
                      });
                    }
                    else{
                      showDialog(
                        // ignore: use_build_context_synchronously
                        context: context, 
                        builder: (_) => AlertDialog(
                          title: Text("${user!.status}"),
                          content: Text("${user!.message}"),
                          actions: [
                            ElevatedButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              }, 
                              child: const Text("ok"),
                            ),
                          ],
                        )
                      );
                    }
                  }
                  else{
                    showDialog(
                      // ignore: use_build_context_synchronously
                      context: context, 
                      builder: (_) => AlertDialog(
                        title: const Text("error"),
                        content: const Text("enter valid pan"),
                        actions: [
                          ElevatedButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            }, 
                            child: const Text("ok"),
                          ),
                        ],
                      )
                    );
                  }
                },
                decoration: InputDecoration(
                  hintText: "PAN Number",
                  labelText: "Enter PAN Number",
                  hintStyle: const TextStyle(fontSize: 14,),
                  labelStyle: const TextStyle(fontSize: 14,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 50,
              width: 330,
              child: TextFormField(
                controller: nameController,
                showCursor: false,
                readOnly: true,
                validator: (value) => 
                (value == null || value.trim().isEmpty)? 
                "failed to get data": 
                null,
                decoration: InputDecoration(
                  hintText: "Full Name",
                  labelText: "Full Name",
                  hintStyle: const TextStyle(fontSize: 14,),
                  labelStyle: const TextStyle(fontSize: 14,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 50,
              width: 330,
              child: TextFormField(
                controller: emailController,
                validator: (value) => 
                (value == null || value.isEmpty) ? 
                "please enter email": 
                (validation.emailValidate(content: value.trim()))?
                null:
                "please enter valid email",
                decoration: InputDecoration(
                  hintText: "abc@gmail.com",
                  labelText: "Enter Email Id",
                  hintStyle: const TextStyle(fontSize: 14,),
                  labelStyle: const TextStyle(fontSize: 14,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 50,
              width: 330,
              child: TextFormField(
                controller: phoneController,
                validator: (value) => 
                (value == null || value.trim().isEmpty) ? 
                "please enter number": 
                (validation.mobileValidate(content: value.trim()))?
                null:
                "please enter valid number",
                //initialValue: "+91",
                decoration: InputDecoration(
                  hintText: "",
                  labelText: "Enter Mobile Number",
                  hintStyle: const TextStyle(fontSize: 14,),
                  labelStyle: const TextStyle(fontSize: 14,),
                  prefix: const Text("+91 "),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 50,
              width: 330,
              child: TextFormField(
                controller: add1Controller,
                validator: (value) => 
                (value == null || value.trim().isEmpty)? 
                "please enter address": 
                null,
                decoration: InputDecoration(
                  hintText: "flat no/building name",
                  labelText: "Enter Address 1",
                  hintStyle: const TextStyle(fontSize: 14,),
                  labelStyle: const TextStyle(fontSize: 14,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 50,
              width: 330,
              child: TextFormField(
                controller: add2Controller,
                decoration: InputDecoration(
                  hintText: "locality/area",
                  labelText: "Enter Address 2",
                  hintStyle: const TextStyle(fontSize: 14,),
                  labelStyle: const TextStyle(fontSize: 14,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 50,
              width: 330,
              child: TextFormField(
                controller: postcodeController,
                validator: (value) => 
                (value == null || value.trim().isEmpty)? 
                "please enter postcode":
                (value.trim().length == 6)? 
                null:
                "please enter valid postcode",
                onFieldSubmitted: (value) async{
                  if(value.length == 6){
                    postcode = await postCodeData(int.parse(value));
                    log("${postcode!.status}");
                    if(postcode!.status == "Success"){
                      cityController.text = postcode!.cities![0].name; 
                      stateController.text = postcode!.states![0].name; 
                      setState(() {
                        
                      });
                    }
                    else{
                      showDialog(
                        // ignore: use_build_context_synchronously
                        context: context, 
                        builder: (_) => AlertDialog(
                          title: Text("${postcode!.status}"),
                          content: Text("${postcode!.message}"),
                          actions: [
                            ElevatedButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              }, 
                              child: const Text("ok"),
                            ),
                          ],
                        )
                      );
                    }
                  }
                  else{
                    showDialog(
                      // ignore: use_build_context_synchronously
                      context: context, 
                      builder: (_) => AlertDialog(
                        title: const Text("error"),
                        content: const Text("enter valid postcode"),
                        actions: [
                          ElevatedButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            }, 
                            child: const Text("ok"),
                          ),
                        ],
                      )
                    );
                  }
                },
                decoration: InputDecoration(
                  hintText: "Ex: 411046",
                  labelText: "Enter Post Code",
                  hintStyle: const TextStyle(fontSize: 14,),
                  labelStyle: const TextStyle(fontSize: 14,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 50,
              width: 330,
              child: TextFormField(
                controller: cityController,
                readOnly: true,
                validator: (value) => 
                (value == null || value.trim().isEmpty)? 
                "failed to get value": 
                null,
                decoration: InputDecoration(
                  hintText: "Ex: Pune",
                  labelText: "City",
                  hintStyle: const TextStyle(fontSize: 14,),
                  labelStyle: const TextStyle(fontSize: 14,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 50,
              width: 330,
              child: TextFormField(
                controller: stateController,
                readOnly: true,
                validator: (value) => 
                (value == null || value.trim().isEmpty)? 
                "failed to get value": 
                null,
                decoration: InputDecoration(
                  hintText: "Ex: Maharashtra",
                  labelText: "State",
                  hintStyle: const TextStyle(fontSize: 14,),
                  labelStyle: const TextStyle(fontSize: 14,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: ()async{
                bool isValid = formKey.currentState!.validate();
                if(isValid){
                  await onSubmit(
                    isUpdate,
                    UserInfo(
                      pan: panController.text.trim(), 
                      name: nameController.text.trim(), 
                      email: emailController.text.trim(), 
                      phoneNo: phoneController.text.trim(), 
                      add1: add1Controller.text.trim(), 
                      add2: add2Controller.text.trim(), 
                      postCode: int.parse(postcodeController.text.trim()), 
                      city: cityController.text.trim(), 
                      state: stateController.text.trim()
                    ),
                  );
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const UserListPage(), 
                    ),
                  );
                  clearControllers();
                }
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                fixedSize: const Size(330, 40),
              ),
              child: const Text("Submit"),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}