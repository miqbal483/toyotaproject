import 'package:aplikasi_project/user/cubit/user/user_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User Screen'),
        ),
        body: BlocProvider(
            create: (_) => UserCubit()..getUserList(),
            child: BlocConsumer<UserCubit, CubitState>(
                builder: (ctx, state) {
                  if (state is FetchUserSuccess) {
                    return ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          title: Text(state.data[index].title ?? '-'),
                          subtitle: Text(state.data[index].body ?? '-'),
                        );
                      },
                      itemCount: state.data.length,
                      shrinkWrap: true,
                    );
                  } else if (state is FetchUserFailed) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
                listener: (ctx, state) {})));
  }
}
