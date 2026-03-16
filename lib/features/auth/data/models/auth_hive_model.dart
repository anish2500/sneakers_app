import 'package:hive/hive.dart';
import 'package:sneakers_app/core/constants/hive_table_constant.dart';
import 'package:sneakers_app/features/auth/domain/entities/auth_entity.dart';
import 'package:uuid/uuid.dart';
part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.authTypeId)
class AuthHiveModel extends HiveObject {
  @HiveField(0)
  final String? authId;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String fullName;

  @HiveField(3)
  final String username;

  @HiveField(4)
  final String? password;

  @HiveField(5)
  final String? profilePicture;

  AuthHiveModel({
    this.authId,
    required this.fullName,
    required this.email,
    required this.username,
    this.password,
    this.profilePicture,
  });
  String get generatedAuthId => authId ?? const Uuid().v4();

  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      email: entity.email,
      fullName: entity.fullName,
      username: entity.username,
      password: entity.password,
      profilePicture: entity.profilePicture,
    );
  }

  AuthEntity toEntity() {
    return AuthEntity(
      authId: authId,

      email: email,
      fullName: fullName,
      username: username,
      password: password,
      profilePicture: profilePicture,
    );
  }

  static List<AuthEntity> toEntityList(List<AuthHiveModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}
