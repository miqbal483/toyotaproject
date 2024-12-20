import 'package:aplikasi_project/homepage/homepage_cubit.dart';
import 'package:aplikasi_project/homepage/homepage_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class cubitnih extends StatelessWidget {
  const cubitnih({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomepageCubit(),
      child: const HomepageView(),
    );
  }
}
