import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/resources/firestore_methods.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();
  TextEditingController _songController = TextEditingController();
  TextEditingController _captionController = TextEditingController();
  TextEditingController _otherController = TextEditingController();
  double conditionnumber = 50.0;
  DateTime fromDate = DateTime.now();
  double recomend = 3;
  String isSelectedItem = '日常';

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('アップロード'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('写真を撮る'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('フォルダから選択'),
                onPressed: () async {
                  Navigator.pop(context);

                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                    print('OK');
                  });

                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("戻る"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        _otherController.text,
        conditionnumber,
        fromDate,
        recomend,
        isSelectedItem,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'アップロード完了!',
        );
        clearImage();
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _otherController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return _file == null
        ? Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.6,
        child: Center(
          child: ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(brownColor)),
                  onPressed: () => _selectImage(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.upload,color: Colors.black,),
                Text('画像をアップロード',style: TextStyle(color: Colors.black),)
              ],
            ),
          ),
        ),
      )
    )
        : Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: clearImage,
        ),
        title: const Text(
          'アップロード',
        ),
        centerTitle: false,
        actions: <Widget>[
          TextButton(
            onPressed: () => postImage(
              userProvider.getUser.uid,
              userProvider.getUser.username,
              userProvider.getUser.photoUrl,
            ),
            child: const Text(
              "Post",
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          )
        ],
      ),
      // POST FORM
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            isLoading
                ? const LinearProgressIndicator()
                : const Padding(padding: EdgeInsets.only(top: 0.0)),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    userProvider.getUser.photoUrl,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                        hintText: "タイトルを入力して下さい",
                        border: InputBorder.none),
                    maxLines: 8,
                  ),
                ),
                SizedBox(
                  height: 45.0,
                  width: 45.0,
                  child: AspectRatio(
                    aspectRatio: 487 / 451,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                            image: MemoryImage(_file!),
                          )),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.1,
            //   width: MediaQuery.of(context).size.width * 0.7,
            //   child: TextField(
            //     controller: _songController,
            //     decoration: const InputDecoration(
            //         hintText: "詳細を入力",
            //         border: InputBorder.none),
            //     maxLines: 8,
            //   ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                controller: _otherController,
                decoration: const InputDecoration(
                    hintText: "その他を入力",
                    border: InputBorder.none),
                maxLines: 8,
              ),
            ),
            Text(
              'ご機嫌 : ${conditionnumber.toInt()}%',
              style: TextStyle(fontSize: 20, color: Colors.white70),
            ),
            Slider(
              value: conditionnumber.toDouble(),
              max: 100,
              min: 0,
              inactiveColor: Colors.grey[500],
              activeColor: Colors.white,
              onChanged: (val) {
                setState(() {
                  conditionnumber = val;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            buildForm(),
            SizedBox(
              height: 30,
            ),
            buildRecomendWidget(),
            SizedBox(height: 30,),
            buildSearnWidget(),
          ],
        ),
      ),
    );
  }

  Center buildSearnWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //3
          DropdownButton(
            //4
            items: const [
              //5
              DropdownMenuItem(
                child: Text('日常'),
                value: '日常',
              ),
              DropdownMenuItem(
                child: Text('お出かけ'),
                value: 'お出かけ',
              ),
              DropdownMenuItem(
                child: Text('旅行'),
                value: '旅行',
              ),
            ],
            //6
            onChanged: (String? value) {
              setState(() {
                isSelectedItem = value!;
              });
            },
            //7
            value: isSelectedItem,
          ),
        ],
      ),
    );
  }


  Column buildRecomendWidget() {
    return Column(
      children: [
        Text('おすすめ度'),
        RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.recommend_outlined,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              recomend = rating;
            });
          },
        ),
      ],
    );
  }

  Widget buildForm() => buildHeader(
    header: '日時：',
    child: Row(
      children: [
        Expanded(
            child: buildDropdownField(
                text: DateFormat('M月d日').format(fromDate),
                onClicked: () => pickFromDateTime(pickDate: true))),
        Expanded(
            child: buildDropdownField(
                text: DateFormat('HH時MM分').format(fromDate),
                onClicked: () => pickFromDateTime(pickDate: false)))
      ],
    ),
  );

  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          child
        ],
      );
  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;
    setState(() => fromDate = date);
  }

  Future<DateTime?> pickDateTime(
      DateTime initialDate, {
        required bool pickDate,
        DateTime? firstDate,
      }) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2018),
          lastDate: DateTime(2050));
      if (date == null) return null;
      final time =
      Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if (timeOfDay == null) return null;

      final date =
      DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

}