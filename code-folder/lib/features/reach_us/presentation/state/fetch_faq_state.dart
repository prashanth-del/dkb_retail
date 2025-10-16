import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/faqs.dart';

part 'fetch_faq_state.freezed.dart';

@freezed
class FetchFaqState with _$FetchFaqState {
  const factory FetchFaqState.initial() = _Initial;
  const factory FetchFaqState.loading() = _Loading;
  const factory FetchFaqState.success(Faqs? data) = _Success;
  const factory FetchFaqState.failure(String message) = _Failure;
}
