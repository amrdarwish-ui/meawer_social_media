import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/models/current_user_posts/CurrentUserPosts.dart';
import 'package:task/modules/edit_profiile/edit_profiile.dart';
import 'package:task/modules/login/login.dart';
import 'package:task/servces/image_upload.dart';
import 'package:task/servces/shared_prefs.dart';
import 'package:task/shared/Components/ask_alert_dialog.dart';
import 'package:task/shared/Components/my_button.dart';
import 'package:task/shared/Components/upload_image_dialog.dart';
import 'package:task/styles/styles.dart';

class ProfileBody extends StatefulWidget {
  ProfileBody(
      {Key? key,
      required this.userId,
      required this.isCurrentUserProfile,
      required this.size,
      required this.coverUrl,
      required this.imageUrl,
      required this.email,
      required this.phone,
      required this.name,
      required this.folllowers,
      required this.following,
      required this.posts})
      : super(key: key);

  final Size size;
  String userId;
  String coverUrl;
  String imageUrl;
  String email;
  String phone;
  String name;
  int folllowers;
  int following;
  int posts;
  bool isCurrentUserProfile;

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  ImageUpload imageUpload = ImageUpload();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: widget.size.height * 0.3,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return UploadImagDialog(onTap: () {
                      imageUpload.uploadCoverImage();
                      Navigator.pop(context);
                    });
                  },
                );
              },
              child: Container(
                width: double.infinity,
                height: widget.size.height * 0.22,
                color: Colors.blueGrey[200],
                child: Image.network(
                  widget.coverUrl == ''
                      ? "https://img.freepik.com/free-photo/blue-teal-brush-stroke-textured-background_53876-88469.jpg?size=626&ext=jpg"
                      : widget.coverUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: widget.size.height * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                )),
            Positioned(
                bottom: widget.size.height * 0.03333,
                right: (widget.size.width / 2) - widget.size.width * 0.128,
                left: (widget.size.width / 2) - widget.size.width * 0.128,
                child: Container(
                  height: widget.size.height * 0.13333,
                  width: widget.size.height * 0.13333,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return UploadImagDialog(onTap: () {
                            imageUpload.uploadProfileImage();
                            Navigator.pop(context);
                          });
                        },
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Container(
                        height: (widget.size.height * 0.13333),
                        width: (widget.size.height * 0.13333),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CircleAvatar(
                              backgroundColor: Colors.teal[100],
                              backgroundImage: widget.imageUrl == ''
                                  ? NetworkImage(
                                      "https://upload.wikimedia.org/wikipedia/commons/4/41/Profile-720.png")
                                  : NetworkImage(widget.imageUrl)),
                        ),
                      ),
                    ),
                  ),
                )),
            Positioned(
                bottom: 0,
                right: (widget.size.width / 2) - widget.size.width * 0.4,
                left: (widget.size.width / 2) - widget.size.width * 0.4,
                child: Center(
                  child: Container(
                    child: Text(
                      "${widget.name}",
                      style: titlesStyle(context),
                    ),
                  ),
                )),
            Positioned(
                bottom: 0,
                left: 10,
                child: widget.isCurrentUserProfile
                    ? MyButtonCyanLight(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfile(
                                  name: widget.name,
                                  phone: int.parse(widget.phone),
                                ),
                              ));
                        },
                        txt: 'edit profile',
                      )
                    : Container()),
            Positioned(
                bottom: 0,
                right: 10,
                child: widget.isCurrentUserProfile
                    ? Container()
                    : MyButtonCyanLight(
                        onPressed: () {},
                        txt: 'follow',
                      )),
          ],
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.teal[100],
                borderRadius: BorderRadius.circular(50)),
            alignment: Alignment.center,
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: widget.size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person_outline),
                            Container(
                              child: Text(
                                "followers : ${widget.folllowers}",
                                style: titlesStyle(context),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.person),
                            Container(
                              child: Text(
                                "following : ${widget.following}",
                                style: titlesStyle(context),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.receipt_long),
                        Container(
                          child: Text(
                            "Meaws:${widget.posts}",
                            style: titlesStyle(context),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Icon(Icons.email_outlined),
                          Text(
                            "Email : ${widget.email}",
                            style: titlesStyle(context),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Icon(Icons.phone_outlined),
                          Container(
                            child: Text(
                              "Phone : ${widget.phone}",
                              style: titlesStyle(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: MyButtonViewPosts(
                              txt: 'veiw Meaws',
                              onPressed: () {
                                print(widget.email);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CurrentUserPosts(
                                        vistUserid: widget.userId,
                                      ),
                                    ));
                              }),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: widget.isCurrentUserProfile
                                ? MyButtonCyan(
                                    txt: 'Logout',
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AskAlertDialog(
                                            yesFunction: () async {
                                              SharedPrefs prefs = SharedPrefs();
                                              prefs.clear();
                                              await FirebaseAuth.instance
                                                  .signOut();
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage(),
                                                  ),
                                                  (route) => false);
                                            },
                                          );
                                        },
                                      );
                                    })
                                : Container()),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
