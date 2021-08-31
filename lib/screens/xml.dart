import 'package:xml2json/xml2json.dart';
import 'dart:convert';

main() {
  final Xml2Json xml2Json = Xml2Json();

  var xmlString = '''
     <data>
<schedule>
 <showtime>9:30 Available</showtime>
 <hour>11</hour>
</schedule>
<schedule>
<showtime>9:30 not Available</showtime>
<hour>horrr</hour>
</schedule>
<schedule>
<showtime>9:30 Available</showtime>
<hour>9</hour>
</schedule>
<schedule>
<showtime>9:30 Available</showtime>
<hour>12</hour>
</schedule>
</data>

''';

  xml2Json.parse(xmlString);
  var jsonString = xml2Json.toParker();
  // {"tut": {"id": "123", "author": "bezKoder", "title": "Programming Tut#123", "publish_date": "2020-3-16", "description": "Description for Tut#123"}}

  var data = jsonDecode(jsonString);
  // {tut: {id: 123, author: bezKoder, title: Programming Tut#123, publish_date: 2020-3-16, description: Description for Tut#123}}

  print(data['data']['schedule']);
}
