import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/date_symbols.dart' as intl;
import 'package:intl/date_symbol_data_custom.dart' as date_symbol_data_custom;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const kuLocaleDatePatterns = {
  'd': 'd', // DAY
  'E': 'ccc', // ABBR_WEEKDAY
  'EEEE': 'cccc', // WEEKDAY
  'LLL': 'LLL', // ABBR_STANDALONE_MONTH
  'LLLL': 'LLLL', // STANDALONE_MONTH
  'M': 'L', // NUM_MONTH
  'Md': 'd/‏M', // NUM_MONTH_DAY
  'MEd': 'EEE، d/M', // NUM_MONTH_WEEKDAY_DAY
  'MMM': 'LLL', // ABBR_MONTH
  'MMMd': 'd MMM', // ABBR_MONTH_DAY
  'MMMEd': 'EEE، d MMM', // ABBR_MONTH_WEEKDAY_DAY
  'MMMM': 'LLLL', // MONTH
  'MMMMd': 'd MMMM', // MONTH_DAY
  'MMMMEEEEd': 'EEEE، d MMMM', // MONTH_WEEKDAY_DAY
  'QQQ': 'QQQ', // ABBR_QUARTER
  'QQQQ': 'QQQQ', // QUARTER
  'y': 'y', // YEAR
  'yM': 'M‏/y', // YEAR_NUM_MONTH
  'yMd': 'd‏/M‏/y', // YEAR_NUM_MONTH_DAY
  'yMEd': 'EEE، d/‏M/‏y', // YEAR_NUM_MONTH_WEEKDAY_DAY
  'yMMM': 'MMM y', // YEAR_ABBR_MONTH
  'yMMMd': 'd MMM y', // YEAR_ABBR_MONTH_DAY
  'yMMMEd': 'EEE، d MMM y', // YEAR_ABBR_MONTH_WEEKDAY_DAY
  'yMMMM': 'MMMM y', // YEAR_MONTH
  'yMMMMd': 'd MMMM y', // YEAR_MONTH_DAY
  'yMMMMEEEEd': 'EEEE، d MMMM y', // YEAR_MONTH_WEEKDAY_DAY
  'yQQQ': 'QQQ y', // YEAR_ABBR_QUARTER
  'yQQQQ': 'QQQQ y', // YEAR_QUARTER
  'H': 'HH', // HOUR24
  'Hm': 'HH:mm', // HOUR24_MINUTE
  'Hms': 'HH:mm:ss', // HOUR24_MINUTE_SECOND
  'j': 'h a', // HOUR
  'jm': 'h:mm a', // HOUR_MINUTE
  'jms': 'h:mm:ss a', // HOUR_MINUTE_SECOND
  'jmv': 'h:mm a v', // HOUR_MINUTE_GENERIC_TZ
  'jmz': 'h:mm a z', // HOUR_MINUTETZ
  'jz': 'h a z', // HOURGENERIC_TZ
  'm': 'm', // MINUTE
  'ms': 'mm:ss', // MINUTE_SECOND
  's': 's', // SECOND
  'v': 'v', // ABBR_GENERIC_TZ
  'z': 'z', // ABBR_SPECIFIC_TZ
  'zzzz': 'zzzz', // SPECIFIC_TZ
  'ZZZZ': 'ZZZZ' // ABBR_UTC_TZ
};

var symbol = new intl.DateSymbols(
    NAME: "ku",
    ZERODIGIT: '\u0660',
    ERAS: const ['ق.م', 'م'],
    ERANAMES: const ['قبل الميلاد', 'ميلادي'],
    NARROWMONTHS: const [
      'ي',
      'ف',
      'م',
      'أ',
      'و',
      'ن',
      'ل',
      'غ',
      'س',
      'ك',
      'ب',
      'د'
    ],
    STANDALONENARROWMONTHS: const [
      'ي',
      'ف',
      'م',
      'أ',
      'و',
      'ن',
      'ل',
      'غ',
      'س',
      'ك',
      'ب',
      'د'
    ],
    MONTHS: const [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر'
    ],
    STANDALONEMONTHS: const [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر'
    ],
    SHORTMONTHS: const [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر'
    ],
    STANDALONESHORTMONTHS: const [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر'
    ],
    WEEKDAYS: const [
      'الأحد',
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت'
    ],
    STANDALONEWEEKDAYS: const [
      'الأحد',
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت'
    ],
    SHORTWEEKDAYS: const [
      'الأحد',
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت'
    ],
    STANDALONESHORTWEEKDAYS: const [
      'الأحد',
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت'
    ],
    NARROWWEEKDAYS: const ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
    STANDALONENARROWWEEKDAYS: const ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'],
    SHORTQUARTERS: const [
      'الربع الأول',
      'الربع الثاني',
      'الربع الثالث',
      'الربع الرابع'
    ],
    QUARTERS: const [
      'الربع الأول',
      'الربع الثاني',
      'الربع الثالث',
      'الربع الرابع'
    ],
    AMPMS: const ['ص', 'م'],
    DATEFORMATS: const ['EEEE، d MMMM y', 'd MMMM y', 'dd‏/MM‏/y', 'd‏/M‏/y'],
    TIMEFORMATS: const ['h:mm:ss a zzzz', 'h:mm:ss a z', 'h:mm:ss a', 'h:mm a'],
    DATETIMEFORMATS: const ['{1} {0}', '{1} {0}', '{1} {0}', '{1} {0}'],
    FIRSTDAYOFWEEK: 5,
    WEEKENDRANGE: const [4, 5],
    FIRSTWEEKCUTOFFDAY: 4);

class KurdishMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const KurdishMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ku';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    final String localeName = intl.Intl.canonicalizedLocale(locale.toString());
    date_symbol_data_custom.initializeDateFormattingCustom(
      locale: localeName,
      patterns: kuLocaleDatePatterns,
      symbols: symbol, //intl.DateSymbols.deserializeFromMap(nnDateSymbols),
    );
    return SynchronousFuture<MaterialLocalizations>(
      KurdishMaterialLocalizations(
        localeName: localeName,
        fullYearFormat: intl.DateFormat('y', 'ku'),
        mediumDateFormat: intl.DateFormat('EEE, MMM d', 'ku'),
        longDateFormat: intl.DateFormat('EEEE, MMMM d, y', 'ku'),
        compactDateFormat: intl.DateFormat('y', 'ku'),
        shortDateFormat: intl.DateFormat('y', 'ku'),
        shortMonthDateFormat: intl.DateFormat('y', 'ku'),
        yearMonthFormat: intl.DateFormat('MMMM y', 'ku'),
        decimalFormat: intl.NumberFormat('#,##0.###', 'ar'),
        twoDigitZeroPaddedFormat: intl.NumberFormat('00', 'ar'),
      ),
    );
  }

  @override
  bool shouldReload(KurdishMaterialLocalizationsDelegate old) => false;
}

class KurdishMaterialLocalizations extends MaterialLocalizationAr {
  const KurdishMaterialLocalizations({
    String localeName = 'ku',
    @required intl.DateFormat fullYearFormat,
    @required intl.DateFormat mediumDateFormat,
    @required intl.DateFormat longDateFormat,
    @required intl.DateFormat yearMonthFormat,
    @required intl.NumberFormat decimalFormat,
    @required intl.NumberFormat twoDigitZeroPaddedFormat,
    @required intl.DateFormat compactDateFormat,
    @required intl.DateFormat shortDateFormat,
    @required intl.DateFormat shortMonthDateFormat,
  }) : super(
          localeName: localeName,
          fullYearFormat: fullYearFormat,
          mediumDateFormat: mediumDateFormat,
          longDateFormat: longDateFormat,
          yearMonthFormat: yearMonthFormat,
          decimalFormat: decimalFormat,
          twoDigitZeroPaddedFormat: twoDigitZeroPaddedFormat,
          compactDateFormat: compactDateFormat,
          shortDateFormat: shortDateFormat,
          shortMonthDayFormat: shortMonthDateFormat,
        );

  @override
  String get alertDialogLabel => r'وریاکەر';

  @override
  String get backButtonTooltip => r'گەڕانەوە'; // back

  @override
  String get cancelButtonLabel => r'وازهێنان';

  @override
  String get closeButtonLabel => r'داخستن';

  @override
  String get closeButtonTooltip => r'داخستن';

  @override
  String get continueButtonLabel => r'بەردەوام بە';

  @override
  String get copyButtonLabel => r'ڕوونووس'; // copy

  @override
  String get cutButtonLabel => r'بڕین'; // cut

  @override
  String get deleteButtonTooltip => r'سڕینەوە';

  @override
  String get okButtonLabel => r'باشە';

  @override
  String get pasteButtonLabel => r'لکاندن';

  @override
  String get refreshIndicatorSemanticLabel => r'نوێکردنەوە';

  @override
  String get searchFieldLabel => r'گەڕان';

  @override
  String get selectAllButtonLabel => r'هەڵبژراردنی هەموو';

  @override
  int get firstDayOfWeekIndex => 0;

  static const LocalizationsDelegate<MaterialLocalizations> delegate =
      KurdishMaterialLocalizationsDelegate();

}


class KurdishCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const KurdishCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ku';

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    final String localeName = intl.Intl.canonicalizedLocale(locale.toString());
    date_symbol_data_custom.initializeDateFormattingCustom(
      locale: localeName,
      patterns: kuLocaleDatePatterns,
      symbols: symbol, //intl.DateSymbols.deserializeFromMap(nnDateSymbols),
    );
    return SynchronousFuture<CupertinoLocalizations>(
      KurdishCupertinoLocalization(
        localeName: localeName,
        fullYearFormat: intl.DateFormat('y', 'ku'),
        mediumDateFormat: intl.DateFormat('EEE, MMM d', 'ku'),
        decimalFormat: intl.NumberFormat('#,##0.###', 'ar'),
        doubleDigitMinuteFormat: intl.DateFormat('EEE, MMM d', 'ku'),
        singleDigitMinuteFormat: intl.DateFormat('EEE, MMM d', 'ku'),
        singleDigitHourFormat: intl.DateFormat('EEE, MMM d', 'ku'),
        singleDigitSecondFormat: intl.DateFormat('EEE, MMM d', 'ku'),
        dayFormat: intl.DateFormat('EEE, MMM d', 'ku'),
      ),
    );
  }

  @override
  bool shouldReload(KurdishCupertinoLocalizationsDelegate old) => false;
}


class KurdishCupertinoLocalization extends CupertinoLocalizationAr{

  const KurdishCupertinoLocalization({
    String localeName = 'ku',
    @required intl.DateFormat fullYearFormat,
    @required intl.DateFormat dayFormat,
    @required intl.DateFormat mediumDateFormat,
    @required intl.DateFormat singleDigitHourFormat,
    @required intl.DateFormat singleDigitMinuteFormat,
    @required intl.DateFormat doubleDigitMinuteFormat,
    @required intl.DateFormat singleDigitSecondFormat,
    @required intl.NumberFormat decimalFormat,
  }) : super(
    localeName: localeName,
    fullYearFormat: fullYearFormat,
    dayFormat: dayFormat,
    mediumDateFormat: mediumDateFormat,
    singleDigitHourFormat: singleDigitHourFormat,
    singleDigitMinuteFormat: singleDigitMinuteFormat,
    doubleDigitMinuteFormat: doubleDigitMinuteFormat,
    singleDigitSecondFormat: singleDigitSecondFormat,
    decimalFormat: decimalFormat,
  );

  static const LocalizationsDelegate<CupertinoLocalizations> delegate =
  KurdishCupertinoLocalizationsDelegate();

  @override
  String get alertDialogLabel => r'وریاکەر';

  @override
  String get copyButtonLabel => r'ڕوونووس'; // copy

  @override
  String get cutButtonLabel => r'بڕین'; // cut

  @override
  String get pasteButtonLabel => r'لکاندن';

  @override
  String get selectAllButtonLabel => r'هەڵبژراردنی هەموو';
}