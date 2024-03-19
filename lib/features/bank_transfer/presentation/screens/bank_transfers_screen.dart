import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:proequine/core/utils/secure_storage/secure_storage_helper.dart';
import 'package:proequine/core/widgets/global_bottom_sheet.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/bank_transfer/domain/bank_transfer_cubit.dart';
import 'package:proequine/features/bank_transfer/presentation/screens/bank_transfer_process_screen.dart';
import 'package:proequine/features/bank_transfer/presentation/screens/edit_transfer_summary_screen.dart';
import 'package:proequine/features/bank_transfer/presentation/screens/my_bank_details_screen.dart';
import 'package:proequine/features/bank_transfer/presentation/widgets/bank_transfer_widget.dart';
import 'package:proequine/features/support/presentation/widgets/support_loading_shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/divider.dart';
import 'bank_deposit_screen.dart';

class BankTransfersScreen extends StatefulWidget {
  const BankTransfersScreen({super.key});

  @override
  State<BankTransfersScreen> createState() => _BankTransfersScreenState();
}

class _BankTransfersScreenState extends State<BankTransfersScreen> {
  @override
  void initState() {
    context.read<BankTransferCubit>().getAllBankTransfers(limit: 1000);
    super.initState();
  }

  BankTransferCubit cubit = BankTransferCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Bank Transfer",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          isItShowOptionBottomSheet: true,
          onPressThirdOption: () {
            showGlobalBottomSheet(
                context: context,
                title: "Banking with PE",
                content: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kPadding, vertical: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BankTransferProcessScreen()));
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Bank Transfer Process"),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kPadding, vertical: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MyBankDetailsScreen()));
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("My Bank Details"),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(height: 40,),
                  ],
                ));
          },
        ),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: BlocBuilder<BankTransferCubit, BankTransferState>(
              // bloc: cubit,
              builder: (context, state) {
                if (state is GetAllBankTransfersSuccessful) {
                  String formatDate(DateTime date) {
                    // Define the date format
                    final dateFormat = DateFormat("MMMM d, yyyy - hh:mm a");
                    // Format the date
                    final formattedDate = dateFormat.format(date);
                    return formattedDate;
                  }

                  if (state.count == 0) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 200,
                            ),
                            Center(
                                child:
                                    SvgPicture.asset(AppIcons.emptyTransfers)),
                            const SizedBox(
                              height: 100,
                            ),
                            const Text(
                              'It seems you havent initiated any transfers yet',
                              style: TextStyle(
                                color: Color(0xFF232F39),
                                fontSize: 28.26,
                                fontFamily: 'Noto Sans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadding),
                              child: RebiButton(
                                  onPressed: () async {
                                    String? userId =
                                        await SecureStorage().getUserId();
                                    if (context.mounted) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BankDepositScreen(
                                                    userId: int.parse(userId!),
                                                  )));
                                    }
                                  },
                                  child: const Text("New Transfer")),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: state.count,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kPadding, vertical: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    if (state.responseModel[index].status !=
                                        'Pending') {
                                      showGlobalBottomSheet(
                                          context: context,
                                          title: "Bank transfer Details",
                                          content: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: kPadding,
                                                vertical: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                                border: Border.all(
                                                  color: AppColors.borderColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: kPadding,
                                                        vertical: 20),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Reference Number",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF6B7280),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'notosan'),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "Include it in your transfer notes",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF6B7280),
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'notosan'),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              state
                                                                  .responseModel[
                                                                      index]
                                                                  .referenceNumber
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0xFF232F39),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'notosan'),
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            InkWell(
                                                                onTap:
                                                                    () async {
                                                                  await Clipboard.setData(ClipboardData(
                                                                      text: state
                                                                          .responseModel[
                                                                              index]
                                                                          .referenceNumber
                                                                          .toString()));

                                                                  // copied successfully
                                                                  RebiMessage.success(
                                                                      msg:
                                                                          "copied successfully",
                                                                      context:
                                                                          context);
                                                                },
                                                                child: SvgPicture
                                                                    .asset(AppIcons
                                                                        .copyIcon)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.all(2.0),
                                                        child: CustomDivider()),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Date & Time",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF6B7280),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  'notosan'),
                                                        ),
                                                        Text(
                                                          formatDate(DateTime
                                                              .parse(state
                                                                  .responseModel[
                                                                      index]
                                                                  .createdAt!)),
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xFF232F39),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  'notosan'),
                                                        ),
                                                      ],
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.all(2.0),
                                                        child: CustomDivider()),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Status",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF6B7280),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  'notosan'),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          state
                                                              .responseModel[
                                                                  index]
                                                              .status!,
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xFF232F39),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  'notosan'),
                                                        ),
                                                      ],
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.all(2.0),
                                                        child: CustomDivider()),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Transfer Type",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF6B7280),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  'notosan'),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          state
                                                              .responseModel[
                                                                  index]
                                                              .transferType!,
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xFF232F39),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  'notosan'),
                                                        ),
                                                      ],
                                                    ),
                                                    const Padding(
                                                        padding:
                                                            EdgeInsets.all(2.0),
                                                        child: CustomDivider()),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Amount",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF6B7280),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  'notosan'),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          '${state.responseModel[index].amount.toString()} AED',
                                                          style: const TextStyle(
                                                              color: AppColors
                                                                  .gold,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  'notosan'),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditTransferSummaryScreen(
                                                      responseModel:
                                                          state.responseModel[
                                                              index])));
                                    }
                                  },
                                  child: BankTransferWidget(
                                    amount: state.responseModel[index].amount
                                        .toString(),
                                    date: formatDate(DateTime.parse(
                                        state.responseModel[index].createdAt!)),
                                    status: state.responseModel[index].status ??
                                        'Pending',
                                    type:
                                        state.responseModel[index].transferType,
                                    referenceNumber: state
                                        .responseModel[index].referenceNumber,
                                  ),
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 80,
                        ),
                        Spacer(),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: RebiButton(
                              onPressed: () async {
                                String? userId =
                                    await SecureStorage().getUserId();
                                if (context.mounted) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BankDepositScreen(
                                                userId: int.parse(userId!),
                                              )));
                                }
                              },
                              child: const Text("New Transfer")),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    );
                  }
                }
                if (state is GetAllBankTransfersError) {
                  return CustomErrorWidget(onRetry: () {
                    cubit.getAllBankTransfers(limit: 100);
                  });
                } else if (state is GetAllBankTransfersLoading) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: SupportLoadingWidget()),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        );
      }),
    );
  }
}
