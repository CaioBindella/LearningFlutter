import 'package:flutter/material.dart';
import 'package:learningapp/components/user_tile.dart';
import 'package:learningapp/provider/users.dart';
import 'package:learningapp/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of<Users>(context);

    return Scaffold(
        appBar: AppBar(
          title:
              Text('Lista de Usuários', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: users.count,
          itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
        ));
  }
}
