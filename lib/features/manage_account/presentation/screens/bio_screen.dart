import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';

import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import 'package:intl/date_symbol_data_local.dart';

class BioScreen extends StatefulWidget {
  const BioScreen({super.key});

  @override
  State<BioScreen> createState() => _BioScreenState();
}

class _BioScreenState extends State<BioScreen> {
  late final TextEditingController bio;
  late final TextEditingController instagramLink;
  late final TextEditingController facebookLink;


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedGender;
  String? selectedState;

  @override
  void initState() {
    initializeDateFormatting();
    bio = TextEditingController();
    instagramLink = TextEditingController();
    facebookLink = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    bio.dispose();
    instagramLink.dispose();
    facebookLink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Bio & Social",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: false,
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Form(
              key: _formKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: kPadding),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 7),
                              child: RebiInput(

                                hintText: 'Bio'.tra,
                                controller: bio,

                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                                isOptional: false,
                                color: AppColors.formsLabel,
                                readOnly: false,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 13),
                                obscureText: false,
                                validator: (value) {
                                  return Validator.requiredValidator(
                                      bio.text);
                                },
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 7),
                              child: RebiInput(
                                hintText: 'Instagram'.tra,
                                controller: instagramLink,
                                prefixIcon: SvgPicture.asset(AppIcons.instagramIcon),
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                                isOptional: false,
                                color: AppColors.formsLabel,
                                readOnly: false,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 13),
                                obscureText: false,
                                validator: (value) {
                                  return Validator.requiredValidator(
                                      instagramLink.text);
                                },
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 7),
                              child: RebiInput(
                                hintText: 'Facebook'.tra,
                                controller: facebookLink,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                                prefixIcon: SvgPicture.asset(AppIcons.facebookIcon),
                                isOptional: false,
                                color: AppColors.formsLabel,
                                readOnly: false,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 13),
                                obscureText: false,
                                validator: (value) {
                                  return Validator.requiredValidator(
                                      facebookLink.text);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(kPadding),
                        child: RebiButton(
                          onPressed: () {},
                          child: const Text(
                            "Add",
                          ),
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
          },
        ),
      ),
    );
  }
}
