import 'package:dio_contact_list/models/contact_model.dart';
import 'package:dio_contact_list/pages/contact_details_page.dart';
import 'package:dio_contact_list/pages/create_contact_page.dart';
import 'package:dio_contact_list/repository/contact_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder<List<ContactModel>>(
              future: ContactRepository().getContacts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Center(child: CircularProgressIndicator()));
                }
                if (snapshot.hasError) {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Center(
                          child: Text('Erro ao carregar contatos')));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Center(
                          child: Text('Nenhum contato cadastrado')));
                }

                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final contact = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ContactDetailsPage(contact: contact),
                              ),
                            );
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image(
                                        image: NetworkImage(contact.profileUrl),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(contact.name),
                                      Text(contact.cellphone),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateContactPage(),
            ),
          );
          setState(() {});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
