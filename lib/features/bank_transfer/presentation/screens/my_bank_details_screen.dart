import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/secure_storage/secure_storage_helper.dart';
import 'package:proequine/core/widgets/custom_error_widget.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/bank_transfer/data/save_bank_account_request_model.dart';
import 'package:proequine/features/bank_transfer/domain/bank_transfer_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_input.dart';

class MyBankDetailsScreen extends StatefulWidget {

  const MyBankDetailsScreen({super.key});

  @override
  State<MyBankDetailsScreen> createState() => _MyBankDetailsScreenState();
}

class _MyBankDetailsScreenState extends State<MyBankDetailsScreen> {
  BankTransferCubit cubit = BankTransferCubit();
  TextEditingController bankName = TextEditingController();
  TextEditingController accountHolderName = TextEditingController();
  TextEditingController iban = TextEditingController();
  TextEditingController swiftCode = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    cubit.getBankAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var myCubit = context.watch<BankTransferCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Bank Details",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
        ),
      ),
      body: BlocBuilder<BankTransferCubit, BankTransferState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is GetBankAccountSuccessfully) {
            bankName.text=state.model!.bankName??'';
            swiftCode.text=state.model!.swiftCode??'';
            accountHolderName.text=state.model!.accountHolderName??'';
            iban.text=state.model!.iBAN??'';
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kPadding, vertical: 10),
                    child: RebiInput(
                      hintText: 'Bank Name',
                      controller: bankName,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      scrollPadding: const EdgeInsets.only(bottom: 100),
                      isOptional: false,
                      color: AppColors.formsLabel,
                      readOnly: false,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 13),
                      obscureText: false,
                      validator: (value) {
                        return Validator.requiredValidator(bankName.text);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kPadding, vertical: 10),
                    child: RebiInput(
                      hintText: 'Swift Code',
                      controller: swiftCode,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      scrollPadding: const EdgeInsets.only(bottom: 100),
                      isOptional: false,
                      color: AppColors.formsLabel,
                      readOnly: false,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 13),
                      obscureText: false,
                      validator: (value) {
                        return Validator.requiredValidator(swiftCode.text);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kPadding, vertical: 10),
                    child: RebiInput(
                      hintText: 'Account Holder Name',
                      controller: accountHolderName,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      scrollPadding: const EdgeInsets.only(bottom: 100),
                      isOptional: false,
                      color: AppColors.formsLabel,
                      readOnly: false,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 13),
                      obscureText: false,
                      validator: (value) {
                        return Validator.requiredValidator(
                            accountHolderName.text);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kPadding, vertical: 10),
                    child: RebiInput(
                      hintText: 'Iban',
                      controller: iban,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      scrollPadding: const EdgeInsets.only(bottom: 100),
                      isOptional: false,
                      color: AppColors.formsLabel,
                      readOnly: false,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 13),
                      obscureText: false,
                      validator: (value) {
                        return Validator.requiredValidator(iban.text);
                      },
                    ),
                  ),
                  Spacer(),
                  BlocConsumer<BankTransferCubit, BankTransferState>(
                    bloc: cubit,
                    listener: (context, state) {
                      if (state is SaveBankAccountError) {
                        RebiMessage.error(
                            msg: state.message!, context: context);
                      } else if (state is SaveBankAccountSuccessful) {
                        RebiMessage.success(
                            msg: state.message!, context: context);
                        Navigator.pop(context);
                        myCubit.getAllBankTransfers(limit: 100);
                      }
                    },
                    builder: (context, state) {
                      if (state is SaveBankAccountLoading) {
                        return const LoadingCircularWidget();
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPadding, vertical: 20),
                        child: RebiButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                {
                                  _onPressSaveBank();
                                }
                              } else {}
                            },
                            child: const Text("Save")),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          } else if (state is GetBankAccountError) {
            return CustomErrorWidget(onRetry: () {
              cubit.getBankAccount();
            });
          } else {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kPadding, vertical: 10),
                    child: RebiInput(
                      hintText: 'Bank Name',
                      controller: bankName,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      scrollPadding: const EdgeInsets.only(bottom: 100),
                      isOptional: false,
                      color: AppColors.formsLabel,
                      readOnly: false,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 13),
                      obscureText: false,
                      validator: (value) {
                        return Validator.requiredValidator(bankName.text);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kPadding, vertical: 10),
                    child: RebiInput(
                      hintText: 'Swift Code',
                      controller: swiftCode,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      scrollPadding: const EdgeInsets.only(bottom: 100),
                      isOptional: false,
                      color: AppColors.formsLabel,
                      readOnly: false,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 13),
                      obscureText: false,
                      validator: (value) {
                        return Validator.requiredValidator(swiftCode.text);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kPadding, vertical: 10),
                    child: RebiInput(
                      hintText: 'Account Holder Name',
                      controller: accountHolderName,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      scrollPadding: const EdgeInsets.only(bottom: 100),
                      isOptional: false,
                      color: AppColors.formsLabel,
                      readOnly: false,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 13),
                      obscureText: false,
                      validator: (value) {
                        return Validator.requiredValidator(
                            accountHolderName.text);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kPadding, vertical: 10),
                    child: RebiInput(
                      hintText: 'Iban',
                      controller: iban,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      scrollPadding: const EdgeInsets.only(bottom: 100),
                      isOptional: false,
                      color: AppColors.formsLabel,
                      readOnly: false,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 13),
                      obscureText: false,
                      validator: (value) {
                        return Validator.requiredValidator(iban.text);
                      },
                    ),
                  ),
                  Spacer(),
                  BlocConsumer<BankTransferCubit, BankTransferState>(
                    bloc: cubit,
                    listener: (context, state) {
                      if (state is SaveBankAccountError) {
                        RebiMessage.error(
                            msg: state.message!, context: context);
                      } else if (state is SaveBankAccountSuccessful) {
                        RebiMessage.success(
                            msg: state.message!, context: context);
                        Navigator.pop(context);
                        myCubit.getAllBankTransfers(limit: 100);
                      }
                    },
                    builder: (context, state) {
                      if (state is SaveBankAccountLoading) {
                        return const LoadingCircularWidget();
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPadding, vertical: 20),
                        child: RebiButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                {
                                  _onPressSaveBank();
                                }
                              } else {}
                            },
                            child: const Text("Save")),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          }

        },
      ),
    );
  }

  _onPressSaveBank() async {
    String? userId = await SecureStorage().getUserId();
    cubit.saveBankAccount(SaveBankAccountRequestModel(
        userId: int.parse(userId!),
        bankName: bankName.text,
        accountHolderName: accountHolderName.text,
        swiftCode: swiftCode.text,
        iBAN: iban.text));
  }
}

// late TextEditingController bankName;
// late TextEditingController accountHolderName;
// late TextEditingController iban;
// late TextEditingController swiftCode;
// @override
// void initState() {
//   bankName=TextEditingController(text: widget.account!.bankName??'');
//   accountHolderName=TextEditingController(text: widget.account!.accountHolderName??'');
//   iban=TextEditingController(text: widget.account!.iBAN??'');
//   swiftCode=TextEditingController(text: widget.account!.swiftCode??'');
//   super.initState();
// }
