import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/features/home/presentation/screens/create_export_screen.dart';
import 'package:proequine/features/home/presentation/screens/create_import_screen.dart';
import 'package:proequine/features/home/presentation/screens/create_trip_screen.dart';
import 'package:proequine/features/home/presentation/screens/media_list_screen.dart';
import 'package:proequine/features/home/presentation/screens/shows_screen.dart';
import 'package:proequine/features/home/presentation/widgets/service_widget.dart';
import 'package:proequine/features/home/presentation/widgets/shipping_widget.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../widgets/home_cardfull.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isScrolled = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset > 30) {
        if (!isScrolled) {
          setState(() {
            isScrolled = true;
          });
        }
      } else {
        if (isScrolled) {
          setState(() {
            isScrolled = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MediaQuery(
        data: const MediaQueryData(
            viewInsets: EdgeInsets.only(top: 100, bottom: 0)),
        child: CupertinoPageScaffold(
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                CupertinoSliverNavigationBar(
                  automaticallyImplyLeading: false,
                  border: Border(
                      bottom: BorderSide(
                          width: 1.0,
                          color: isScrolled
                              ? AppColors.borderColor
                              : Colors.transparent)),
                  alwaysShowMiddle: false,
                  padding: const EdgeInsetsDirectional.only(bottom: 1),
                  backgroundColor: AppColors.backgroundColorLight,
                  largeTitle: SvgPicture.asset(
                    AppIcons.proEquineLight,
                    alignment: Alignment.centerLeft,
                    height: 30,
                    width: 40,
                    fit: BoxFit.contain,
                  ),
                  middle: SvgPicture.asset(
                    AppIcons.proEquineLight,
                    height: 20,
                    width: 30,
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
                    ),
                    const HomeCardFull(),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Transportation',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ServiceWidget(
                              image: AppImages.local,
                              title: 'Local',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CreateTripScreen()));
                              },
                            ),
                            ServiceWidget(
                              image: AppImages.hospital,
                              title: 'Hospital',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CreateTripScreen(
                                              type: 'hospital',
                                            )));
                              },
                            ),
                            // const EventComingSoon(),
                            ServiceWidget(
                              image: AppImages.shows,
                              isItDisable: false,
                              title: 'Shows',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ShowsScreen(type: "type")));
                              },
                            ),
                          ],
                        )),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        'Shipping',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        ShippingWidget(
                          image: AppImages.export,
                          title: 'Import',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateImportScreen()));
                          },
                        ),
                        const SizedBox(
                          width: 26,
                        ),
                        ShippingWidget(
                          image: AppImages.import,
                          title: 'Export',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateExportScreen()));
                          },
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        'Media',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MediaListScreen(type: "Media Services")));
                      },
                      child: Image.asset(AppImages.mediaPics),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 7),
                      child: Text(
                        'Photos and videos ',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 14,
                          fontFamily: 'notosan',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
