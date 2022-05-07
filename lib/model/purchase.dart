import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kozarni_ecome/model/division.dart';

class PurchaseModel {
  final String? id;
  final List items;
  final String name;
  final String email;
  final int phone;
  final String address;
  final String? bankSlipImage;
  final List deliveryTownshipInfo;
  final int? totalCost;
  final DateTime? dateTime;
  final bool? complete;

  PurchaseModel({
    this.id,
    required this.items,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.deliveryTownshipInfo,
    required this.bankSlipImage,
    required this.totalCost,
    this.dateTime,
    this.complete = false,
  });

  //Object Clone
  PurchaseModel copyWith({
    String? id,
    List? items,
    String? name,
    String? email,
    int? phone,
    String? address,
    String? bankSlipImage,
    List? deliveryTownshipInfo,
    int? totalCost,
    DateTime? dateTime,
    bool? complete,
  }) =>
      PurchaseModel(
        items: items ?? this.items,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        deliveryTownshipInfo: deliveryTownshipInfo ?? this.deliveryTownshipInfo,
        bankSlipImage: bankSlipImage ?? this.bankSlipImage,
        totalCost: totalCost ?? this.totalCost,
        dateTime: dateTime ?? this.dateTime,
        complete: complete ?? this.complete,
      );

  factory PurchaseModel.fromJson(Map<String, dynamic> json, String id) =>
      PurchaseModel(
        id: id,
        items: json['items'] as List,
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as int,
        address: json['address'] as String,
        bankSlipImage: json['bankSlipImage'] as String?,
        deliveryTownshipInfo: json['deliveryTownshipInfo'] as List,
        totalCost: json['totalCost'] as int?,
        dateTime: (json['dateTime'] as Timestamp).toDate(),
        complete: json['complete'] as bool?,
      );

  @override
  String toString() {
    return "$id,$items,$name,$email,$phone,$address,$bankSlipImage,$deliveryTownshipInfo,$totalCost,$dateTime$complete";
  }

  Map<String, dynamic> toJson() => {
        'items': items,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'bankSlipImage': bankSlipImage,
        'deliveryTownshipInfo': deliveryTownshipInfo,
        'totalCost': totalCost,
        'dateTime': dateTime ?? DateTime.now(),
        'complete': complete ?? false,
      };
}
