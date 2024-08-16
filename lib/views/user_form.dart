import 'package:flutter/material.dart';
import 'package:learningapp/models/user.dart';
import 'package:learningapp/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    _formData['id'] = user.id ?? '';
    _formData['name'] = user.name ?? '';
    _formData['email'] = user.email ?? '';
    _formData['avatarUrl'] = user.avatarUrl ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ModalRoute.of(context)?.settings.arguments as User?;

    if (user != null) {
      _loadFormData(user);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Usuário'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final isValid = _form.currentState?.validate() ?? false;

              if (isValid) {
                _form.currentState?.save();

                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'] ?? '', // Ensure non-null assignment
                    name: _formData['name'] ?? '', // Ensure non-null assignment
                    email:
                        _formData['email'] ?? '', // Ensure non-null assignment
                    avatarUrl: _formData['avatarUrl'] ?? '',
                  ),
                );

                Navigator.of(context).pop();
              }
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome inválido!';
                  }
                  if (value.trim().length < 3) {
                    return 'Nome muito pequeno. No mínimo 3 letras.';
                  }
                },
                onSaved: (value) => _formData['name'] = value ?? '',
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => _formData['email'] = value ?? '',
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: InputDecoration(labelText: 'Url Do Avatar'),
                onSaved: (value) => _formData['avatarUrl'] = value ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
