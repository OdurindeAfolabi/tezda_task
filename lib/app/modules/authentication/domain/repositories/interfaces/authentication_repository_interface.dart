import 'package:tezda_task/app/modules/authentication/data/models/user_model.dart';
import 'package:tezda_task/app/shared/helpers/classes/failures.dart';

abstract interface class AuthenticationRepositoryInterface {
  ApiFuture<UserModel> login({
    required String email,
    required String password,
  });
  ApiFuture<UserModel> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
  ApiFuture<void> forgotPassword({
    required String email,
  });

  ApiFuture<void> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
  });
}
