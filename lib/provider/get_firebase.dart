import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dodge_game/data/game_record.dart';

class FireStore {
  static final scoreRef =
      FirebaseFirestore.instance.collection('score').withConverter<GameRecord>(
            fromFirestore: (snapshots, _) {
              if (snapshots.exists) {
                return GameRecord.fromJson(snapshots.data()!);
              } else {
                throw Exception('Save Score Error');
              }
            },
            toFirestore: (record, _) => record.toJson(),
          );

  static Future<void> saveScore(GameRecord gameRecord) async {
    await scoreRef.add(gameRecord);
  }

  static void getData(
    // ignore: inference_failure_on_function_return_type
    Function(List<QueryDocumentSnapshot<GameRecord>> docs) callback,
  ) {
    scoreRef
        .orderBy('num', descending: true)
        .snapshots()
        .listen((QuerySnapshot<GameRecord> snapshot) {
      callback.call(snapshot.docs);
    });
  }
}
