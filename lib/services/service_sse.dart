import 'package:tontino/models/Sse.dart';
import 'package:tontino/services/ServiceHttp.dart';

class ServiceSse {
  Stream? myStream;
  String url = "";
  // ServiceHttp _serviceHttp = ServiceHttp();

  ServiceSse() {
    // connect();
  }

  Stream<dynamic>? connect({url}) {
    // url = await _serviceHttp.getUrlSse() ?? "";

    if (url != "") {
      print("-- -- URL SSE: $url");
      print("-- -- SUBSCRIPT SSE");

      this.myStream = Sse.connect(
        uri: Uri.parse(url),
        closeOnError: true,
        withCredentials: false,
      ).stream;

      // print(myStream.asBroadcastStream());

      this.myStream?.listen((event) {
        print('Received:' +
            DateTime.now().millisecondsSinceEpoch.toString() +
            ' : ' +
            event.toString());
      });
    }

    return myStream;
  }
}
