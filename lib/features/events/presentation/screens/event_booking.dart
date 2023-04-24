import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proequine/features/events/data/eventandtransport_model.dart';
import 'package:proequine/features/events/presentation/screens/event_summry.dart';

import '../../../../core/widgets/datepickerItem.dart';


class BookEvent extends StatefulWidget {
  const BookEvent({super.key});

  @override
  State<BookEvent> createState() => _BookEventState();
}

class _BookEventState extends State<BookEvent> {
  // constroctor for dropdown
  _BookEventState() {
    _selectedValue = _typeList[0];
    _selectedhorseNo = _horseNo[0];
  }
  // veriables
  late final TextEditingController _fullname;
  late final TextEditingController _email;
  late final TextEditingController _mobile;
  late final TextEditingController _origin;
  late final TextEditingController _destination;
  // date and time
  DateTime _date = DateTime.now();
  DateTime _time = DateTime.now();
  // dropdownlist
  final _typeList = ["type1", "type2", "type3"];
  final _horseNo = ["1", "2", "3"];
  String? _selectedValue = "";
  String? _selectedhorseNo = "";
  bool? _returnevent = false;
  @override
  void initState() {
    // TODO: implement initState
    _fullname = TextEditingController();
    _email = TextEditingController();
    _mobile = TextEditingController();
    _origin = TextEditingController();
    _destination = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fullname.dispose();
    _email.dispose();
    _mobile.dispose();
    _origin.dispose();
    _destination.dispose();
    super.dispose();
  }

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoDatePicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            // The Bottom margin is provided to align the popup above the system navigation bar.
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            // Provide a background color for the popup.
            color: CupertinoColors.systemBackground.resolveFrom(context),
            // Use a SafeArea widget to avoid system overlaps.
            child: SafeArea(
              top: false,
              child: child,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              primary: Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text(
              "Done",
              style: TextStyle(
                fontSize: 17,
                color: Colors.redAccent,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  void _addNewEvent(
      String evfullname,
      String evemail,
      String evnumber,
      String evorigine,
      String evdestination,
      String evnohorse,
      String evEvent,
      DateTime evDate,
      DateTime evTime,
      bool evReturn) {
    final newEvent = EventDetailsModel(
        fullName: evfullname,
        email: evemail,
        number: evnumber,
        origin: evorigine,
        destination: evdestination,
        noofhorse: evnohorse,
        serviceType: evEvent,
        date: evDate,
        time: evTime,
        returnevent: evReturn);

    // Navigator.of(context)
    //     .pushNamed(EventSummary.routeName, arguments: newEvent);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return EventSummary(eventDetails: newEvent);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Booking"),
        backgroundColor: const Color.fromRGBO(91, 90, 86, 1),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 8),
            child: Column(
              children: [
                Container(
                  height: 140,
                  width: 140,
                  child: Image.asset('assets/images/logo.png'),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 14),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Full Name';
                            }
                            return null;
                          },
                          controller: _fullname,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            label: Text("Full Name"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            hintText: 'Full Name',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 14),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Email';
                            }
                            return null;
                          },
                          controller: _email,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            label: Text("Email"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            hintText: 'Email',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 14),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Number';
                            }
                            return null;
                          },
                          controller: _mobile,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            label: Text("Number"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            hintText: '123 456 789',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 14),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Origin';
                            }
                            return null;
                          },
                          controller: _origin,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            label: Text("Origin"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            hintText: 'Origin',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 14),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Destination';
                            }
                            return null;
                          },
                          controller: _destination,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            label: Text("Destination"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            hintText: 'Destination Location',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 14),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            label: Text("No Of Horse"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            )),
                          ),
                          value: _selectedhorseNo,
                          items: _horseNo
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ),
                              )
                              .toList(),
                          onChanged: ((value) {
                            setState(() {
                              _selectedhorseNo = value as String;
                            });
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 14),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            label: Text("Event"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            )),
                          ),
                          value: _selectedValue,
                          items: _typeList
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ),
                              )
                              .toList(),
                          onChanged: ((value) {
                            setState(() {
                              _selectedValue = value as String;
                            });
                          }),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DatePickerItem(
                              children: <Widget>[
                                const Text('Date'),
                                CupertinoButton(
                                  // Display a CupertinoDatePicker in date picker mode.
                                  onPressed: () => _showDialog(
                                    CupertinoDatePicker(
                                      initialDateTime: _date,
                                      mode: CupertinoDatePickerMode.date,

                                      // This is called when the user changes the date.
                                      onDateTimeChanged: (DateTime newDate) {
                                        setState(() => _date = newDate);
                                      },
                                    ),
                                  ),
                                  // In this example, the date value is formatted manually. You can use intl package
                                  // to format the value based on user's locale settings.
                                  child: Text(
                                    '${_date.month}-${_date.day}-${_date.year}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: DatePickerItem(
                              children: <Widget>[
                                const Text('Time'),
                                CupertinoButton(
                                  // Display a CupertinoDatePicker in time picker mode.
                                  onPressed: () => _showDialog(
                                    CupertinoDatePicker(
                                      initialDateTime: _time,
                                      mode: CupertinoDatePickerMode.time,

                                      // This is called when the user changes the time.
                                      onDateTimeChanged: (DateTime newTime) {
                                        setState(() => _time = newTime);
                                      },
                                    ),
                                  ),
                                  // In this example, the time value is formatted manually. You can use intl package to
                                  // format the value based on the user's locale settings.
                                  child: Text(
                                    '${_time.hour}:${_time.minute}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CheckboxListTile(
                          value: _returnevent,
                          title: Text("Return"),
                          onChanged: (value) {
                            setState(() {
                              _returnevent = value;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            primary:
                                const Color.fromRGBO(196, 134, 54, 1),
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const Text(
                            "Book",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _addNewEvent(
                                  _fullname.text,
                                  _email.text,
                                  _mobile.text,
                                  _origin.text,
                                  _destination.text,
                                  _selectedhorseNo!,
                                  _selectedValue!,
                                  _date,
                                  _time,
                                  _returnevent!);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
