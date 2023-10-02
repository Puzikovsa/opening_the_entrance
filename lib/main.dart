import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:opening_the_entrance/models/phone.dart';
import 'package:opening_the_entrance/models/phone_list.dart';
import 'package:opening_the_entrance/pages/access_list_page.dart';
import 'package:opening_the_entrance/pages/add_phone_page.dart';
import 'package:provider/provider.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter<Phone>(PhoneAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: PhoneList(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue)
              .copyWith(secondary: Colors.limeAccent),
        ),
        home: const AccessListPage(),
        routes: {
          AddPhonePage.rout: (context) => const AddPhonePage()
        },
      ),
    );
  }
}
