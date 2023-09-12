import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../nav_bar/domain/navbar_cubit.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';
import '../../data/interests_request_model.dart';
import '../../domain/user_cubit.dart';
import '../widgets/register_header.dart';

class ChooseStableScreen extends StatefulWidget {
  const ChooseStableScreen({Key? key}) : super(key: key);

  @override
  State<ChooseStableScreen> createState() => _ChooseStableScreenState();
}

class _ChooseStableScreenState extends State<ChooseStableScreen> {
  final UserCubit cubit = UserCubit();
  List<DropdownMenuItem<String>> mainStable = [
    const DropdownMenuItem(
      value: "Sharjah Stable",
      child: Text("Sharjah"),
    ),
    const DropdownMenuItem(
      value: "Malath",
      child: Text("Malath"),
    ),
    const DropdownMenuItem(
      value: "Malath2",
      child: Text("Malath2"),
    ),
    const DropdownMenuItem(
      value: "Malath3",
      child: Text("Malath3"),
    ),
    const DropdownMenuItem(
      value: "Add Your Stable",
      child: Text("Add Your Stable"),
    ),
  ];

  String? selectedMainStable;
  String? selectedEmirate;
  late final TextEditingController _mainStableName;
  late final TextEditingController _mainStableLocation;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isChooseToAddStable = false;

  @override
  void initState() {
    AppSharedPreferences.firstTime = true;
    Print('AppSharedPreferences.getEnvType${AppSharedPreferences.getEnvType}');
    _mainStableLocation = TextEditingController();
    _mainStableName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _mainStableLocation.dispose();
    _mainStableName.dispose();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => BlocProvider.of<NavbarCubit>(context).onWillPop(context),
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraint) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          RegistrationHeader(isThereBackButton: false),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Chose Your main Stable",
                                      style: AppStyles.mainTitle),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      "This feature is available in UAE only , once its added we will update your profile ",
                                      style: AppStyles.descriptions),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: DropDownWidget(
                                    items: mainStable,
                                    selected: selectedMainStable,
                                    onChanged: (mainStable) {
                                      setState(() {
                                        selectedMainStable = mainStable;
                                        if (selectedMainStable ==
                                            'Add Your Stable') {
                                          isChooseToAddStable = true;
                                        } else {
                                          isChooseToAddStable = false;
                                        }
                                        Print(
                                            'selected main stable $selectedMainStable');
                                      });
                                    },
                                    validator: (value) {
                                      // return Validator.requiredValidator(selectedNumber);
                                    },
                                    hint: 'Choose Your Stable',
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Visibility(
                                  visible: isChooseToAddStable,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Add Your Stable ",
                                        style: AppStyles.mainTitle2),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Visibility(
                                  visible: isChooseToAddStable,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        "in order to update your main discipline - you need to submit this form and wait for the request approval",
                                        style: AppStyles.descriptions),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Visibility(
                                  visible: isChooseToAddStable,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 7),
                                    child: RebiInput(
                                      hintText: 'Stable Name'.tra,
                                      controller: _mainStableName,
                                      scrollPadding:
                                          const EdgeInsets.only(bottom: 100),
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.done,
                                      autoValidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      isOptional: false,
                                      onChanged: (value){
                                        setState(() {

                                        });
                                      },
                                      color: AppColors.formsLabel,
                                      readOnly: false,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 13),
                                      obscureText: false,
                                      validator: (value) {
                                        return Validator.requiredValidator(
                                            _mainStableName.text);
                                      },
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isChooseToAddStable,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 7),
                                    child: RebiInput(
                                      hintText: 'Location'.tra,
                                      controller: _mainStableLocation,
                                      scrollPadding:
                                          const EdgeInsets.only(bottom: 100),
                                      keyboardType: TextInputType.url,
                                      textInputAction: TextInputAction.done,
                                      autoValidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      isOptional: false,
                                      color: AppColors.formsLabel,
                                      readOnly: false,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 13),
                                      obscureText: false,
                                      validator: (value) {
                                        return Validator.requiredValidator(
                                            _mainStableLocation.text);
                                      },
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: isChooseToAddStable,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 7),
                                    child: DropDownWidget(
                                      items: emirate,
                                      selected: selectedEmirate,
                                      onChanged: (selectedEmi) {
                                        setState(() {
                                          selectedEmirate = selectedEmi;
                                          Print(
                                              'selected Emirate $selectedEmirate');
                                        });
                                      },
                                      validator: (value) {
                                        // return Validator.requiredValidator(selectedNumber);
                                      },
                                      hint: 'Emirate',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: _buildChooseStableConsumer(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _buildChooseStableConsumer() {
    return BlocConsumer<UserCubit, UserState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is SelectInterestsLoading) {
            return const LoadingCircularWidget();
          } else if (state is SelectInterestsError) {
            RebiMessage.error(msg: state.message!, context: context);
          }
          {
            return RebiButton(
              backgroundColor: (selectedMainStable != null &&
                          selectedMainStable != 'Add Your Stable') ||
                      (selectedEmirate != null &&
                          _mainStableName.text.isNotEmpty &&
                          _mainStableLocation.text.isNotEmpty)
                  ? AppColors.yellow
                  : AppColors.formsLabel,
              onPressed: () {
                if ((selectedMainStable != null&&
                    selectedMainStable != 'Add Your Stable') ||
                    (selectedEmirate != null &&
                        _mainStableName.text.isNotEmpty &&
                        _mainStableLocation.text.isNotEmpty)) {
                  _onPressConfirm();
                } else {
                  RebiMessage.error(
                      msg: 'Please select your main stable', context: context);
                }
              },
              child: const Text("Next"),
            );
          }
        },
        listener: (context, state) {
          // if (state is SelectInterestsSuccessful) {
          //   AppSharedPreferences.typeSelected = true;
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => const BottomNavigation()));
          // } else if (state is SelectInterestsError) {
          //   RebiMessage.error(msg: state.message!, context: context);
          // }
        });
  }

  _onPressConfirm() {
    Print("selected location ${_mainStableLocation.text}");
    Print("selected main stable ${_mainStableName.text}");
    Print("selected emirate $selectedEmirate");
    Print("selected main $selectedMainStable");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const BottomNavigation()));
    // return cubit
    //   ..interests(InterestsRequestModel(
    //     phoneNumber: AppSharedPreferences.userPhoneNumber,
    //     interest: 'interest',
    //     type: 'userType',
    //   ));
  }
}
