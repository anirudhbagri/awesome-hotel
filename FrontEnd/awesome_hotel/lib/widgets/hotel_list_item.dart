import 'dart:math';

import 'package:awesome_hotel/app-constants.dart';

import '../providers/hotels_provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rating_bar/rating_bar.dart';

class HotelListItem extends StatefulWidget {
  final HotelModel model;
  HotelListItem({Key key, this.model}) : super(key: key);

  @override
  _HotelListItemState createState() => _HotelListItemState();
}

class _HotelListItemState extends State<HotelListItem> {
  bool _isExpanded = false;
  _launchURL(double lat, double long) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var apikey = Constants.GOOGLE_MAPS_API_KEY;
    var lat = widget.model.latitude;
    var long = widget.model.longitude;
    var rating = Random(13).nextDouble();
    var imageUrl = 'https://staticmapmaker.com/img/google@2x.png';
    //var imageUrl ="https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lang&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$long&key=$apikey";
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Card(
        child: Container(
          width: double.infinity,
          height: _isExpanded ? 500 : 75,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).backgroundColor.withOpacity(0.6),
              Theme.of(context).backgroundColor
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: CircleAvatar(
                      child: Text(widget.model.name.substring(0, 1)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              widget.model.name,
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          Text(
                            widget.model.hostname,
                            textAlign: TextAlign.start,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "\$" + widget.model.price.toString(),
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Icon(
                    widget.model.roomType == RoomType.EntireHome
                        ? Icons.group
                        : Icons.person,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Theme.of(context).accentColor,
                          child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(_isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more)),
                          onTap: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (_isExpanded)
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RatingBar.readOnly(
                          initialRating: (1 + rating) % 5,
                          isHalfAllowed: true,
                          halfFilledIcon: Icons.star_half,
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        width: 400,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.network(imageUrl),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 150,
                              child: FlatButton(
                                color: Theme.of(context).buttonColor,
                                onPressed: () {
                                  _launchURL(widget.model.latitude,
                                      widget.model.longitude);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.map),
                                    Text('Open in Maps'),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 150,
                              child: FlatButton(
                                color: Theme.of(context).buttonColor,
                                onPressed: () {
                                  _launchURL(widget.model.latitude,
                                      widget.model.longitude);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.map),
                                    Text('Book it!'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
