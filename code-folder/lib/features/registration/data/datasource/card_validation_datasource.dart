import 'package:db_uicomponents/utils.dart';
import 'package:dkb_retail/features/registration/data/models/card_validation_modal_dto.dart';
import 'package:dkb_retail/network/data/api_mapper.dart';
import 'package:dkb_retail/network/data/execute_api_call.dart';
import 'package:dkb_retail/network/data/model/app_status.dart';
import 'package:dkb_retail/network/data/network_client.dart';
import 'package:dkb_retail/network/data/urls/login_url.dart';
import 'package:dkb_retail/network/domain/models/api_envelope.dart';
import 'package:dkb_retail/network/domain/models/api_error.dart';
import 'package:logger/logger.dart';

import '../../../../common/utils.dart';

part 'src/get_card_validations.dart';

abstract class CardValidationDatasource {
  Future<ApiEnvelope<List<CardValidationModalDto>>> getCardValidations();
}

class CardValidationDatasourceImpl extends CardValidationDatasource {
  final NetworkClient networkClient;

  CardValidationDatasourceImpl({required this.networkClient});

  @override
  Future<ApiEnvelope<List<CardValidationModalDto>>> getCardValidations() {
    // TODO: implement getCardValidation
    // throw UnimplementedError();
    return _getCardValidations(networkClient);
  }
}
