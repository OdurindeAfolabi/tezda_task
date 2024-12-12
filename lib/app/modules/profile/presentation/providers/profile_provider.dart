import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_task/app/modules/authentication/data/models/user_model.dart';
import 'package:tezda_task/app/modules/authentication/domain/repositories/authentication_repository.dart';
import 'package:tezda_task/app/modules/authentication/domain/repositories/interfaces/authentication_repository_interface.dart';
import 'package:tezda_task/app/modules/profile/presentation/providers/profile_state.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  final repo = ref.read(authenticationRepositoryProvider);
  return ProfileNotifier(repo: repo);
});

class ProfileNotifier extends StateNotifier<ProfileState> {
  final AuthenticationRepositoryInterface repo;
  ProfileNotifier({required this.repo}) : super(const ProfileState.initial());
  

  void updateUserProfile({
    String? email,
    String? firstName,
    String? lastName,
    ValueChanged<void>? onSuccess,
  }) async {
    state = const ProfileState.loading();
    final response = await repo.updateProfile(
      email: email,
      firstName: firstName,
      lastName: lastName
    );
    response.fold(
          (userModel) {
        state = const ProfileState.success();
        onSuccess?.call(userModel);
      },
          (error) => state = ProfileState.error(error.message),
    );
  }
}
