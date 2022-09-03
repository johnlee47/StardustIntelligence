import 'dart:html';
import 'dart:math';
import 'dart:convert';

// api key: 96844162266aa4456d7928786b2e8c531769e5c2
// https://leakcheck.net/api?key=YOUR_KEY&check=example@example.com&type=email
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../source.dart';
import '../sources.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String dropdownValue = "";
  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String searchTerm = "";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Material(
      child: Scaffold(
        // backgroundColor: Color(0xFF282828),
        body: Container(
          width: width,
          height: height,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(50),
                child: Text(
                  "Stardust Intelligence Data",
                  style: TextStyle(
                      fontSize: 80,
                      color: Color(0xFF1f2833),
                      fontWeight: FontWeight.bold
                      // height: 40,
                      ),
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.1, horizontal: width * 0.2),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      // color: Colors.black45,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.04, bottom: height * 0.04),
                          child: Text(
                            "Check to see if your account was hacked",
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Center(
                                child: Padding(
                              padding: EdgeInsets.only(left: width * 0.01),
                              child: Text("Search Term"),
                            )),
                            Container(
                              width: width * 0.5,
                              height: height * 0.1,
                              child: Padding(
                                padding: EdgeInsets.only(left: 40),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      dropdownValue = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter some text";
                                    }
                                    return null;
                                  },
                                  controller: myController,
                                  decoration: InputDecoration(
                                      hintText: 'Enter something',
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 3, color: Colors.purpleAccent),
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                ),
                              ),
                            ),
                            // Text("Data"),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          children: [
                            Center(
                                child: Padding(
                              padding:
                                  EdgeInsets.only(left: width * 0.01, top: 50),
                              child: Text("Search Type"),
                            )),
                            DropDown2(onSelectItem: (item) {
                              setState(() {
                                searchTerm = item;
                              });
                            }),
                            // Text("Data"),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        ButtonLoading(
                            searchTerm: searchTerm, searchType: dropdownValue),
                        SizedBox(
                          height: height * 0.04,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DropDown2 extends StatefulWidget {
  final Function(String item) onSelectItem;

  const DropDown2({Key? key, required this.onSelectItem}) : super(key: key);

  @override
  State<DropDown2> createState() => _DropDown2State();
}

class _DropDown2State extends State<DropDown2> {
  final List<String> items = [
    "email",
    'password',
    'username'
  ];
  String? selectedValue;

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<int> _getDividersIndexes() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (items.length * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.5,
      child: Padding(
        padding: EdgeInsets.only(top: 40, left: 40),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Text(
              'Select Item',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: _addDividersAfterItems(items),
            customItemsIndexes: _getDividersIndexes(),
            customItemsHeight: 4,
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as String;
              });
              widget.onSelectItem(value as String);
            },
            buttonHeight: 40,
            buttonWidth: 140,
            itemHeight: 40,
            buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black45)),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // color: Colors.purpleAccent,
            ),
            itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            dropdownMaxHeight: height * 0.3,
            selectedItemHighlightColor: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}


class ButtonLoading extends StatefulWidget {
  final String searchTerm;
  final String searchType;

  const ButtonLoading(
      {Key? key, required this.searchTerm, required this.searchType})
      : super(key: key);

  @override
  State<ButtonLoading> createState() => _ButtonLoadingState();
}

class _ButtonLoadingState extends State<ButtonLoading> {
  bool isLoading = false;

  Future<Sources?> getHttp(String searchTerm, String searchType) async {
    try {
      print(searchTerm);
      print(searchType);
      var response = await Dio().get(
          'https://leakcheck.net/api/public?key=96844162266aa4456d7928786b2e8c531769e5c2&check=${searchType}&type=${searchTerm}'
      );
      //leakcheck.net/api/public?key=96844162266aa4456d7928786b2e8c531769e5c2&check=$searchTerm&type=$searchType
      print(response);
      return Sources.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response?.data);
    } catch (e) {
      print(e);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.08,
        height: MediaQuery.of(context).size.height * 0.06,

        // elevated button created and given style
        // and decoration properties
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.green),
          onPressed: () async {
            // brightdarkness11@hotmail.com
            setState(() {
              isLoading = true;
            });
            Sources? sources =
                await getHttp(widget.searchTerm, widget.searchType);
            setState(() {
              isLoading = false;
            });
            if (sources != null) {
              _buildPopupDialog(context, sources);
            }
            // we had used future delayed to stop loading after
            // 3 seconds and show text "submit" on the screen.
            // Future.delayed(const Duration(seconds: 3), () {
            //
            //
            // });
          },
          child: isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  // as elevated button gets clicked we will see text"Loading..."
                  // on the screen with circular progress indicator white in color.
                  //as loading gets stopped "Submit" will be displayed
                  children: const [
                    // Text(
                    //   'Loading...',
                    //   style: TextStyle(fontSize: 15),
                    // ),
                    // SizedBox(
                    //   width: 4,
                    // ),
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ],
                )
              : const Text('Search'),
        ));
  }

  // Future _navigateToNextScreen(BuildContext context, Sources sources) {
  //   return Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) => _buildPopupDialog(context, sources)));
  // }

  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  Future _buildPopupDialog(BuildContext context, Sources sources) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Popup example'),
        content: Container(
          height: 300.0, // Change as per your requirement
          width: 300.0, // Change as per your requirement
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: sources.sources.length,
            itemBuilder: (BuildContext context, int index) {
              Source source = sources.sources[index];
              return ListTile(
                title: Text('Username: ${source.name},\n Date: ${source.date},\n Password ${generateRandomString(7)}'),
              );
            },
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
