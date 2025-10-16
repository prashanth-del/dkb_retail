import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/features/registration/data/models/username_rules_modal_dto.dart';
import 'package:dkb_retail/network/data/api_mapper.dart';
import 'package:dkb_retail/network/data/execute_api_call.dart';
import 'package:dkb_retail/network/data/model/app_status.dart';
import 'package:dkb_retail/network/data/network_client.dart';
import 'package:dkb_retail/network/data/urls/login_url.dart';
import 'package:dkb_retail/network/domain/models/api_envelope.dart';
import 'package:dkb_retail/network/domain/models/api_error.dart';
import 'package:logger/logger.dart';

part 'src/get_username_validations.dart';

abstract class UsernameValidationsDatasource {
  Future<ApiEnvelope<List<UsernameRulesModalDto>>> getUsernameValidations();
}

class UsernameValidationsDatasourceImpl extends UsernameValidationsDatasource {
  final NetworkClient client;

  UsernameValidationsDatasourceImpl({required this.client});

  @override
  Future<ApiEnvelope<List<UsernameRulesModalDto>>> getUsernameValidations() {
    // TODO: implement getUsernameValidations
    // throw UnimplementedError();
    return _getUsernameValidations(client);
  }
}
