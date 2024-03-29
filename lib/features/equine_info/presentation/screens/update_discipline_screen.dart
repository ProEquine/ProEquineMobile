// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:proequine/core/utils/extensions.dart';
// import 'package:proequine/core/utils/rebi_message.dart';
// import 'package:proequine/core/widgets/loading_widget.dart';
// import 'package:proequine/core/widgets/rebi_button.dart';
// import 'package:proequine/features/equine_info/data/update_main_discipline_request_model.dart';
// import 'package:proequine/features/equine_info/domain/equine_info_cubit.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../core/constants/colors/app_colors.dart';
// import '../../../../core/constants/constants.dart';
// import '../../../../core/constants/routes/routes.dart';
// import '../../../../core/constants/thems/app_styles.dart';
// import '../../../../core/global_functions/global_statics_drop_down.dart';
// import '../../../../core/utils/Printer.dart';
// import '../../../../core/utils/validator.dart';
// import '../../../../core/widgets/custom_header.dart';
// import '../../../../core/widgets/drop_down_menu_widget.dart';
// import '../../../../core/widgets/rebi_input.dart';
// import '../../../manage_account/data/basic_account_management_route.dart';
// import '../widgets/disciplines_widget.dart';
//
// class UpdateMainDiscipline extends StatefulWidget {
//   String userDiscipline;
//
//   UpdateMainDiscipline({Key? key,
//     required this.userDiscipline,})
//       : super(key: key);
//
//   @override
//   State<UpdateMainDiscipline> createState() => _UpdateMainDisciplineState();
// }
//
// class _UpdateMainDisciplineState extends State<UpdateMainDiscipline> {
//   late final TextEditingController _feId;
//   late final TextEditingController _nationalId;
//   late final TextEditingController discipline;
//   late final TextEditingController disciplineId;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   EquineInfoCubit cubit=EquineInfoCubit();
//
//   String? selectedDiscipline;
//
//   @override
//   void initState() {
//     _feId = TextEditingController();
//     _nationalId = TextEditingController();
//     discipline = TextEditingController(text: widget.userDiscipline);
//     disciplineId = TextEditingController();
//     selectedDiscipline = widget.userDiscipline;
//
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _feId.dispose();
//     _nationalId.dispose();
//     disciplineId.dispose();
//     discipline.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(20.h),
//         child: CustomHeader(
//             title: "Main Discipline",
//             isThereBackButton: true,
//             isThereChangeWithNavigate: false,
//             isThereThirdOption: false),
//       ),
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraint) {
//             return Form(
//               key: _formKey,
//               child: SingleChildScrollView(
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(minHeight: constraint.maxHeight),
//                   child: IntrinsicHeight(
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding:
//                           const EdgeInsets.symmetric(horizontal: kPadding),
//                           child: Column(
//                             children: [
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text("Update Discipline",
//                                     style: AppStyles.mainTitle),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                     "in order to update your main discipline - you need to submit this form and wait for the request approval",
//                                     style: AppStyles.descriptions),
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               const Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text("Discipline",
//                                     style: AppStyles.profileBlackTitles),
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               DisciplinesWidget(
//                                 disciplineId: disciplineId,
//                                 discipline: discipline,
//                               ),
//                               Padding(
//                                 padding:
//                                 const EdgeInsets.symmetric(vertical: 7),
//                                 child: RebiInput(
//                                   hintText: 'National ID'.tra,
//                                   controller: _nationalId,
//                                   keyboardType: TextInputType.name,
//                                   textInputAction: TextInputAction.done,
//                                   isOptional: false,
//                                   color: AppColors.formsLabel,
//                                   readOnly: false,
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 20, vertical: 13),
//                                   obscureText: false,
//                                   validator: (value) {
//                                     return Validator.requiredValidator(
//                                         _nationalId.text);
//                                   },
//                                 ),
//                               ),
//                               Padding(
//                                 padding:
//                                 const EdgeInsets.symmetric(vertical: 7),
//                                 child: RebiInput(
//                                   hintText: 'FEI ID'.tra,
//                                   controller: _feId,
//                                   keyboardType: TextInputType.name,
//                                   textInputAction: TextInputAction.done,
//                                   isOptional: false,
//                                   color: AppColors.formsLabel,
//                                   readOnly: false,
//                                   contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 20, vertical: 13),
//                                   obscureText: false,
//                                   validator: (value) {
//                                     return Validator.requiredValidator(
//                                         _feId.text);
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Spacer(),
//                         Padding(
//                           padding:
//                           const EdgeInsets.symmetric(horizontal: kPadding),
//                           child: BlocConsumer<EquineInfoCubit, EquineInfoState>(
//                             bloc: cubit,
//                             listener: (context, state) {
//                              if(state is UpdateMainDisciplineSuccessful){
//                                Navigator.pushReplacementNamed(
//                                    context, successScreen,
//                                    arguments: BasicAccountManagementRoute(
//                                        type: 'manageAccount',
//                                        title:
//                                        "Main Discipline Updated Successfully"));
//                              }else if(state is UpdateMainDisciplineError){
//                                RebiMessage.error(msg: state.message!, context: context);
//                              }
//                             },
//                             builder: (context, state) {
//                               if(state is UpdateMainDisciplineLoading){
//                                 return const LoadingCircularWidget();
//                               }
//                               return RebiButton(
//                                 onPressed: () {
//
//                                   _onPressSubmit();
//                                 },
//                                 child: Text(
//                                   "Submit",
//                                   style: AppStyles.buttonStyle,
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//   _onPressSubmit(){
//     cubit.updateMainDiscipline(UpdateMainDisciplineRequestModel(
//       nationalId: _nationalId.text,
//       feiid: _feId.text,
//       disciplineTitle: discipline.text,
//     ));
//   }
// }
