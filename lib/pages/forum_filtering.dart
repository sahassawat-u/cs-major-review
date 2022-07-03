import 'package:cs_major_review/data/tags_data.dart';
import 'package:cs_major_review/data/uni_data.dart';
import 'package:cs_major_review/widgets/clickable_tag.dart';
import 'package:cs_major_review/widgets/filtered_top.dart';
import 'package:cs_major_review/widgets/search.dart';
import 'package:cs_major_review/providers/tags_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ForumFiltering extends StatefulWidget {
  const ForumFiltering({Key? key}) : super(key: key);

  @override
  State<ForumFiltering> createState() => _ForumFilteringState();
}

class _ForumFilteringState extends State<ForumFiltering> {
  String query = "";
  bool isSearch = false;
  List<String> unis = allUnis;
  List<String> tags = allTags;
  List<bool> flagList = List.filled(allTags.length, false);
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              SizedBox(height: 50),
              Row(
                children: [
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_outlined),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Text("Back")
                ],
              ),
              Row(
                children: [
                  Text(
                    "University",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Search(
                  text: query,
                  onChanged: searchUni,
                  hintText: "Search for university"),
              query != "" ? FilteredTop(uni: unis) : Text(""),
              const SizedBox(height: 15),
              // Container(
              //   width: double.infinity,
              //   child: Wrap(children: [
              //     ClickableTag(text: "Mahidol Uni."),
              //     ClickableTag(text: "Chulalongkorn Uni."),
              //     ClickableTag(text: "Kasetsart Uni."),
              //   ]),
              // ),
              const SizedBox(height: 20),
              Row(children: [
                Text(
                  "Course",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
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
                      isSelected:
                          context.read<TagProvider>().contains(tags[index]),
                      onTap_: () {
                        // setState() {
                        if (!context
                            .read<TagProvider>()
                            .contains(tags[index])) {
                          setState(() {});
                          // toBeUsedTags.add(tags[index]);
                          // context.read<Tag
                          context.read<TagProvider>().addTag(tags[index]);
                        } else {
                          setState(() {});
                          context.read<TagProvider>().removeTag(tags[index]);
                        }
                      });
                })),
              ),
              SizedBox(
                height: 150,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            // saveTags(this.toBeUsedTags);
                            Navigator.pop(context);
                          },
                          child: Text("Apply", style: TextStyle()),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            foregroundColor:
                                MaterialStateProperty.all(Color(0xff082D26)),
                            side: MaterialStateProperty.all(
                                BorderSide(color: Color(0xff122F2D))),
                            // padding: MaterialStateProperty.all(
                            //   EdgeInsets.symmetric(horizontal: 50),
                            // ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Reset", style: TextStyle()),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            foregroundColor:
                                MaterialStateProperty.all(Color(0xff082D26)),
                            side: MaterialStateProperty.all(
                                BorderSide(color: Color(0xff122F2D))),
                            // padding: MaterialStateProperty.all(
                            //   EdgeInsets.symmetric(horizontal: 50),
                            // ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          )),
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
