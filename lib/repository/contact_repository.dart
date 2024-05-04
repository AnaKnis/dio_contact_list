import 'dart:convert';

import 'package:dio_contact_list/models/contact_model.dart';
import 'package:http/http.dart' as http;

class ContactRepository {
  final headers = {
    "X-Parse-Application-Id": "9lTotiiFWNmO3xfayItXjDEGM1yT4oyRr4omWmud",
    "X-Parse-REST-API-Key": "jYfgs40tNramfGb9P73wC98fZ0dSiUuc44SHEHnT",
  };

  Future<List<ContactModel>> getContacts() async {
    final response = await http.get(
        Uri.parse("https://parseapi.back4app.com/classes/person"),
        headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<ContactModel> contacts =
          data.map((contact) => ContactModel.fromJson(contact)).toList();
      return contacts;
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  Future<void> postContact(ContactModel contact) async {
    final response = await http.post(
      Uri.parse("https://parseapi.back4app.com/classes/person"),
      headers: {
        "Content-Type": "application/json",
        ...headers,
      },
      body: jsonEncode(contact.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to post contact');
    }
  }

  Future<void> deleteContact(String objectId) async {
    final response = await http.delete(
      Uri.parse("https://parseapi.back4app.com/classes/person/$objectId"),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete contact');
    }
  }
}
