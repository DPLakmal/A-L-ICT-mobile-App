import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<QuerySnapshot> getQuestionyearData(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .get();
  }

  Future<QuerySnapshot> getQuestioCategoriesnData(String quizId, String tag) async {
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .where("tag", isEqualTo: tag)
        .get();
  }

  Future<DocumentSnapshot> getDashimageList() async {
    return await FirebaseFirestore.instance
        .collection("DashBoard_Images")
        .doc()
        .get();
  }
}
