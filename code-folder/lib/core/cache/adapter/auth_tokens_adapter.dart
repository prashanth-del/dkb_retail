import 'package:hive/hive.dart';
import '../../../network/domain/models/auth_tokens.dart';

class AuthTokensAdapter extends TypeAdapter<AuthTokens> {
  @override
  final int typeId = 1;

  @override
  AuthTokens read(BinaryReader reader) {
    final atkn = reader.readString();
    final reftkn = reader.readString();
    return AuthTokens(atkn: atkn, reftkn: reftkn);
  }

  @override
  void write(BinaryWriter writer, AuthTokens obj) {
    writer.writeString(obj.atkn);
    writer.writeString(obj.reftkn);
  }
}