import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/model/order_revenue.dart';
import 'package:kozarni_ecome/model/purchase.dart';
import 'package:uuid/uuid.dart';

class Database {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFunctions functions = FirebaseFunctions.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> watch(String collectionPath) =>
      _firebaseFirestore.collection(collectionPath).snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> watchOrder(
          String collectionPath) =>
      _firebaseFirestore
          .collection(collectionPath)
          .orderBy('dateTime', descending: true)
          .snapshots();

  Future<OrderRevenue> readOrderRevenue() async {
    return _firebaseFirestore
        .collection(orderHistoryCollection)
        .withConverter(
          fromFirestore: (snapshot, _) =>
              OrderRevenue.fromJson(snapshot.data()!),
          toFirestore: (orderRevenue, _) {
            final order = orderRevenue as OrderRevenue;
            return order.toJson();
          },
        )
        .get()
        .then((value) => value.docs.first.data());
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> read(
    String collectionPath, {
    String? path,
  }) =>
      _firebaseFirestore.collection(collectionPath).doc(path).get();

  Future<void> write(
    String collectionPath, {
    String? path,
    required Map<String, dynamic> data,
  }) =>
      _firebaseFirestore.collection(collectionPath).doc(path).set(data);

  //Write PurchaseData
  Future<void> writePurchaseData(PurchaseModel model) async {
    if (!(model.bankSlipImage == null)) {
      final file = File(model.bankSlipImage!);
      debugPrint("**************${model.bankSlipImage!}");
      try {
        await _firebaseStorage
            .ref()
            .child("bankSlip/${Uuid().v1()}")
            .putFile(file)
            .then((snapshot) async {
          await snapshot.ref.getDownloadURL().then((value) async {
            final purchaseModel = model.copyWith(bankSlipImage: value).toJson();
            //Then we set this user into Firestore
            await _firebaseFirestore
                .collection(purchaseCollection)
                .doc()
                .set(purchaseModel);
          });
        });
      } on FirebaseException catch (e) {
        debugPrint("*******Image Upload Error $e******");
      }
    }
    else {
      try {
        _firebaseFirestore
            .collection(purchaseCollection)
            .doc()
            .set(model.toJson());
      } catch (e) {
        debugPrint("****************PurchseSubmitError $e*************");
      }
    }
  }

  Future<void> update(
    String collectionPath, {
    required String path,
    required Map<String, dynamic> data,
  }) =>
      _firebaseFirestore.collection(collectionPath).doc(path).update(data);

  Future<void> delete(
    String collectionPath, {
    required String path,
  }) =>
      _firebaseFirestore.collection(collectionPath).doc(path).delete();

  //Update TotalOrder and TotalPrice in today Map
  Future<void> makeCompleteOrNotPurchase(PurchaseModel purchase) async {
    _firebaseFirestore.runTransaction((transaction) async {
      //secure snapshot
      debugPrint("*********PUrchaseID: ${purchase.id}");
      final secureSnapshot = await transaction.get(
          _firebaseFirestore.collection(purchaseCollection).doc(purchase.id));

      try {
        debugPrint("********DocumentRef: ${secureSnapshot.reference}");
        transaction.set(
            secureSnapshot.reference,
            {
              "complete": true,
            },
            SetOptions(merge: true));
        debugPrint("*********Make complete ${purchase.id}");
      } catch (e) {
        debugPrint("*********Error make purchase complete $e**");
      }
    });
  }
}
