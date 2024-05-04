import 'package:dio_contact_list/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactDetailsPage extends StatelessWidget {
  final ContactModel contact;

  const ContactDetailsPage({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Detalhes do Contato'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(
                  image: NetworkImage(contact.profileUrl),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(contact.name),
            const SizedBox(height: 10),
            Text(contact.cellphone),
          ],
        ),
      ),
    );
  }
}
