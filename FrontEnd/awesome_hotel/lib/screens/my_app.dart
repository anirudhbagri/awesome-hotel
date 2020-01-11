import 'package:awesome_hotel/providers/hotels_provider.dart';
import 'package:awesome_hotel/widgets/hotel_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _sortResult = false;

  @override
  Widget build(BuildContext context) {
    var hotels = Provider.of<Hotel>(context).hotels;
    if (_sortResult) hotels.sort((a, b) => a.price.compareTo(b.price));
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            SizedBox(
              width: 64,
              child: FlatButton(
                child: Icon(Icons.sort),
                onPressed: () => {
                  setState(() => {_sortResult = !_sortResult})
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: getLatestDataFromServer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                      height: 40,
                      child: TextField(
                        onChanged: onSearchInput,
                        decoration: InputDecoration(
                          hintText: 'Search for a place..',
                        ),
                      )),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 160,
                  child: ListView.builder(
                    itemCount: hotels.length,
                    itemBuilder: (ctx, idx) => HotelListItem(
                      model: hotels[idx],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Builder(
          builder: (ctx) => FloatingActionButton(
            onPressed: () {
              Scaffold.of(ctx).showSnackBar(
                  SnackBar(content: Text("You are not logged in!")));
            },
            tooltip: 'Add your hotel!',
            child: Icon(Icons.add),
          ),
        ));
  }

  bool isLoggedIn() {
    return false;
  }

  Future<void> getLatestDataFromServer() async {
    Provider.of<Hotel>(context).fetchAndSetHotels();
    return;
  }

  onSearchInput(String startText) {
    print('Filtering result..' + startText);
    Provider.of<Hotel>(context).filterHotels(startText);
  }
}
