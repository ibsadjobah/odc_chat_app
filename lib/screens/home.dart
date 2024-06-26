import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:odc_chat_app/models/user.dart';
import 'package:odc_chat_app/screens/message.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  List<User> users = [];

  int pageCouraant = 1;

  PagingController<int, User> pagingController =
      PagingController(firstPageKey: 1);

  List messages = [];

  double fontSize = 10;
  //double fontmax = 25;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    pagingController.addPageRequestListener((pageKey) {
      getUsersList(page: pageKey);
    });

    // messages = [
    //   {
    //     'user': users[0],
    //     'message': 'Message de la ',
    //     "heure": '16H:89',
    //     "status": 3
    //   },
    //   {
    //     'user': users[1],
    //     'message': 'Message de la ',
    //     "heure": '16H:89',
    //     "status": 3
    //   },
    //   {
    //     'user': users[2],
    //     'message': 'Message de la ',
    //     "heure": '16H:89',
    //     "status": 3
    //   },
    // ];
  }

  void getUsersList({int page = 1}) {
    getUsers(page: page, pagingController: pagingController);
  }

  // void getUserList() {
  //   getUsers().then((value) {
  //     setState(() {
  //       users = value;
  //     });
  //   });
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: HexColor("#131205"),
      appBar: AppBar(
        title: Text("Disussion"),
        titleTextStyle: TextStyle(color: Colors.white),
        actions: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              height: 45,
              width: 45,
              child: Center(
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: HexColor("#042f66"),
        leading: Padding(
          padding: EdgeInsets.all(5),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/users/avatar.jpg"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   height: 180,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: List.generate(users.length, (index) {
            //       return createAvatar(user: users[index]);
            //     }),
            //   ),
            // ),
            Container(
              height: 180,
              child: PagedListView(
                pagingController: pagingController,
                scrollDirection: Axis.horizontal,
                builderDelegate: PagedChildBuilderDelegate<User>(
                    itemBuilder: (context, item, index) {
                  return createAvatar(user: item);
                }),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Discussions",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: List.generate(messages.length, (index) {
                return GestureDetector(
                  child: createMessage(message: messages[index]),
                  onTap: () {
                    Get.to(() => MessagePage(
                          message: messages[index],
                        ));
                    //Get.off(() => MessagePage());
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget createMessage({required Map message}) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 5,
        left: 8,
        right: 8,
      ),
      child: ListTile(
        textColor: Colors.white,
        title: Text(
          message['user']['nom'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        //subtitle: Text(message['message']),
        leading: GestureDetector(
          onTap: () {
            setState(() {
              if (fontSize < 25)
                fontSize = fontSize + 25;
              else {
                fontSize = fontSize - 10;
              }
            });
          },
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(message['user']['image']),
          ),
        ),
        trailing: Column(
          children: [
            Text(message['heure']),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: HexColor('#301c70'),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Center(
                child: Text(message['status'].toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createAvatar({required User user}) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user.image),
                ),
                true
                    ? Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(28))),
                        ),
                      )
                    : const SizedBox(),
                true
                    ? Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 21,
                          width: 21,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
          Text(
            user.first_name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
