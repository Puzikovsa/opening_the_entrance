import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:provider/provider.dart';

import '../models/phone_list.dart';
import 'add_phone_page.dart';

class AccessListPage extends StatelessWidget {
  const AccessListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Выберите телефон доступа'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Для удаления нажать и удерживать\n поле точки доступа',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(
                  future: Provider.of<PhoneList>(context, listen: false)
                      .fetchAndSetListPhone(),
                  builder: (context, snapshot) {
                    return Consumer<PhoneList>(
                      builder: (context, phoneList, child) => phoneList
                              .items.isEmpty
                          ? child!
                          : ListView.builder(
                              itemCount:
                                  Provider.of<PhoneList>(context).items.length,
                              itemBuilder: (context, index) => Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: const [
                                        BoxShadow(
                                          color:  Colors.blueAccent,
                                          offset: Offset(3.0, 3.0),
                                          blurRadius: 10,
                                          spreadRadius: 1.0
                                        ),
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 0,
                                          spreadRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      splashColor: Colors.red,
                                      title: Text(
                                        Provider.of<PhoneList>(context)
                                            .items[index]
                                            .title,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      subtitle: Text(
                                          Provider.of<PhoneList>(context)
                                              .items[index]
                                              .number),
                                      trailing: const Icon(
                                        Icons.phone,
                                        color: Colors.green,
                                        size: 35,
                                      ),
                                      onTap: () {
                                        FlutterPhoneDirectCaller.callNumber(
                                          Provider.of<PhoneList>(context,
                                                  listen: false)
                                              .items[index]
                                              .number
                                              .toString(),
                                        );
                                      },
                                      onLongPress: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                'Хотите удалить номер?'),
                                            duration:
                                                const Duration(seconds: 3),
                                            action: SnackBarAction(
                                                label: 'Да',
                                                onPressed: () {
                                                  Provider.of<PhoneList>(
                                                          context,
                                                          listen: false)
                                                      .deletePhone(phoneList
                                                          .items[index]);
                                                }),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                      child: const Center(
                        child: Text(
                          'Не найдено ни одного места.\nСамое время добавить новое!',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddPhonePage.rout);
              },
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),

            ),
          ],
        ),
      ),
    );
  }
}
