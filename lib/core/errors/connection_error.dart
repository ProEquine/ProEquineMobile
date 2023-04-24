import 'package:easy_localization/easy_localization.dart';

import 'base_error.dart';

class ConnectionError extends BaseError {
  String message = 'ConnectionError'.tr();

  @override
  List<Object> get props => [];
}
