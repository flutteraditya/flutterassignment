import 'package:crudapp/comtroller/submitdata.dart';
import 'package:crudapp/main.dart';
import 'package:crudapp/model/modalclass.dart';
import 'package:crudapp/view/getinfopage.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

List<UserInfo> userData= [];
class _UserListPageState extends State<UserListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: ListView.builder(
        itemCount: userData.length,
        itemBuilder: (_,i){
          return Container(
            height: 100,
            width: 330,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(2,1),
                  blurRadius: 3,
                  spreadRadius: 1,
                  color: Colors.grey
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${i+1}."),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${userData[i].pan}",
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                    Text(
                      "${userData[i].name}",
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                    Text(
                      "${userData[i].city}",
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        updateFields(userData[i]);
                        
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const GetInfoPage(isUpdate: true),
                          ),
                        );
                      },
                      child: const Icon(Icons.edit_outlined),
                    ),
                    GestureDetector(
                      onTap: () async{
                        await deleteData("userinfo", userData[i]);
                        fetchData();
                        setState(() {
                          
                        });
                      },
                      child: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
              ],
            ),
          );
        } 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const GetInfoPage(isUpdate: false),
            ),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
        ), 
      ),
    );
  }
}