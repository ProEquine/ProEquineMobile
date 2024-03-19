import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/support/domain/support_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../support/data/support_request_model.dart';

void showContactSupportBottomSheet(
    {required BuildContext context,
    required TextEditingController inquiry,
    String? referenceNumber}) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    useSafeArea: false,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    builder: (BuildContext context) {
      SupportCubit cubit = SupportCubit();
      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
      return Wrap(children: [
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: 45.0.h,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: kPadding, left: kPadding, right: kPadding),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text("Contact Support".tra,
                            style: const TextStyle(
                              color: Color(0xFF090A0A),
                              fontSize: 17,
                              fontFamily: "din",
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text("Payment Concerns? We're Here for you".tra,
                          style: const TextStyle(
                            color: Color(0xFF090A0A),
                            fontSize: 16,
                            fontFamily: "din",
                            fontWeight: FontWeight.w700,
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text("Issue type".tra,
                              style: const TextStyle(
                                color: Color(0xFF090A0A),
                                fontSize: 13,
                                fontFamily: "din",
                                fontWeight: FontWeight.w700,
                              )),
                          const SizedBox(
                            width: 30,
                          ),
                          Text("Payment".tra,
                              style: const TextStyle(
                                color: AppColors.grey,
                                fontSize: 13,
                                fontFamily: "din",
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      RebiInput(
                        hintText:
                            "Detailed description of the issue or inquiry".tra,
                        controller: inquiry,
                        scrollPadding: const EdgeInsets.only(bottom: 100),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        maxLines: 5,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        isOptional: false,
                        color: AppColors.formsLabel,
                        readOnly: false,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                        obscureText: false,
                        validator: (value) {
                          return Validator.requiredValidator(inquiry.text);
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocConsumer<SupportCubit, SupportState>(
                        bloc: cubit,
                        listener: (context, state) {
                          if (state is ContactSupportError) {
                            RebiMessage.error(
                                msg: state.message!, context: context);
                          } else if (state is ContactSupportSuccessful) {
                            RebiMessage.success(
                                msg: state.message!, context: context);
                            Navigator.pop(context);
                          }
                        },
                        builder: (context, state) {
                          if (state is ContactSupportLoading) {
                            return const LoadingCircularWidget();
                          }
                          return RebiButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  cubit.contactSupport(
                                    CreateSupportRequestModel(
                                      applicableReference:
                                          referenceNumber ?? 'NA',
                                      subject: 'Issue',
                                      division: 'Payment',
                                      supportInquiry: inquiry.text,
                                      sourceIsApp: true,
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "Submit".tra,
                                style: const TextStyle(
                                  fontFamily: "din",
                                ),
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]);
    },
  );
}
