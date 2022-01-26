import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/modules/profile/profile.dart';
import 'package:task/shared/Components/delete_post_bottom_sheet.dart';
import 'package:task/styles/styles.dart';

class CustomPost extends StatelessWidget {
  CustomPost(
      {Key? key,
      required this.isInfollowerVeiw,
      required this.userId,
      required this.body,
      required this.postId,
      required this.comments,
      required this.imageUrl,
      required this.likes,
      required this.name,
      required this.time,
      required this.imageName,
      required this.userUrl,
      required this.showOnlyCurrentUSerPosts})
      : super(key: key);
  String userUrl;
  String userId;
  String postId;
  String name;
  String imageName;
  String time;
  String body;
  String imageUrl;
  int likes;
  int comments;
  bool showOnlyCurrentUSerPosts;
  bool isInfollowerVeiw;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            leading: GestureDetector(
              onTap: isInfollowerVeiw
                  ? () {}
                  : () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile(
                                isCurrentUserProfile: false,
                                vistUserID: userId),
                          ));
                    },
              child: CircleAvatar(
                backgroundColor: Colors.cyan[100],
                backgroundImage: userUrl == ''
                    ? NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/4/41/Profile-720.png")
                    : NetworkImage(userUrl),
              ),
            ),
            trailing: showOnlyCurrentUSerPosts
                ? IconButton(
                    onPressed: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return DeletePostBottomSheet(
                              postId: postId, imageName: imageName);
                        },
                      );
                    },
                    icon: Icon(Icons.expand_less))
                : Container(
                    height: 1,
                    width: 1,
                    color: Colors.white,
                  ),
            title: Text(
              name,
              style: titlesStyle(context),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: Text(
              time,
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.grey[350], fontSize: 10),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            alignment: body[0].toString().codeUnits[0] > 126
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Text("""${body}"""),
          ),
          imageUrl == '' ? Container() : Image.network(imageUrl),
          Divider(
            color: Colors.cyan,
            height: 0,
          ),
          Container(
            height: size.height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite),
                        SizedBox(
                          width: 10,
                        ),
                        Text(likes.toString())
                      ],
                    ),
                  ),
                ),
                RotatedBox(
                  quarterTurns: 1,
                  child: Divider(
                    color: Colors.cyan,
                    height: 0,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.comment),
                        SizedBox(
                          width: 10,
                        ),
                        Text(comments.toString())
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
