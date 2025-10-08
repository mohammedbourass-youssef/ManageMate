import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teamtasks/Services/UsersServices.dart';

class Usermodal {
  String id;
  String firstName;
  String lastNameName;
  String email;
  String? password;
  DateTime createdDate;
  int statistics;

  Usermodal({
    required this.id,
    required this.createdDate,
    required this.email,
    required this.firstName,
    this.password,
    required this.lastNameName,
    required this.statistics,
  });
  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastNameName: $lastNameName, '
        'email: $email, password: $password, createdDate: $createdDate, '
        'statistics: $statistics}';
  }

  factory Usermodal.getFromJson(data) {
    Timestamp ts = data[Usersservices.kCreatedDatefeild];
    return Usermodal(
      id: data[Usersservices.kID],
      createdDate: ts.toDate(),
      email: data[Usersservices.kEmailfeild],
      firstName: data[Usersservices.kFirstNamefeild],
      lastNameName: data[Usersservices.kLastNameNamefeild],
      statistics: data[Usersservices.kStatisticsfeild],
    );
  }
}
