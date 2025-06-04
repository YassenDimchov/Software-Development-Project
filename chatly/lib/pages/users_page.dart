//Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

//Providers
import '../providers/authentiaction_provider.dart';
import '../providers/users_page_provider.dart';

//Widgets
import '../widgets/top_bar.dart';
import '../widgets/custom_input_fields.dart';
import '../widgets/custom_list_view_tiles.dart';
import '../widgets/rounded_button.dart';

//Models
import '../models/chat_user.dart';

class UsersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UsersPageState();
  }
}

class _UsersPageState extends State<UsersPage> {
  late double _deviceWidth;
  late double _deviceHeight;

  late AuthentiactionProvider _auth;
  late UsersPageProvider _pageProvider;

  final TextEditingController _searchFieldTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthentiactionProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersPageProvider>(
          create: (_) => UsersPageProvider(_auth),
        ),
      ],
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(
      builder: (BuildContext _context) {
        _pageProvider = _context.watch<UsersPageProvider>();
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.03,
            vertical: _deviceHeight * 0.02,
          ),
          height: _deviceHeight * 0.98,
          width: _deviceWidth * 0.97,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              TopBar(
                "Users",
                primaryAction: IconButton(
                  onPressed: () {
                    _auth.logout();
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Color.fromRGBO(0, 82, 218, 1.0),
                  ),
                ),
              ),
              CustomTextField(
                onEditingComplete: (_value) {
                  _pageProvider.getUsers(name: _value);
                  FocusScope.of(context).unfocus();
                },
                hintText: "Search...",
                obscureText: false,
                controller: _searchFieldTextEditingController,
                icon: Icons.search,
              ),
              _usersList(),
              _createChatButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _usersList() {
    List<ChatUser>? allUsers = _pageProvider.users;

    return Expanded(
      child: () {
        if (allUsers != null) {
          List<ChatUser> filteredUsers =
              allUsers.where((user) => user.uid != _auth.user.uid).toList();

          if (filteredUsers.isNotEmpty) {
            return ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (BuildContext _context, int _index) {
                ChatUser user = filteredUsers[_index];
                return CustomListViewTile(
                  height: _deviceHeight * 0.1,
                  title: user.name,
                  subtitle: "Last Active: ${user.lastDayActive()}",
                  imagePath: user.imageURL,
                  isActive: user.wasRecentlyActive(),
                  isSelected: _pageProvider.selectedUsers.contains(user),
                  onTap: () {
                    _pageProvider.updateSelectedUsers(user);
                  },
                );
              },
            );
          } else {
            return Center(
              child: Text(
                "No Users Found.",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        } else {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        }
      }(),
    );
  }

  Widget _createChatButton() {
    return Visibility(
      visible: _pageProvider.selectedUsers.isNotEmpty,
      child: RoundedButton(
        name:
            _pageProvider.selectedUsers.length == 1
                ? "Chat With ${_pageProvider.selectedUsers.first.name}"
                : "Create Group Chat",
        height: _deviceHeight * 0.08,
        width: _deviceWidth * 0.8,
        onPressed: () {
          _pageProvider.createChat();
        },
      ),
    );
  }
}
