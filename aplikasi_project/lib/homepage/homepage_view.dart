import 'package:aplikasi_project/homepage/homepage_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Counter app using cubit'),
              const SizedBox(
                height: 24,
              ),
              BlocBuilder<HomepageCubit, int>(
                builder: (context, state) {
                  return Text(
                    'counter: $state',
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<HomepageCubit>().increment();
                },
                child: const Text(
                  'increment',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<HomepageCubit>().decrement();
                },
                child: const Text(
                  'decrement',
                ),
              ),
            ]),
      ),
    );
  }
}
