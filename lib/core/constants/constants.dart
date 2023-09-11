import 'package:flutter/material.dart';

const appName = 'ProEquine';

// Languages
const defaultLanguage = 'ar';
const Map<String, Locale> languages = {
  'ar': Locale('ar'),
  'en': Locale('en'),
  // 'es':Locale('es'),
};

// Headers
const shimmerGradient = LinearGradient(
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
const HEADER_LANGUAGE = 'x-lang';
const HEADER_AUTH = 'authorization';
const DEVICE_ID = 'x-deviceid';
const HEADER_CONTENT_TYPE = 'Content-Type';
const HEADER_ACCEPT = 'accept';

// Notifications Channels
const NOTIFICATIONS_CHANNEL_ID = 'global-channel';
const NOTIFICATIONS_CHANNEL_TITLE = 'Global';
const NOTIFICATIONS_CHANNEL_DESCRIPTION = 'Global Channel';

const kPadding = 15.0;
const kAnimationDuration = Duration(milliseconds: 600);

Map<String, List<String>> cityData = {
  'Dubai': [
    'Dubai City',
    'Jebel Ali',
    'Al Barsha',
    'Deira',
    'Bur Dubai',
    'Jumeirah',
    'Downtown Dubai',
    'Dubai Marina',
    'Al Qusais',
    'Satwa',
    'Business Bay',
    'Al Quoz',
    'International City',
    'Dubai Silicon Oasis',
    'Palm Jumeirah',
    'Discovery Gardens',
    'Dubai Sports City',
    'Dubai Investment Park',
    'Al Nahda',
    'Al Jadaf',
  ],
  'Abu Dhabi Emirate': [
    'Abu Dhabi Island and Internal Islands City',
    'Abu Dhabi Municipality',
    'Al Ain City',
    'Al Ain Municipality',
    'Al Dhafra',
    'Al Shamkhah City',
    'Ar Ruways',
    'Bani Yas City',
    'Khalifah A City',
    'Musaffah',
    'Muzayriâ€˜',
    'Zayed City'
  ],
  'Sharjah Emirate': [
    'Sharjah City',
    'Adh Dhayd',
    'Al Batayih',
    'Al Hamriyah',
    'Al Madam',
    'Dhaid',
    ' Dibba Al Hesn',
    'Kalba',
    'Khawr FakkÄn',
    'Khor Fakkan',
    'Milehah',
    ' Murbaá¸©',
  ],
  'Ajman Emirate': [
    'Ajman',
    'Ajman City',
    'Manama',
    'Masfout',
  ],
  'Ras al-Khaimah': [
    'Ras Al Khaimah',
    'Ras Al Khaimah City',
  ],
  'Fujairah': [
    'Al Fujairah City',
    'Al Fujairah Municipality',
    'Dibba Al Fujairah Municipality',
    'Dibba Al-Fujairah',
    'Dibba Al-Hisn',
    'Reef Al Fujairah City',
  ],
  'Umm al-Quwain': ['Umm AL Quwain', 'Umm Al Quwain City']
};

const List<String> emiratesStates = [
  'Abu Dhabi Emirate',
  'Ajman Emirate',
  'Dubai',
  'Fujairah',
  'Ras al-Khaimah',
  'Sharjah Emirate',
  'Umm al-Quwain',
];
