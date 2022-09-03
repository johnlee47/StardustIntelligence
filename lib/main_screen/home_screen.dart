import 'package:abyss/main_screen/loading_screen.dart';
import 'package:abyss/main_screen/results_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final myController = TextEditingController();
  var _isLoading = false;

  void _onSubmit() {
    setState(() => _isLoading = true);
    Future.delayed(
      const Duration(seconds: 2),
      () => setState(() => _isLoading = false),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("Stardust Intel"),
          leading: Icon(
            Icons.location_searching_outlined,
            color: Colors.blue,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: height * 0.15,
              constraints: BoxConstraints(maxWidth: width * 0.9),
              padding: EdgeInsets.all(5),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  'Stardust Intel Data',
                  style: TextStyle(
                    fontFamily: 'Calibri',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Text("Search Term"),
                Expanded(
                  child: TextField(
                    controller: myController,
                    decoration: InputDecoration(
                        labelText: 'Enter something',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Colors.red),
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Search Type"),
                DropDown(),
              ],
            ),
            ButtonLoading(),
          ],
        ));
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        content: Text("Data"),
      ),
    );
  }
}

class ButtonLoading extends StatefulWidget {
  const ButtonLoading({Key? key}) : super(key: key);

  @override
  State<ButtonLoading> createState() => _ButtonLoadingState();
}

class _ButtonLoadingState extends State<ButtonLoading> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        width: MediaQuery.of(context).size.width,
        height: 60,

        // elevated button created and given style
        // and decoration properties
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.green),
          onPressed: () {

            setState(() {
              isLoading = true;
            });

            // we had used future delayed to stop loading after
            // 3 seconds and show text "submit" on the screen.
            Future.delayed(const Duration(seconds: 3), () {
              setState(() {
                isLoading = false;
              });
            });
          },
          child: isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  // as elevated button gets clicked we will see text"Loading..."
                  // on the screen with circular progress indicator white in color.
                  //as loading gets stopped "Submit" will be displayed
                  children: const [
                    Text(
                      'Loading...',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ],
                )
              : const Text('Search'),
        ));
  }
}

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({Key? key}) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String dropdownValue = 'First Name';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.5,
      child: Padding(
        padding: EdgeInsets.only(top: 40, left: 40),
        child: DropdownButtonFormField<String>(
          menuMaxHeight: height * 0.45,
          value: dropdownValue,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.alternate_email),
          ),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          onTap: () {},
          items: <String>[
            "First Name",
            'Last Name',
            'Date of Birth',
            'Email Address',
            'Phone Number',
            'City',
            "State",
            'Zip Code',
            'Education',
            'Occupation',
            'Vehicle',
            'Spouse',
            'Devices',
            'HWid',
            'Internet History',
            'IP Address',
            'Usernames'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// onPressed: () {
// // Validate returns true if the form is valid, or false otherwise.
//
// showDialog(
// context: context,
// builder: (context) {
// return AlertDialog(
// // Retrieve the text the that user has entered by using the
// // TextEditingController.
// content: Text(myController.text),
// );
// },
// );
// },

// class _DropdownItemState extends State<DropdownItem> {
//   String? selectedValue = null;
//   final _dropdownFormKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//         key: _dropdownFormKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             DropdownButtonFormField(
//                 decoration: InputDecoration(
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blue, width: 2),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blue, width: 2),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   filled: true,
//                   fillColor: Colors.blueAccent,
//                 ),
//                 validator: (value) => value == null ? "Select a country" : null,
//                 dropdownColor: Colors.blueAccent,
//                 value: selectedValue,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedValue = newValue!;
//                   });
//                 },
//                 items: dropdownItems),
//             ElevatedButton(
//                 onPressed: () {
//                   if (_dropdownFormKey.currentState!.validate()) {
//                     //valid flow
//                   }
//                 },
//                 child: Text("Submit"))
//           ],
//         ));
//   }
// }

// class DropDown extends StatefulWidget {
//   @override
//   DropDownWidget createState() => DropDownWidget();
// }
//
// class DropDownWidget extends State {
//   String dropdownValue = "Email Address";
//   String holder = '';
//
//   List<String> actorsName = [
//     "First Name",
//     'Last Name',
//     'Date of Birth',
//     'Email Address',
//     'Phone Number',
//     'City',
//     "State",
//     'Zip Code',
//     'Education',
//     'Occupation',
//     'Vehicle',
//     'Spouse',
//     'Devices',
//     'HWid',
//     'Internet History',
//     'IP Address',
//     'Usernames'
//   ];
//
//   void getDropDownItem() {
//     setState(() {
//       holder = dropdownValue;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return SizedBox(
//       width: width * 0.6,
//       child: DropdownButton<String>(
//         value: dropdownValue,
//         icon: Icon(Icons.arrow_drop_down),
//         iconSize: 50,
//         elevation: 16,
//         style: TextStyle(color: Colors.red, fontSize: 18),
//         underline: Container(
//           height: 2,
//           color: Colors.deepPurpleAccent,
//         ),
//         onChanged: (String? data) {
//           setState(() {
//             dropdownValue = data!;
//           });
//         },
//         items: actorsName.map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
//           );
//         }).toList(),
//       ),
//     );
//     // Padding(
//     //     padding: EdgeInsets.only(top: 30, bottom: 30),
//     //     child:
//     //         //Printing Item on Text Widget
//     //         Text('Selected Item = ' + '$holder',
//     //             style: TextStyle(fontSize: 22, color: Colors.black))),
//   }
// }
