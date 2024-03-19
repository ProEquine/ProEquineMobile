import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/divider.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/bank_transfer/data/create_bank_transfer_response_model.dart';
import 'package:proequine/features/bank_transfer/domain/bank_transfer_cubit.dart';
import 'package:proequine/features/bank_transfer/presentation/widgets/proequine_bank_details_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/widgets/custom_header.dart';

class TransferSummaryScreen extends StatefulWidget {
  final CreateBankTransferResponseModel responseModel;

  const TransferSummaryScreen({super.key, required this.responseModel});

  @override
  State<TransferSummaryScreen> createState() => _TransferSummaryScreenState();
}

class _TransferSummaryScreenState extends State<TransferSummaryScreen> {
  BankTransferCubit cubit = BankTransferCubit();

  String formatDate(DateTime date) {
    // Define the date format
    final dateFormat = DateFormat("MMMM d, yyyy - hh:mm a");
    // Format the date
    final formattedDate = dateFormat.format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    var myCubit = context.watch<BankTransferCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.h),
        child: CustomHeader(
          title: "Transfer Summary".tra,
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
        ),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFDFD9C9)),
                        color: AppColors.white,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(AppIcons.exclaimationMark),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "We’re still waiting for your bank transfer",
                            style: TextStyle(
                                color: AppColors.backgroundColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFDFD9C9)),
                        color: AppColors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              "AED ${widget.responseModel.amount}",
                              style: const TextStyle(
                                  color: AppColors.gold,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              formatDate(DateTime.parse(
                                  widget.responseModel.createdAt!)),
                              style: const TextStyle(
                                color: Color(0xFF232F39),
                                fontSize: 12.0,
                                fontFamily: 'Noto Sans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const CustomDivider(),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.responseModel.transferType!,
                            style: const TextStyle(
                              color: Color(0xFF232F39),
                              fontSize: 12.0,
                              fontFamily: 'Noto Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFDFD9C9)),
                        color: AppColors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Reference Number",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: AppColors.formsHintFontLight,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Include it in your transfer notes",
                                    style: TextStyle(
                                        color: AppColors.backgroundColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.responseModel.referenceNumber
                                        .toString(),
                                    style: const TextStyle(
                                        color: Color(0xFF232F39),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'notosan'),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        await Clipboard.setData(ClipboardData(
                                            text: widget
                                                .responseModel.referenceNumber
                                                .toString()));

                                        // copied successfully
                                        RebiMessage.success(
                                            msg: "copied successfully",
                                            context: context);
                                      },
                                      child:
                                          SvgPicture.asset(AppIcons.copyIcon)),
                                ],
                              ),
                            ],
                          ),
                          const CustomDivider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Status",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: AppColors.formsHintFontLight,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                              Text(
                                widget.responseModel.status.toString(),
                                style: const TextStyle(
                                    color: Color(0xFF232F39),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'notosan'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPadding),
                    child: Text(
                      "ProEquine Bank Account",
                      style: TextStyle(
                          color: AppColors.gold,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const ProEquineBankDetailsWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding),
                    child: RebiButton(
                        backgroundColor: AppColors.grey,
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          myCubit.getAllBankTransfers(limit: 1000);
                        },
                        child: const Text("I'll do later")),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<BankTransferCubit, BankTransferState>(
                    bloc: cubit,
                    listener: (context, state) {
                      if (state is PushTransferSuccessfully) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        myCubit.getAllBankTransfers(limit: 1000);
                      } else if (state is PushTransferError) {
                        RebiMessage.error(
                            msg: state.message!, context: context);
                      }
                    },
                    builder: (context, state) {
                      if (state is PushTransferLoading) {
                        return const LoadingCircularWidget();
                      } else {
                        return Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: RebiButton(
                              onPressed: () {
                                _onPushTransfer(widget.responseModel.id!);
                              },
                              child: const Text("I’ve made the transfer")),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
  _onPushTransfer(int id) {
    cubit.pushTransfer(id);
  }
}
