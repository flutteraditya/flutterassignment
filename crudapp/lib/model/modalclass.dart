

class PanInfo{
  String? status;
  int? statusCode;
  bool? isValid;
  String? name;
  String? pan;
  String? message;

  PanInfo(Map json){
    if(json["status"] == "Success"){
      status = json["status"];
      statusCode = json["statusCode"];
      isValid = json["isValid"];
      name = json["fullName"];
    }
    else{
      status = json["status"];
      statusCode = json["statusCode"];
      pan = json["panNumber"];
      message = json["message"];
    }
  }
}

class PostCodeInfo{
  String? status;
  int? statusCode;
  int? postCode;
  List? cities;
  List? states;
  String? message;
  
  PostCodeInfo(Map json){
    if(json["status"] == "Success"){
      status = json["status"];
      statusCode = json["statusCode"];
      postCode = json["postcode"];

      cities = [];
      states = [];

      if(json["city"] != null){
        json["city"].forEach((json){
          cities!.add(LocationInfo(json));
        });
      }
      if(json["state"] != null){
        json["state"].forEach((json){
          states!.add(LocationInfo(json));
        });
      }
    }
    else{
      status = json["status"];
      message = json["message"];
    }
  }
}

class LocationInfo{
  int? id;
  String? name;
  LocationInfo(Map json){
    id = json["id"];
    name = json["name"];
  }
}


class UserInfo{

  String pan;
  String name;
  String email;
  String phoneNo;
  String add1;
  String add2;
  int postCode;
  String city;
  String state;

  UserInfo(
    {
      required this.pan,
      required this.name,
      required this.email,
      required this.phoneNo,
      required this.add1,
      required this.add2,
      required this.postCode,
      required this.city,
      required this.state
    }
  );

  retMap(){
    return {
      "panNo": pan,
      "name": name,
      "email": email,
      "phoneNo": phoneNo,
      "add1": add1,
      "add2": add2,
      "postCode": postCode,
      "city": city,
      "state": state
    };
  }
}