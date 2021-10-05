import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/Src/Cubits/Product/product_cubit.dart';
import 'package:flutter_task/Src/UI/Screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(
          create: (BuildContext context) => ProductCubit(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          primaryColor: const Color(0xFF127291),
          scaffoldBackgroundColor: Colors.grey[200]
        ),
        title: 'Material App',
        home: const HomeScreen(),
      ),
    );
  }
}
