import 'package:filmdevelopmentcompanion/io/FilmDevelopmentStatusProvider.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatus.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;

class RossmannStatusProvider extends FilmDevelopmentStatusProvider {
  static final RossmannStatusProvider _instance =
      RossmannStatusProvider._internal();

  RossmannStatusProvider._internal();

  static RossmannStatusProvider get instance => _instance;

  @override
  Future<FilmDevelopmentStatus> obtainDevelopmentStatusForFilmOrder(
      FilmDevelopmentOrder film) async {
    print("Not yet implemented");
  }

  Future<List<Map<String, String>>> loadStoresForPLZ(String plz) async {
    http.Response httpResponse = await http
        .get("https://shop.rossmann-fotowelt.de/tracking/outlet.jsp?zip=$plz");
    Document document = parse(httpResponse.body);
    List<Element> outletList =
        document.querySelectorAll("#outletList .outletAddress");
    List<Map<String, String>> listOfMaps = new List();
    for (Element element in outletList) {
      String zip = element.querySelector(".outletAddressZip").text.trim();
      String city = element.querySelector(".outletAddressCity").text.trim();
      String street = element.querySelector(".outletAddressStreet").text.trim();
      String link = element
          .querySelector(".outletAddressZip")
          .querySelector("a")
          .attributes["href"]
          .trim();
      listOfMaps
          .add({"zip": zip, "city": city, "street": street, "link": link});
    }
    return listOfMaps;
  }
}
