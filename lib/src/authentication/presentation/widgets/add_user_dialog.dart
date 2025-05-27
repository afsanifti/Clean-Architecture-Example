import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testingapp/src/authentication/presentation/cubit/authentication_cubit.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({super.key, required this.nameController});

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'username'),
              ),
              ElevatedButton(
                onPressed: () {
                  final String avatar =
                      'https://avatars.githubusercontent.com/u/67006995';
                  final name = nameController.text.trim();
                  context.read<AuthenticationCubit>().createUser(
                    createdAt: DateTime.now().toString(),
                    name: name,
                    avatar: avatar,
                  );
                },
                child: Text('Create User'),
              ),
              // TextField(decoration: InputDecoration(labelText: 'username')),
              // TextField(decoration: InputDecoration(labelText: 'username')),
            ],
          ),
        ),
      ),
    );
  }
}
