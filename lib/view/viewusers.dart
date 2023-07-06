import 'package:flutter/material.dart';
import 'package:users/model/users.dart';
import 'package:users/presenter/repository.dart';

class ViewUsers extends StatefulWidget {
  const ViewUsers({super.key});

  @override
  State<ViewUsers> createState() => _ViewUsersState();
}

class _ViewUsersState extends State<ViewUsers> {
  Repository repository = Repository();
  List<UsersModel>? users;

  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  void fetchUser() async {
    users = await repository.FetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<UsersModel>?>(
          future: repository.FetchUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(border: Border.all(width: 2)),
                        width: 400,
                        child: ListTile(
                          leading: CircleAvatar(
                              foregroundImage:
                                  NetworkImage(snapshot.data![index].avatar)),
                          title: Text(snapshot.data![index].name),
                          subtitle:
                              Text('Address: ${snapshot.data![index].address}'),
                          trailing: IconButton(
                              onPressed: () {}, icon: Icon(Icons.arrow_right)),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Text('NOT HAVE DATA');
              }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/add-user');
          },
          child: Icon(Icons.add)),
    );
  }
}
