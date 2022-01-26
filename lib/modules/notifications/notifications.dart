import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              height: 100,
              alignment: Alignment.center,
              color: Colors.cyan[50],
              child: ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.cyan[100],
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 33,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  index.isEven ? "Ahmed" : "Amr",
                ),
                subtitle: Text(index.isEven
                    ? "commented on your post"
                    : "liked your post"),
              ),
            ),
            Divider(
              color: Colors.cyan,
              height: 0,
              thickness: 0.7,
            )
          ],
        );
      },
    );
  }
}
