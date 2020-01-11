import 'package:awesome_hotel/app-constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum RoomType { PrivateRoom, EntireHome }

class HotelModel {
  String name;
  String hostname;
  String neighbourhoodGroup;
  String neighbourhood;
  double latitude;
  double longitude;
  RoomType roomType;
  int price;

  HotelModel(
      {@required this.name,
      @required this.hostname,
      @required this.neighbourhood,
      @required this.neighbourhoodGroup,
      @required this.latitude,
      @required this.longitude,
      @required this.roomType,
      @required this.price});
}

class Hotel with ChangeNotifier {
  Hotel() {
    fetchAndSetHotels();
  }
  List<HotelModel> _hotels = [];
  List<HotelModel> _filteredHotels = [];
  // [
  //   HotelModel(
  //       hostname: 'Anirudh',
  //       name: 'Lovely Hotel',
  //       neighbourhood: 'EGL',
  //       neighbourhoodGroup: 'Bengaluru',
  //       roomType: RoomType.PrivateRoom,
  //       latitude: 0.0,
  //       longitude: 0.0,
  //       price: 150),
  //   HotelModel(
  //       hostname: 'Anand',
  //       name: 'Nice Hotel',
  //       neighbourhood: 'EGL',
  //       neighbourhoodGroup: 'Bengaluru',
  //       roomType: RoomType.PrivateRoom,
  //       latitude: 0.0,
  //       longitude: 0.0,
  //       price: 100),
  //   HotelModel(
  //       hostname: 'Ayush',
  //       name: 'Amazing Hotel',
  //       neighbourhood: 'Mahadevpura',
  //       neighbourhoodGroup: 'Bengaluru',
  //       roomType: RoomType.EntireHome,
  //       latitude: 0.0,
  //       longitude: 0.0,
  //       price: 120)
  // ];

  List<HotelModel> get hotels {
    return [..._filteredHotels];
  }

  Future<void> fetchAndSetHotels() async {
    print('fetcing the results');
    var response = await http.get(Constants.SERVER + '/listing?limit=100');
    if (response.statusCode != 200) return;
    List hotels = json.decode(response.body);
    List<HotelModel> hotelsFromServer = hotels
        .map(
          (hotel) => HotelModel(
              hostname: hotel[1],
              latitude: double.parse(hotel[4]),
              longitude: double.parse(hotel[5]),
              name: hotel[0],
              neighbourhood: hotel[3],
              neighbourhoodGroup: hotel[2],
              price: hotel[7] as int,
              roomType: hotel[6] == 'Private room'
                  ? RoomType.PrivateRoom
                  : RoomType.EntireHome),
        )
        .toList();
    _hotels = hotelsFromServer;
    _filteredHotels = _hotels;
    notifyListeners();
  }

  void filterHotels(String startText) {
    print('Filtering here ' + startText);

    _filteredHotels = _hotels
        .where((hotel) => hotel.name.toLowerCase().startsWith(startText))
        .toList();
    print(_filteredHotels.length);
    notifyListeners();
  }
}
