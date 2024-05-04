class ContactModel {
  final String? objectId;
  final String? createdAt;
  final String? updatedAt;
  final String name;
  final String cellphone;
  final DateTime? birthDate;
  final String profileUrl;

  ContactModel({
    this.objectId,
    this.createdAt,
    this.updatedAt,
    required this.name,
    required this.cellphone,
    this.birthDate,
    required this.profileUrl,
  });

  factory ContactModel.fromJsonRawJson(Map<String, dynamic> json) {
    return ContactModel(
      objectId: json['objectId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      name: json['name'],
      cellphone: json['cellphone'],
      birthDate:
          json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      profileUrl: json['profileUrl'],
    );
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      objectId: json['objectId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      name: json['name'],
      cellphone: json['cellphone'],
      birthDate:
          json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      profileUrl: json['profileUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cellphone': cellphone,
      'birthDate': birthDate?.toIso8601String(),
      'profileUrl': profileUrl,
    };
  }
}
