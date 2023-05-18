import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/profile/domain/profile_cubit.dart';
import 'package:proequine/features/profile/presentation/screens/change_password_screen.dart';
import 'package:proequine/features/profile/presentation/screens/update_email_screen.dart';
import 'package:proequine/features/profile/presentation/screens/update_phone_screen.dart';
import 'package:proequine/features/profile/presentation/widgets/account_info_loading.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/headerText.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/success_state_widget.dart';

class AccountInfoScreen extends StatefulWidget {
  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  final TextEditingController _currentPassword = TextEditingController();

  final TextEditingController _preferences = TextEditingController();

  final TextEditingController _discipline = TextEditingController();

  final TextEditingController name = TextEditingController(text: "Bahaa Soubh");

  final TextEditingController email =
      TextEditingController(text: "bahaa.s@input.ae");

  final TextEditingController phone =
      TextEditingController(text: "+971545049937");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ProfileCubit cubit=ProfileCubit();
  @override
  void initState() {
   context.read<ProfileCubit>().getUser(AppSharedPreferences.userPhoneNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "",
          isThereBackButton: true,
        ),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return BlocConsumer<ProfileCubit, ProfileState>(
          bloc: cubit..getUser(AppSharedPreferences.userPhoneNumber),
          listener: (context, state) {},
          builder: (context, state) {
            if(state is GetUserLoading){
              return const AccountInfoLoading(
                isLoading: true,
              );
            }else if (state is GetUserSuccessful){
              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: kPadding),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                      BoxConstraints(minHeight: constraint.maxHeight - 50.0),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeaderText("Profile", "Account Information", true),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: RebiInput(
                                labelText: 'Full Name'.tra,
                                controller: name,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                                autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                                isOptional: false,
                                color: AppColors.formsLabel,
                                readOnly: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 13),
                                obscureText: false,
                                validator: (value) {
                                  // return Validator.requiredValidator(name.text);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: RebiInput(
                                labelText: 'Email'.tra,
                                controller: email,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateEmailScreen()));
                                },
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                                isOptional: false,
                                color: AppColors.formsLabel,
                                readOnly: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 13),
                                obscureText: false,
                                validator: (value) {
                                  // return Validator.emailValidator(email.text);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: RebiInput(
                                labelText: 'Phone'.tra,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdatePhoneScreen()));
                                },
                                controller: phone,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.done,
                                autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                                isOptional: false,
                                color: AppColors.formsLabel,
                                readOnly: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 13),
                                obscureText: false,
                                validator: (value) {
                                  // return Validator.phoneValidator(phone.text);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: RebiInput(
                                labelText: 'Reset Password'.tra,
                                controller: _currentPassword,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangePasswordScreen()));
                                },
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                                isOptional: false,
                                color: AppColors.formsLabel,
                                readOnly: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 13),
                                validator: (value) {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: RebiInput(
                                labelText: 'Preferences'.tra,
                                controller: _preferences,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                                autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                                isOptional: false,
                                color: AppColors.formsLabel,
                                readOnly: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 13),
                                obscureText: false,
                                validator: (value) {
                                  // return Validator.requiredValidator(name.text);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: RebiInput(
                                labelText: 'Discipline'.tra,
                                controller: _discipline,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                                autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                                isOptional: false,
                                color: AppColors.formsLabel,
                                readOnly: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 13),
                                obscureText: false,
                                validator: (value) {
                                  // return Validator.requiredValidator(name.text);
                                },
                              ),
                            ),
                            const Spacer(),
                            RebiButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SuccessStateScreen(
                                                title:
                                                "Profile Updated Successfully",
                                              )));
                                },
                                child: const Text("Update")),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } return Container();

          },
        );
      }),
    );
  }
}
