import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_task/app/modules/authentication/data/models/user_model.dart';
import 'package:tezda_task/app/modules/authentication/domain/repositories/interfaces/authentication_repository_interface.dart';
import 'package:tezda_task/app/modules/authentication/domain/services/authentication_service.dart';
import 'package:tezda_task/app/modules/authentication/domain/services/interfaces/authentication_service_interface.dart';
import 'package:tezda_task/app/shared/helpers/classes/failures.dart';

import '../../../../shared/functions/app_functions.dart';

final authenticationRepositoryProvider =
    Provider<AuthenticationRepositoryInterface>((ref) {
  final service = ref.read(authenticationServiceProvider);
  return AuthenticationRepository(service: service);
});

class AuthenticationRepository implements AuthenticationRepositoryInterface {
  final AuthenticationServiceInterface service;

  AuthenticationRepository({required this.service});
  @override
  ApiFuture<void> forgotPassword({required String email}) {
    return service.forgotPassword(email: email);
  }

  @override
  ApiFuture<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await service.login(email: email, password: password);
    return response;
  }

  @override
  ApiFuture<UserModel> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final response = await service.register(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
    return response;
  }

  @override
  ApiFuture<void> updateProfile({String? firstName, String? lastName, String? email}) async{
    // TODO: implement updateProfile

    String uid = getUser()!.uid;
    final response = await service.updateUserProfile(
      uid: uid,
      email: email,
      firstName: firstName,
      lastName: lastName,
    );
    return response;
  }
}
