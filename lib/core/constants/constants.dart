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

Map<String, List<String>> places = {
  "All": [
    'Flopster beach Ghantoot',
    'Dubai Polo & Equestrian Club',
    'Sustainable City Equestrian Club',
    'Emirates Equestrian Centre',
    'Desert Palm Equestrian Centre',
    ' Ambition Equestrian Club',
    'Al Ruwayyah Private Livery',
    'Millennium Equestrian & Racing Club',
    'Furusiyya Equestrian Club',
    'Nine Valleys Stable',
    ' Dubai Equine Hospital',
    'AL Marmoom Equine Hospital',
    'Mangroves beach UAQ',
    'Al Ruwayyah Private Livery',
    'Ajman Equestrian Club',
    'Fujairah Shooting and Equestrian Club',
    'Sharjah Equestrian and Racing Club',
    ' Sharjah Club Quarantine',
    'Malath Paddock Paradise',
    'SERC Riding School',
    'Alhawajer Stud',
    'Sharjah Equine Hospital',
    'Equine Hydrotherapy Center',
    'Ghantoot Racing & Polo Club',
    'Abu Dhabi Equestrian Club',
    'Al Forsan International Sports Resort',
    'Al Wathba Stable',
    'Al Ain Equestrian Shooting and Golf Club',
    'Al Bahiya Equestrian Club',
    'Butheeb Equestrian Acadmey',
    'Dhabian Equestrian Club and Sports Academy',
    'Mandara Equestrian Club',
  ],
  "Dubai": [
    'Flopster beach Ghantoot',
    'Dubai Polo & Equestrian Club',
    'Sustainable City Equestrian Club',
    'Emirates Equestrian Centre',
    'Desert Palm Equestrian Centre',
    ' Ambition Equestrian Club',
    'Al Ruwayyah Private Livery',
    'Millennium Equestrian & Racing Club',
    'Furusiyya Equestrian Club',
    'Nine Valleys Stable',
    ' Dubai Equine Hospital',
    'AL Marmoom Equine Hospital',
  ],
  "Quwain": [
    'Mangroves beach UAQ',
    'Malath Paddock Paradise',
  ],
  "Ajman": [
    'Ajman Equestrian Club',
  ],
  "Fujairah": [
    'Fujairah Shooting and Equestrian Club',
  ],
  "Sharjah": [
    'Sharjah Equestrian and Racing Club',
    ' Sharjah Club Quarantine',
    'SERC Riding School',
    'Alhawajer Stud',
    'Sharjah Equine Hospital',
    'Equine Hydrotherapy Center',
  ],
  "Abu Dhabi": [
    'Ghantoot Racing & Polo Club',
    'Abu Dhabi Equestrian Club',
    'Al Forsan International Sports Resort',
    'Al Wathba Stable',
    'Al Ain Equestrian Shooting and Golf Club',
    'Al Bahiya Equestrian Club',
    'Butheeb Equestrian Acadmey',
    'Dhabian Equestrian Club and Sports Academy',
    'Mandara Equestrian Club',
  ],
};

List<String> placesList = [
  'Add New Place',
  'Flopster beach Ghantoot',
  'Dubai Polo & Equestrian Club',
  'Sustainable City Equestrian Club',
  'Emirates Equestrian Centre',
  'Desert Palm Equestrian Centre',
  ' Ambition Equestrian Club',
  'Al Ruwayyah Private Livery',
  'Millennium Equestrian & Racing Club',
  'Furusiyya Equestrian Club',
  'Nine Valleys Stable',
  ' Dubai Equine Hospital',
  'AL Marmoom Equine Hospital',
  'Mangroves beach UAQ',
  'Al Ruwayyah Private Livery',
  'Ajman Equestrian Club',
  'Fujairah Shooting and Equestrian Club',
  'Sharjah Equestrian and Racing Club',
  ' Sharjah Club Quarantine',
  'Malath Paddock Paradise',
];
List<String> stables = [
  'Add Your Stable',
  'Dubai Polo & Equestrian Club',
  'Sustainable City Equestrian Club',
  'Emirates Equestrian Centre',
  'Desert Palm Equestrian Centre',
  ' Ambition Equestrian Club',
  'Al Ruwayyah Private Livery',
  'Millennium Equestrian & Racing Club',
  'Furusiyya Equestrian Club',
  'Nine Valleys Stable',
  ' Dubai Equine Hospital',
  'AL Marmoom Equine Hospital',
  'Mangroves beach UAQ',
  'Al Ruwayyah Private Livery',
  'Ajman Equestrian Club',
  'Fujairah Shooting and Equestrian Club',
  'Sharjah Equestrian and Racing Club',
  ' Sharjah Club Quarantine',
  'Malath Paddock Paradise',
];
List<String> interests = [
  'Show Jumping',
  'Endurance',
  'Dressage',
  'Flat race',
  'Eventing',
  'Tent Pegging',
  'Arabian Show',
  'Polo',
  'Cross Country',
];
Map<String, int> interestMap = {
  for (var interest in interests) interest: interests.indexOf(interest)
};
