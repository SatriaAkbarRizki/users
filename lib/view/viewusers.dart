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
                          trailing: PopupMenuButton<int>(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: Row(children: [
                                  Icon(Icons.edit_outlined),
                                  Text('Edit Data')
                                ]),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Row(children: [
                                  Icon(Icons.delete_forever_outlined),
                                  Text('Delete Data')
                                ]),
                              )
                            ],
                            offset: Offset(0, 50),
                            elevation: 2,
                            onSelected: (value) async {
                              if (value == 1) {
                                print('Selected Edit Mode');
                              } else if (value == 2) {
                                await repository
                                    .deleteUser(snapshot.data![index].id);
                                fetchUser();
                                setState(() {});
                              }
                            },
                          ),
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
