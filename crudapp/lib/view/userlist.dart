import 'package:crudapp/comtroller/submitdata.dart';
import 'package:crudapp/main.dart';
import 'package:crudapp/view/getinfopage.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

List userData= [];
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
            height: 80,
            width: 330,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0,0),
                  blurRadius: 0,
                  spreadRadius: 0,
                  color: Colors.black
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
                  children: [
                    Text("${userData[i].pan}"),
                    Text("${userData[i].name}"),
                    Text("${userData[i].postCode}"),
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
        child: const Icon(
          Icons.add,
        ), 
      ),
    );
  }
}