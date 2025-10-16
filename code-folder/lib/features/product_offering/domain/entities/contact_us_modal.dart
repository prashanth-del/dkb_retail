// GENERATED Entity (Freezed): ContactUsModal
import 'package:freezed_annotation/freezed_annotation.dart';

import './contact_us_modal_payload_item.dart';
import './contact_us_modal_statu.dart';

part 'contact_us_modal.freezed.dart';

@freezed
class ContactUsModal with _$ContactUsModal {
  const factory ContactUsModal({
    ContactUsModalStatu? status,
    required List<ContactUsModalPayloadItem> payload,
  }) = _ContactUsModal;
}
