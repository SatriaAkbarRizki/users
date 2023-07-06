import 'package:flutter/material.dart';
import 'package:users/model/users.dart';
import 'package:users/presenter/repository.dart';

class ViewAdd extends StatefulWidget {
  const ViewAdd({super.key});

  @override
  State<ViewAdd> createState() => _ViewAddState();
}

class _ViewAddState extends State<ViewAdd> {
  Repository repository = Repository();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  void addUser() async {
    String id = "0";
    String name = nameController.text;
    String address = addressController.text;
    String avatar = imageController.text;
    UsersModel _usersModel =
        UsersModel(id: id, name: name, address: address, avatar: avatar);

    repository.postUser(_usersModel);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/home');
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Name'),
                controller: nameController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Address'),
                controller: addressController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Image'),
                controller: imageController,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                    onPressed: () async {
                      addUser();
                      Navigator.popAndPushNamed(context, '/home');
                      setState(() {});
                    },
                    child: Icon(Icons.add)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
