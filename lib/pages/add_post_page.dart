import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/data/tags_data.dart';
import 'package:cs_major_review/data/uni_data.dart';
import 'package:cs_major_review/models/forum_model.dart';
import 'package:cs_major_review/providers/tags_provider.dart';
import 'package:cs_major_review/widgets/clickable_tag.dart';
import 'package:cs_major_review/widgets/search.dart';
import 'package:cs_major_review/widgets/search_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/base_card.dart';

class AddPostPage extends StatefulWidget {
  final List<Forum> forums;
  const AddPostPage({Key? key, required this.forums}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  late String title;
  late String comment;
  String query = "";
  String uni = '';
  List<String> unis = allUnis;
  TextEditingController controller = TextEditingController();
  List<String> tags = allTags;
  List<bool> flagList = List.filled(allTags.length, false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kStar,
      ),
      body: Container(
        // margin: EdgeInsets.symmetric(horizontal: 30),
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
                child: BaseCard(
              theColor: Colors.white,
              theBorderColor: Colors.white,
              theChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text("Forum Title"),
                  ),
                  Container(
                    child: TextField(
                      onChanged: (value) {
                        title = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter the Title",
                      ),
                    ),
                  )
                ],
              ),
            )),
            Row(
              children: [
                Text(
                  "University",
                  textAlign: TextAlign.start,
                  // style: TextStyle(
                  //   fontSize: 18,
                  //   fontWeight: FontWeight.w600,
                  // ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Search(
              controller: controller,
              isUsedIcon: true,
              text: "",
              onChanged: searchUni,
              hintText: "Search for university",
            ),
            query.isNotEmpty
                ? unis.isNotEmpty
                    ? Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var uni in unis.sublist(
                                0, unis.length <= 5 ? unis.length : 6))
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    this.uni = uni;
                                    unis.remove(uni);
                                    allUnis.remove(uni);
                                    this.query = '';
                                  });
                                  controller.clear();
                                },
                                child: Text(
                                  uni,
                                ),
                              )
                          ],
                        ))
                    : Text("No match found", textAlign: TextAlign.center)
                : Text(""),
            Text(
              '$uni',
              textAlign: TextAlign.center,
            ),
            Row(children: [
              Text(
                "Course",
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
            ]),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              // height: 320,
              child: Wrap(
                  children: List.generate(tags.length, (index) {
                // print();
                return ClickableTag(
                    text: tags[index],
                    // isSelected: toBeUsedTags.contains(tags[index]),
                    isSelected: flagList[index],
                    onTap_: () {
                      setState(() {
                        flagList[index] = !flagList[index];
                      });
                    });
              })),
            ),
            Container(
                child: BaseCard(
              theColor: Colors.white,
              theBorderColor: Colors.white,
              theChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text("Your forum"),
                  ),
                  Container(
                    child: BaseCard(
                      theColor: Colors.white,
                      theBorderColor: kFontColor,
                      theChild: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: TextField(
                            onChanged: (value) {
                              comment = value;
                            },
                            minLines:
                                6, // any number you need (It works as the rows for the textarea)
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "Write your forum here...",
                            )),
                      ),
                    ),
                  )
                ],
              ),
            )),
            // Spacer(flex:2),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    final newTags = tags
                        .where((element) => flagList[tags.indexOf(element)])
                        .toList();
                    if (uni.isNotEmpty) {
                      newTags.add(uni + " Uni.");
                    }
                    widget.forums.add(Forum(
                        topic: title,
                        user: "Tester",
                        createdBy: "Fri Jul 8 2022",
                        comment: comment,
                        num: 0,
                        discussions: [],
                        tags: newTags));
                    print("submitted $title, $comment, $newTags, $uni ");
                    Navigator.of(context).pop();
                  },
                  child: Text("Submit Your forum"),
                  style: ElevatedButton.styleFrom(primary: kStar),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void searchUni(String query) {
    final unis = allUnis.where((uni) {
      final name = uni.toLowerCase();
      final search = query.toLowerCase();
      return name.contains(search);
    }).toList();
    setState(() {
      this.query = query;
      this.unis = unis;
    });
  }
}
