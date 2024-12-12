import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = ProfileStateInitial;
  const factory ProfileState.loading() = ProfileStateLoading;
  const factory ProfileState.success() = ProfileStateSuccess;
  const factory ProfileState.error(String message) = ProfileStateError;
}
