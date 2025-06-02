//Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

//Providers
import '../providers/authentiaction_provider.dart';

//Widgets
import '../widgets/top_bar.dart';
import '../widgets/custom_list_view_tiles.dart';

class ChatsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatsPageState();
  }
}

class _ChatsPageState extends State<ChatsPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthentiactionProvider _auth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthentiactionProvider>(context);
    return _buildUI();
  }

  Widget _buildUI() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _deviceWidth * 0.03,
        vertical: _deviceHeight * 0.02,
      ),
      height: _deviceHeight * 0.98,
      width: _deviceWidth * 0.97,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TopBar(
            "Chats",
            primaryAction: IconButton(
              onPressed: () {
                _auth.logout();
              },
              icon: Icon(Icons.logout, color: Color.fromRGBO(0, 82, 218, 1.0)),
            ),
          ),
          _chatsList(),
        ],
      ),
    );
  }

  Widget _chatsList() {
    return Expanded(child: _chatTile());
  }

  Widget _chatTile() {
    return CustomListViewTileWithActivity(
      height: _deviceHeight * 0.1,
      title: "Cristiano Ronaldo",
      subtitle: "Hello!",
      imagePath: "https://i.pravatar.cc/300",
      isActive: false,
      isActivity: false,
      onTap: () {},
    );
  }
}
