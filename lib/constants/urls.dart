const String _ip = '192.168.32.4';

String _createUrl(int port) => 'http://$_ip:$port';

class Urls {
  static String get identity => _createUrl(5001);
  static String get safePlaces => _createUrl(5005);
}