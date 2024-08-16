import 'package:flutter/material.dart';
import 'package:learningapp/models/user.dart';
import 'package:learningapp/provider/users.dart';
import 'package:learningapp/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: SizedBox(
        width: 100, // Adjust the width according to your needs
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.USER_FORM,
                    arguments: user,
                  );
                },
                icon: Icon(Icons.edit),
                color: Colors.orange),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Excluir Usuário'),
                      content:
                          Text('Tem certeza que deseja excluir esse usuário?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx)
                                .pop(); // Close the dialog without taking any action
                          },
                          child: Text('Não'),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<Users>(context, listen: false)
                                .remove(user);
                            // Perform the deletion action here
                            Navigator.of(context)
                                .pop(); // Close the dialog after action
                          },
                          child: Text('Sim'),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.delete),
                color: Colors.red),
          ],
        ),
      ),
    );
  }
}
