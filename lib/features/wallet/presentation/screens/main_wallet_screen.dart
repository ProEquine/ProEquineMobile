import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/bank_transfer/data/all_bank_transfers_response_model.dart';
import 'package:proequine/features/bank_transfer/presentation/screens/bank_transfers_screen.dart';
import 'package:proequine/features/wallet/presentation/screens/card_deposit_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/widgets/custom_header.dart';
import '../widgets/all_transaction_widget.dart';
import '../widgets/payout_topup_widget.dart';
import '../widgets/wallet_card_widget.dart';

class MainWalletScreen extends StatefulWidget {
  const MainWalletScreen({Key? key}) : super(key: key);

  @override
  State<MainWalletScreen> createState() => _MainWalletScreenState();
}

class _MainWalletScreenState extends State<MainWalletScreen> {
  Account account = Account();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.h),
        child: CustomHeader(
          title: "Wallet".tra,
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
        ),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: WalletCardWidget(
                      bankAccountDetails: account,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CardAndBankWidget(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CardDepositScreen(
                                                type: 'Card')));
                              },
                              title: "Card".tra,
                              icon: AppIcons.cardIcon,
                              color: AppColors.whiteLight),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: CardAndBankWidget(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                             BankTransfersScreen()));
                              },
                              title: "Bank".tra,
                              icon: AppIcons.bankIcon,
                              color: AppColors.whiteLight),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Recent transactions".tra,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Color(0xFFC48636),
                          fontSize: 16,
                          fontFamily: 'Noto Sans',
                          fontWeight: FontWeight.w700,
                          height: 0.11,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: AllTransactionsWidget()),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
