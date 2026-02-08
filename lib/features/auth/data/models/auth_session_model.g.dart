part of 'auth_session_model.dart';

class AuthSessionModelAdapter extends TypeAdapter<AuthSessionModel> {
  @override
  final int typeId = 3;

  @override
  AuthSessionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthSessionModel(
      user: fields[0] as User?,
      isLoggedIn: fields[1] as bool,
      lastLogin: fields[2] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, AuthSessionModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(1)
      ..write(obj.isLoggedIn)
      ..writeByte(2)
      ..write(obj.lastLogin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthSessionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
