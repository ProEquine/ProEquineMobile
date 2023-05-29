import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/constants/routes/routes.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/profile/data/update_email_route.dart';
import 'package:proequine/features/user/data/update_email_request_model.dart';
import 'package:proequine/features/user/domain/user_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/header_text.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';

class UpdateEmailScreen extends StatelessWidget {
  String previousEmail;

  UpdateEmailScreen({Key? key, required this.previousEmail}) : super(key: key);

  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserCubit cubit = UserCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Update Email",
          isThereBackButton: true,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: RebiInput(
                hintText: 'New email'.tra,
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                isOptional: false,
                color: AppColors.formsLabel,
                readOnly: false,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                obscureText: false,
                validator: (value) {
                  return Validator.emailValidator(_email.text);
                },
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(kPadding),
              child: BlocConsumer<UserCubit, UserState>(
                bloc: cubit,
                builder: (context, state) {
                  if (state is UpdateMailLoading) {
                    return LoadingCircularWidget();
                  }
                  return RebiButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          onSendMail();
                        } else {}
                      },
                      child: const Text("Update"));
                },
                listener: (context, state) {
                  if (state is UpdateMailSuccessful) {
                    Navigator.pushReplacementNamed(context, verifyUpdateEmail,
                        arguments: UpdateEmailRoute(
                            previousEmail: previousEmail,
                            newEmail: _email.text));
                  } else if (state is UpdateMailError) {
                    RebiMessage.error(msg: state.message!,context: context);
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  onSendMail() {
    return cubit.updateMail(UpdateMailRequestModel(
      newEmail: _email.text,
    ));
  }
}
