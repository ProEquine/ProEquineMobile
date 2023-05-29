import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/Printer.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/user/presentation/screens/user_type_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/widgets/custom_logo_widget.dart';
import '../../../nav_bar/domain/navbar_cubit.dart';
import '../widgets/register_header.dart';
import '../widgets/selectable_type_container.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({Key? key}) : super(key: key);

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final List<bool> _isSelected = [false, false, false, false];
  String? interest;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => BlocProvider.of<NavbarCubit>(context).onWillPop(context),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              RegistrationHeader(isThereBackButton: false),
              const CustomLogoWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Column(
                  children: [
                    SizedBox(
                      height: 11.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Let us know your interests",
                          style: AppStyles.registrationTitle),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SelectableTypeContainer(
                      label: 'Show Jumping',
                      index: 0,
                      isSelected: _isSelected[0],
                      onSelected: (bool value) {
                        _handleSelected(0, value);
                        interest = 'Show Jumping';
                        Print("Selected type $interest");
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SelectableTypeContainer(
                      label: 'Racing',
                      index: 1,
                      isSelected: _isSelected[1],
                      onSelected: (bool value) {
                        _handleSelected(1, value);
                        interest = 'Racing';
                        Print("Selected type $interest");
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SelectableTypeContainer(
                      label: 'Dressage',
                      index: 2,
                      isSelected: _isSelected[2],
                      onSelected: (bool value) {
                        _handleSelected(2, value);
                        interest = 'Dressage';
                        Print("Selected type $interest");
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SelectableTypeContainer(
                      label: 'Endurance',
                      index: 3,
                      isSelected: _isSelected[3],
                      onSelected: (bool value) {
                        _handleSelected(3, value);
                        interest = 'Endurance';
                        Print("Selected type $interest");
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: RebiButton(
                  backgroundColor:
                      interest != null ? AppColors.white : AppColors.formsLabel,
                  onPressed: () {
                    if (interest != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserTypeScreen(
                                    phone: AppSharedPreferences.userPhoneNumber,
                                    interest: interest,
                                  )));
                    } else {
                      RebiMessage.error(msg: 'Please select your interest',context: context);
                    }
                  },
                  child: const Text("Continue"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSelected(int index, bool value) {
    setState(() {
      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = false;
      }
      _isSelected[index] = value;
    });
  }
}
