import 'package:interspector/src/models/call_status.dart';

extension IntX on int? {
  CallStatus get getCallStatusFromCode {
    final status = this;
    if (status != null) {
      bool isSuccess = status >= 200 && status <= 299;
      bool isRedirect = status >= 300 && status <= 399;
      bool isError = status >= 400 && status <= 599;

      if (isSuccess) {
        return CallStatus.succes;
      } else if (isRedirect) {
        return CallStatus.warning;
      } else if (isError) {
        return CallStatus.error;
      } else {
        return CallStatus.error;
      }
    } else {
      return CallStatus.pending;
    }
  }
}
