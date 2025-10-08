import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamtasks/Constants.dart';
import 'package:teamtasks/models/UserModal.dart';

class Usersservices {
  static const String kID = 'UserID';
  static const String kUsersCollection = 'users';
  static const String kFirstNamefeild = 'FirstName';
  static const String kLastNameNamefeild = 'LastName';
  static const String kEmailfeild = 'Email';
  static const String kCreatedDatefeild = 'CreatedAt';
  static const String kStatisticsfeild = 'Statistics';
  static const kFullName = 'FullName';
  static Stream<QuerySnapshot> getUsersFilter(String fullname) {
    return FirebaseFirestore.instance
        .collection(kUsersCollection)
        .where(kFullName, isGreaterThanOrEqualTo: fullname)
        .where(kFullName, isLessThan: '$fullname\uf8ff')
        .snapshots();
  }

  static Future<void> increaseTheStatisticsByOne(String userID) async {
    // Query the user by ID
    var data = await FirebaseFirestore.instance
        .collection(kUsersCollection)
        .where(kID, isEqualTo: userID)
        .limit(1)
        .get();

    if (data.docs.isNotEmpty) {
      // get the document ID
      String docId = data.docs.first.id;

      // increment the field
      await FirebaseFirestore.instance
          .collection(kUsersCollection)
          .doc(docId)
          .update({kStatisticsfeild: FieldValue.increment(1)});
    }
  }
   static Stream<int> platformUsersCountStream() {
    return FirebaseFirestore.instance
        .collection(kUsersCollection)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  static Future<bool> isThisEmailExist(String? email) async {
    if (email == null) {
      return false;
    }
    var data = await FirebaseFirestore.instance
        .collection(kUsersCollection)
        .where(kEmailfeild, isEqualTo: email)
        .get();
    return data.docs.isNotEmpty;
  }

  static Future<Usermodal> getUserByEmail(String email) async {
    var result = await FirebaseFirestore.instance
        .collection(kUsersCollection)
        .where(kEmailfeild, isEqualTo: email)
        .limit(1)
        .get();
    return Usermodal.getFromJson(result.docs.first);
  }

  static Future<void> getCurrentLogedInUSer(String email) async {
    logedinUser = await getUserByEmail(email);
  }

  static Future<void> saveUser(Usermodal user) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: user.email,
          password: user.password!,
        );
    user.id = credential.user!.uid;
    await FirebaseFirestore.instance.collection(kUsersCollection).add({
      kID: user.id,
      kFirstNamefeild: user.firstName,
      kLastNameNamefeild: user.lastNameName,
      kEmailfeild: user.email,
      kCreatedDatefeild: DateTime.now(),
      kStatisticsfeild: 0,
      kFullName: '${user.firstName} ${user.lastNameName}',
    });
    logedinUser = user;
  }
}
