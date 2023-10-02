import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/phone_list.dart';

class AddPhonePage extends StatefulWidget {
  const AddPhonePage({super.key});

  static const String rout = '/add_phone';

  @override
  State<AddPhonePage> createState() => _AddPhonePageState();
}

class _AddPhonePageState extends State<AddPhonePage> {
  final _titleController = TextEditingController();
  final _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Добавление точки доступа'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Придумайте название',
                    ),
                    controller: _titleController,
                  ),
                  const Divider(),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Введите номер телефона, начиная с 8',
                    ),
                    controller: _numberController,
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                  ),
                  const Divider(),
                ],
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                if (_titleController.text.isEmpty ||
                    _numberController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Заполните все поля')));
                  return;
                }
                if (_numberController.text.length < 11 ||
                    !_numberController.text.startsWith('8')) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Введен некорректный номер')));
                  return;
                }
                Provider.of<PhoneList>(context, listen: false).addListPhone(
                    _titleController.text, _numberController.text);
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}