import 'package:colours/colours.dart';
import 'package:flutter/material.dart';

const Color scaffoldBackground = Colors.white;
const Color appBarColor = Colors.white;
const Color appBarTitleColor = Color.fromRGBO(19, 19, 19, 1);
const Color homeIndicatorColor = Color.fromRGBO(247, 98, 16, 1);
const Color detailBackgroundColor = Colors.white;
const Color detailTextBackgroundColor = Colors.white;
ButtonStyle buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colours.gold),
);

const String baseUrl = 'http://192.168.1.5:5000/api/v1/streaming/movie/';
const String profileUrl = 'profile/';
const String itemUrl = 'item/';

const String userCollection = 'users';
const String profileCollection = 'profiles';
const String itemCollection = 'items';
const String purchaseCollection = 'purchases';
const String brandCollection = 'brandProducts';
const String orderHistoryCollection = 'orderHistoryCollection';
const List<String> priceList = [
  "၁ ထည်ဈေးနှုန်း",
  "အထူးဈေးနှုန်း",
];
const String boxName = "favouritesBOX";

enum ApplicationLoginState {
  emailAddress,
  logout,
  password,
  register,
  signIn,
  authenticated,
  unauthenticate,
}
