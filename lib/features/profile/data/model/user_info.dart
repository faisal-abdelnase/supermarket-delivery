import 'package:hive/hive.dart';
part 'user_info.g.dart';


@HiveType(typeId: 0)

class UserInfoModel extends HiveObject {

  @HiveField(0)
  String name;
  @HiveField(1)
  String? email;
  @HiveField(2)
  String imagePath;

  UserInfoModel({
    required this.name,
    this.email,
    required this.imagePath,
  });
}
