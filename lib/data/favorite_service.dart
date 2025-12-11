import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/favorite_model.dart';

class FavoriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFavorite(Favorite favorite) async {
    await _firestore.collection('favorites').doc(favorite.mealId).set({
      'name': favorite.name,
      'imageUrl': favorite.imageUrl,
    });
  }

  Future<void> removeFavorite(String mealId) async {
    await _firestore.collection('favorites').doc(mealId).delete();
  }

  Stream<List<Favorite>> getFavorites() {
    return _firestore.collection('favorites').snapshots().map((snapshot) =>
        snapshot.docs
            .map((doc) => Favorite(
          mealId: doc.id,
          name: doc['name'],
          imageUrl: doc['imageUrl'],
        ))
            .toList());
  }
}
