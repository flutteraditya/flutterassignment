
import 'dart:developer';

import 'package:crudapp/main.dart';
import 'package:crudapp/model/modalclass.dart';
import 'package:crudapp/view/getinfopage.dart';
import 'package:crudapp/view/userlist.dart';

//to submit the data which create new user of update existing user
onSubmit(bool isUpdate,UserInfo user)async{
  if(isUpdate){
    await updateData("userinfo", user);
  }
  else{
    await insertData("userinfo", user);
  }
  log("message");
  await fetchData();
}

//to clear all controller 
clearControllers(){
    panController.clear();
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    add1Controller.clear();
    add2Controller.clear();
    postcodeController.clear();
    cityController.clear();
    stateController.clear();
}


//to add data in list from databse to display user list 
fetchData()async{
  userData = [];
  List lst = await getData("userinfo");
  for (var element in lst) { 
    userData.add(
      UserInfo(
        pan: element["panNo"], 
        name: element["name"], 
        email: element["email"], 
        phoneNo: element["phoneNo"], 
        add1: element["add1"], 
        add2: element["add2"], 
        postCode: element["postCode"], 
        city: element["city"], 
        state: element["state"]
      )
    );
  }
}

//if want to update existing user this method fill the previous data of user in textfield
updateFields(UserInfo user){
  panController.text = user.pan;
  nameController.text = user.name;
  emailController.text = user.email;
  phoneController.text = user.phoneNo;
  add1Controller.text = user.add1;
  add2Controller.text = user.add2;
  postcodeController.text = "${user.postCode}";
  cityController.text = user.city;
  stateController.text = user.state;
}