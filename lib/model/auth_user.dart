import 'package:json_annotation/json_annotation.dart';
import 'package:kozarni_ecome/model/custom_claim_obj.dart';

part 'auth_user.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthUser {
  final String uid;
  final String? email;
  final CustomClaimObj? customClaims;
  AuthUser(
      {required this.uid, required this.email, required this.customClaims});

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserToJson(this);
}
