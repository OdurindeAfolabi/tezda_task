import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tezda_task/app/modules/authentication/presentation/pages/forgot_password_page.dart';
import 'package:tezda_task/app/modules/authentication/presentation/pages/login_page.dart';
import 'package:tezda_task/app/modules/profile/presentation/providers/profile_provider.dart';
import 'package:tezda_task/app/shared/extensions/context_extension.dart';
import 'package:tezda_task/app/shared/functions/app_functions.dart';
import 'package:tezda_task/app/shared/helpers/classes/preferences/preferences.dart';
import 'package:tezda_task/app/shared/presentation/widgets/custom_button.dart';
import 'package:tezda_task/app/shared/presentation/widgets/custom_textfield.dart';
import 'package:tezda_task/app/shared/presentation/widgets/tezda_task_app_bar.dart';
import 'package:tezda_task/core/framework/theme/colors/app_theme_provider.dart';
import 'package:tezda_task/core/navigation/navigator.dart';

import '../../../../shared/functions/string_functions.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String email = "";
  String firstName = "";
  String lastName = "";
  @override
  void initState() {
    onInit(
          () {
            final userModel = getUser()!;
            setState(() {
              email = userModel.email;
              firstName = userModel.firstName;
              lastName = userModel.lastName;
              firstNameController.text = firstName;
              lastNameController.text = lastName;
              emailController.text = email;
            });

      },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final colors = ref.read(appThemeProvider).colors;
    log(firstName);
    return Scaffold(
      backgroundColor: colors.alwaysBlack,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const tezda_taskAppBar(title: "Profile"),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              headerText: "First name",
                              readOnly: false,
                              onChanged: (value) {
                                setState(() {
                                  firstName = value.trim();
                                });
                              },
                              textEditingController: firstNameController,
                              // textEditingController: TextEditingController(
                              //   text: userModel.firstName,
                              // ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomTextField(
                              headerText: "Last name",
                              // readOnly: true,
                              onChanged: (value) {
                                setState(() {
                                  lastName = value.trim();
                                });
                              },
                              textEditingController: lastNameController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        headerText: "Email",
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                          setState(() {});
                        },
                        validator: (value) {
                          return isValidEmailAddress(value)
                              ? null
                              : "Invalid email address";
                        },
                        // readOnly: true,
                        textEditingController: emailController,
                      ),

                      const Gap(24),
                      CustomButton(
                        text: "Update",
                        key: const Key("update_button"),
                        onPressed: () {
                          final notifier = ref.read(profileProvider.notifier);
                          notifier.updateUserProfile(
                            email: email,
                            firstName: firstName,
                            lastName: lastName,
                            onSuccess: (userModel) {
                              context.showSuccess("Profile updated successfully");
                            },
                          );
                        },
                        validator: () {
                          return isValidEmailAddress(email) && firstName.isNotEmpty &&  lastName.isNotEmpty;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: "Logout",
                key: const Key("logoutButton"),
                onPressed: () {
                  Preferences.clear();
                  pushToAndClearStack(context, const LoginPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
