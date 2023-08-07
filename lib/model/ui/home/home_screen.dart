import 'package:chat/model/database/models/room.dart';
import 'package:chat/model/ui/add_room/add_room_screen.dart';
import 'package:chat/model/ui/base/base_view.dart';
import 'package:chat/model/ui/home/home_screen_navigator.dart';
import 'package:chat/model/ui/home/home_screen_viewmodel.dart';
import 'package:chat/model/ui/home/room_item_builder.dart';
import 'package:chat/model/ui/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String screenName = "home-screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseView<HomeScreen, HomeScreenViewModel>
    implements HomeScreenNavigator {
  @override
  HomeScreenViewModel initViewmodel() {
    return HomeScreenViewModel();
  }

  bool isMyRoomSelected = false;
  @override
  void initState() {
    super.initState();
    viewModel.loadRooms();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/main_bg.png',
                ),
                fit: BoxFit.cover)),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Home'),
            actions: [
              InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) =>
                          false, // This predicate removes all previous routes from the stack.
                    );
                  },
                  child: const Icon(Icons.logout))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              viewModel.navigator?.goToAddRoom();
            },
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isMyRoomSelected = true;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: isMyRoomSelected == true
                          ? Colors.white
                          : Colors.transparent,
                    ))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('My Rooms',
                          style: isMyRoomSelected == true
                              ? Theme.of(context).textTheme.headlineLarge
                              : Theme.of(context).textTheme.headlineMedium),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isMyRoomSelected = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: isMyRoomSelected == false
                                    ? Colors.white
                                    : Colors.transparent))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Browse',
                        style: isMyRoomSelected == false
                            ? Theme.of(context).textTheme.headlineLarge
                            : Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Expanded(
              child: Consumer<HomeScreenViewModel>(
                builder: (buildContext, homeScreenViewModel, _) {
                  List<Room> roomsToShow = isMyRoomSelected
                      ? homeScreenViewModel
                          .getMyRooms() // Add this method to your HomeScreenViewModel
                      : homeScreenViewModel.room;

                  return roomsToShow.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12),
                          itemBuilder: (buildContext, index) {
                            return RoomItemBuilder(room: roomsToShow[index]);
                          },
                          itemCount: roomsToShow.length,
                        );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }

  @override
  goToAddRoom() {
    Navigator.pushNamed(context, AddRoomScreen.screenName);
  }
}
