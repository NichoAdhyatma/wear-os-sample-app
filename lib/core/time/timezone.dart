import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

enum IndonesiaTimeZone {
  WIB,
  WITA,
  WIT,
}

String getLocalTimeZone({IndonesiaTimeZone timeZone = IndonesiaTimeZone.WIB}) {
  tz.Location location;

  switch (timeZone) {
    case IndonesiaTimeZone.WIB:
      location = tz.getLocation('Asia/Jakarta');
      break;
    case IndonesiaTimeZone.WITA:
      location = tz.getLocation('Asia/Makassar');
      break;
    case IndonesiaTimeZone.WIT:
      location = tz.getLocation('Asia/Jayapura');
      break;
  }

  final wibTime = tz.TZDateTime.now(location);

  return DateFormat('HH:mm:ss').format(wibTime);
}
