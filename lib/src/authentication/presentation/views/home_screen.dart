import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testingapp/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:testingapp/src/authentication/presentation/widgets/add_user_dialog.dart';
import 'package:testingapp/src/authentication/presentation/widgets/loading_column.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  void getUsers() {
    context.read<AuthenticationCubit>().getUser();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is UserCreated) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body:
              state is GettingUsers
                  ? const LoadingColumn(message: 'Getting users')
                  : state is CreatingUser
                  ? const LoadingColumn(message: 'Creating user')
                  : state is UsersLoaded
                  ? Center(
                    child: ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return ListTile(
                          leading: Image.network(user.avatar),
                          title: Text(user.name),
                          subtitle: Text(user.createdAt.substring(10)),
                        );
                      },
                    ),
                  )
                  : SizedBox.shrink(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => AddUserDialog(nameController: _nameController),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Add user'),
          ),
        );
      },
    );
  }
}
