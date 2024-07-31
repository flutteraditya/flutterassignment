
import 'dart:convert';
import 'dart:developer';

import 'package:crudapp/model/modalclass.dart';
import 'package:http/http.dart' as http;

//post pandata
postPanData(String pan)async{
  Uri url = Uri.parse("https://lab.pixel6.co/api/verify-pan.php");
  Map<String,String> body = {
    "panNumber" : "AAFNZ2078H"
  };
  http.Response res = await http.post(
    url,
    body: body
  );
  log(res.body);
  Map mp = jsonDecode(res.body);
  return PanInfo(mp);
}

//post postcode data
postCodeData(int postcode)async{
  Uri url = Uri.parse("https://lab.pixel6.co/api/get-postcode-details.php");
  Map<String,String> body = {
    "postcode" : "$postcode"
  };
  log("message");
  http.Response res = await http.post(
    url,
    body: body
  );
  log("message");
  log(res.body);
  Map mp = jsonDecode(res.body);
  log("message");
  return PostCodeInfo(mp);
}

//for testing
postPanDataDemo(String pan)async{
  return PanInfo(
    {
      "status" : "Success",
      "statusCode" : 200,
      "isValid" : true,
      "fullName" : "Aditya Khetre"
    }
  );
}

//for testing
postCodeDataDemo(int i)async{
  return PostCodeInfo(
    {
      "status" : "Success",
      "statusCode" : 200,
      "postcode" : 431302,
      "city" : [{"id" : 1,"name" : "pune"}],
      "state" : [{"id" : 1,"name" : "maharashtra"}]
    }
  );
}