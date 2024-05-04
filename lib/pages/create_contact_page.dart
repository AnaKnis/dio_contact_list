import 'package:dio_contact_list/models/contact_model.dart';
import 'package:dio_contact_list/repository/contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateContactPage extends StatefulWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cellphoneController = TextEditingController();

  CreateContactPage({super.key});

  @override
  State<CreateContactPage> createState() => _CreateContactPageState();
}

class _CreateContactPageState extends State<CreateContactPage> {
  @override
  Widget build(BuildContext context) {
    final contactRepository = ContactRepository();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Criar Contato'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  //todo: implement image picker
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ainda não é possível escolher uma foto'),
                    ),
                  );
                },
                child: const CircleAvatar(
                  radius: 60,
                  child: Icon(Icons.add),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: widget.nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: widget.cellphoneController,
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (widget.nameController.text.isEmpty ||
                      widget.nameController.text.length < 3 ||
                      widget.cellphoneController.text.isEmpty ||
                      widget.cellphoneController.text.length < 5) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Preencha todos os campos corretamente'),
                      ),
                    );
                    return;
                  }

                  await contactRepository.postContact(
                    ContactModel(
                      name: widget.nameController.text,
                      cellphone: widget.cellphoneController.text,
                      profileUrl:
                          'https://i.pravatar.cc/150?u=${widget.nameController.text}',
                    ),
                  );
                  widget.nameController.clear();
                  widget.cellphoneController.clear();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Contato criado com sucesso'),
                    ),
                  );

                  Navigator.pop(context);
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
