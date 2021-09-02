import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              child: TextField(
                  decoration: InputDecoration(
                hintText: 'Enter name',
              )),
            ),
          ),
        ],
      ),
    );
  }
}
