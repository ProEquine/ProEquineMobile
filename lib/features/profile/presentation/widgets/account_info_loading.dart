import 'package:flutter/material.dart';
import 'package:proequine/core/constants/constants.dart';
import '../../../../core/widgets/account_shimmer.dart';
import '../../../../core/widgets/header_text.dart';

const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFF323232),
    Color.fromRGBO(255, 255, 252, 0.2),
    Color(0xFF323232),
  ],
  stops: [
    0.1,
    0.5,
    0.9,
  ],
  begin: Alignment(-2.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.mirror,
);

class AccountInfoLoading extends StatelessWidget {
  final bool isLoading;

  const AccountInfoLoading({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      linearGradient: _shimmerGradient,
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kPadding, vertical: kPadding),
            child: SingleChildScrollView(
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderText("", "Account Information", true),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ShimmerLoading(
                        isLoading: isLoading,
                        child: SizedBox(
                          width: double.infinity,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              color: Color.fromRGBO(50, 50, 50, 1),
                            ),
                            width: double.infinity,
                            height: 45,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ShimmerLoading(
                        isLoading: isLoading,
                        child: SizedBox(
                          width: double.infinity,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              color: Color.fromRGBO(50, 50, 50, 1),
                            ),
                            width: double.infinity,
                            height: 45,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ShimmerLoading(
                        isLoading: isLoading,
                        child: SizedBox(
                          width: double.infinity,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              color: Color.fromRGBO(50, 50, 50, 1),
                            ),
                            width: double.infinity,
                            height: 45,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ShimmerLoading(
                        isLoading: isLoading,
                        child: SizedBox(
                          width: double.infinity,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              color: Color.fromRGBO(50, 50, 50, 1),
                            ),
                            width: double.infinity,
                            height: 45,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ShimmerLoading(
                        isLoading: isLoading,
                        child: SizedBox(
                          width: double.infinity,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              color: Color.fromRGBO(50, 50, 50, 1),
                            ),
                            width: double.infinity,
                            height: 45,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ShimmerLoading(
                        isLoading: isLoading,
                        child: SizedBox(
                          width: double.infinity,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              color: Color.fromRGBO(50, 50, 50, 1),
                            ),
                            width: double.infinity,
                            height: 45,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}