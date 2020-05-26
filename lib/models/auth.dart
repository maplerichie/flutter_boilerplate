import 'package:hive/hive.dart';
import 'user.dart';

part 'auth.g.dart';

@HiveType(typeId: 0)
class Auth extends HiveObject {
  @HiveField(0)
  String jwt; //sub, name, exp

  @HiveField(1)
  int role;

  @HiveField(2)
  int status;

  @HiveField(3)
  User user;

  Auth({this.jwt, this.role, this.status, this.user});
}
