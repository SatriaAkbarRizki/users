import 'package:flutter/material.dart';
import 'package:users/model/users.dart';
import 'package:users/presenter/repository.dart';

class ViewPut extends StatefulWidget {
  const ViewPut({super.key});

  @override
  State<ViewPut> createState() => _ViewPutState();
}

class _ViewPutState extends State<ViewPut> {
  Repository repository = Repository();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  void putUser(String id, String name, String address, String avatar) async {
    UsersModel usersModel =
        UsersModel(id: id, name: name, address: address, avatar: avatar);
    repository.putUser(usersModel);
  }

  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;

    if (args.isNotEmpty) {
      nameController.text = args[1];
      addressController.text = args[2];
      imageController.text = args[3];
    }

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
                      putUser(args[0], nameController.text,
                          addressController.text, imageController.text);
                      ;
                      setState(() {});
                      Navigator.popAndPushNamed(context, '/home');
                    },
                    child: Icon(Icons.edit)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
