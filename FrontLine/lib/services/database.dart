import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/models/attendanceModel.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Collection Reference
  final CollectionReference attendanceCollection =
      FirebaseFirestore.instance.collection('attendance');

  final CollectionReference noticeboardCollection =
      FirebaseFirestore.instance.collection('noticeboard');

  final CollectionReference userprofileCollection =
      FirebaseFirestore.instance.collection('userprofile');

  final CollectionReference requestCollection =
      FirebaseFirestore.instance.collection('request');

  Future<void> updateAttendanceCollectionData(
      String username, String date, bool isPresent) async {
    return await attendanceCollection.doc(uid).set({
      'username': username,
      'date': date,
      'isPresent': isPresent,
    });
  }

  Future<void> updateRequestCollectionData(String request) async {
    return await requestCollection.doc(uid).set({
      'request': request,
    });
  }

  Future<void> updateUserProfileCollectionData(String username, String fName,
      String designation, String experience) async {
    return await userprofileCollection.doc(uid).set({
      'username': username,
      'fName': fName,
      'designation': designation,
      'experience': experience,
    });
  }

  Future<void> updateNoticeboardCollectionData(String notice) async {
    return await noticeboardCollection.doc('adminID').set({
      'notice': notice,
    });
  }

  // attendance data from snapshots
  AttendanceModel _attendanacedatafromsnapshot(DocumentSnapshot snapshot) {
    Map _temp = snapshot.data();
    return AttendanceModel(
        username: _temp['username'],
        date: _temp['date'],
        isPresent: _temp['isPresent']);
  }

  // getting user document stream
  Stream<AttendanceModel> get attendanceDoc {
    return attendanceCollection
        .doc(uid)
        .snapshots()
        .map(_attendanacedatafromsnapshot);
  }

  // querying
  // getting total no of collections

  Future<List> getTotal() async {
    QuerySnapshot x =
        await FirebaseFirestore.instance.collection('attendance').get();
    //print(x.docs.length);
    final allData = x.docs.map((doc) => doc.data()).toList();
    //print(allData.length);
    return allData;
  }

  Future<Map> getNotice() async {
    DocumentSnapshot d = await FirebaseFirestore.instance
        .collection('noticeboard')
        .doc('adminID')
        .get();

    final noticeData = d.data();
    return noticeData;
  }

  // get document with today's date
  Future<List> getToday(String date) async {
    QuerySnapshot x = await FirebaseFirestore.instance
        .collection('attendance')
        .where('date', isEqualTo: date)
        .where('isPresent', isEqualTo: true)
        .get();
    //print(x.docs.length);
    final allTodayData = x.docs.map((doc) => doc.data()).toList();
    //print(allTodayData.length);
    return allTodayData;
  }

  // get all request queries
  Future<List> getRequest() async {
    QuerySnapshot r =
        await FirebaseFirestore.instance.collection('request').get();

    final allRequest = r.docs.map((doc) => doc.data()).toList();
    return allRequest;
  }

  // get document of particular username
  Future<Map> getUserProfile(String username) async {
    DocumentSnapshot e = await FirebaseFirestore.instance
        .collection('userprofile')
        .doc(username)
        .get();
    final userProfileData = e.data();
    return userProfileData;
  }
}
