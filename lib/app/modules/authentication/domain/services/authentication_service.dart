import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_task/app/modules/authentication/data/models/user_model.dart';
import 'package:tezda_task/app/modules/authentication/domain/services/interfaces/authentication_service_interface.dart';
import 'package:tezda_task/app/shared/functions/api_functions.dart';
import 'package:tezda_task/app/shared/helpers/classes/failures.dart';
import 'package:tezda_task/app/shared/helpers/firebase/firebase_providers.dart';

final authenticationServiceProvider =
    Provider<AuthenticationServiceInterface>((ref) {
  final auth = ref.read(authProvider);
  final firestore = ref.read(firestoreProvider);
  return AuthenticationService(auth: auth, firestore: firestore);
});

class AuthenticationService implements AuthenticationServiceInterface {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthenticationService({required this.auth, required this.firestore});
  @override
  ApiFuture<void> forgotPassword({required String email}) {
    return futureFunction(
      () async {
        await auth.sendPasswordResetEmail(email: email);
      },
    );
  }

  @override
  ApiFuture<UserModel> login({
    required String email,
    required String password,
  }) {
    return futureFunction(
      () async {
        final cred = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        final uid = cred.user!.uid;
        final user = await firestore.collection('users').doc(uid).get();
        return UserModel.fromMapAndUid(user.data()!, uid);
      },
    );
  }

  @override
  ApiFuture<UserModel> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) {
    return futureFunction(
      () async {
        final creds = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final uid = creds.user!.uid;
        log("uid from firebase $uid");

        await firestore.collection('users').doc(creds.user!.uid).set({
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
        });
        return UserModel(
          email: email,
          firstName: firstName,
          lastName: lastName,
          uid: uid,
        );
      },
    );
  }

  @override
  ApiFuture<void> updateUserProfile({
    required String uid,
    String? firstName,
    String? lastName,
    String? email,
  }) {
    return futureFunction(
          () async {
        final updateData = <String, dynamic>{};

        if (firstName != null) updateData['firstName'] = firstName;
        if (lastName != null) updateData['lastName'] = lastName;
        if (email != null) updateData['email'] = email;

        if (updateData.isNotEmpty) {
          await firestore.collection('users').doc(uid).update(updateData);
          log("User profile updated for UID: $uid");
        } else {
          throw const FailureResponse("No fields to update.");
        }
      },
    );
  }
}
