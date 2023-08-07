import 'package:chat/model/ui/add_room/add_room_viewmodel.dart';
import 'package:chat/model/ui/base/base_view.dart';
import 'package:chat/model/ui/home/home_screen.dart';
import 'package:flutter/material.dart';

class AddRoomScreen extends StatefulWidget {
  static const String screenName = "AddRoomScreen";
  const AddRoomScreen({super.key});

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseView<AddRoomScreen, AddRoomViewmodel>
    implements AddRoomNavigator {
  final formKey = GlobalKey<FormState>();
  TextEditingController roomNameController = TextEditingController();
  TextEditingController roomDescriptionController = TextEditingController();

  static final List<String> dropDownList = <String>[
    'Music',
    'Movies',
    'Sports'
  ];
  String dropdownValue = dropDownList.first;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(18),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/main_bg.png'),
                fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Chat App'),
            centerTitle: true,
          ),
          body: Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * .06),
            // padding: EdgeInsets.all(9),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          color: Colors.white,
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Align(
                                    alignment: Alignment.center,
                                    child: Text('Add New Room')),
                                const Image(
                                    image:
                                        AssetImage('assets/images/ngroup.png')),
                                TextFormField(
                                  controller: roomNameController,
                                  validator: (value) {
                                    if (value?.trim().isEmpty ?? true) {
                                      return 'please Enter a room name';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'Enter Room Name'),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .06,
                                ),
                                DropdownButton<String>(
                                  value: dropdownValue,
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      dropdownValue = value!;
                                    });
                                  },
                                  items: dropDownList
                                      .map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              value), // Remove the Expanded widget here
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .06,
                                ),
                                TextFormField(
                                  controller: roomDescriptionController,
                                  maxLines: 2,
                                  decoration: const InputDecoration(
                                      hintText: 'Enter Room Description'),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .06,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      formValidate();
                                    },
                                    child: const Text('Create'))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void formValidate() {
    if (formKey.currentState!.validate()) {
      viewModel.addRoom(roomNameController.text, roomDescriptionController.text,
          dropdownValue);
    }
  }

  @override
  AddRoomViewmodel initViewmodel() {
    return AddRoomViewmodel();
  }

  @override
  goBack() {
    Navigator.pushReplacementNamed(context, HomeScreen.screenName);
  }
}
