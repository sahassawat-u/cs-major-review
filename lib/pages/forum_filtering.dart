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
  // List<String> uniTags = [];
  // @override
  // void initState() {
  //   super.initState();
  // }
  TextEditingController controller = TextEditingController();

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
                controller: controller,
                isUsedIcon: true,
                text: query,
                onChanged: searchUni,
                hintText: "Search for university",
              ),
              query.isNotEmpty
                  ? unis.length != 0
                      ? Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var uni in unis.sublist(
                                  0, unis.length < 5 ? unis.length : 6))
                                GestureDetector(
                                  onTap: () {
                                    if (!context
                                        .read<TagProvider>()
                                        .contains(uni + " Uni.")) {
                                      setState(() {
                                        context
                                            .read<TagProvider>()
                                            .addTag(uni + " Uni.");
                                        allUnis.remove(uni);
                                        unis.remove(uni);
                                      });
                                      controller.clear();
                                    }
                                  },
                                  child: Text(
                                    uni,
                                  ),
                                )
                            ],
                          ))
                      : Text("No match found", textAlign: TextAlign.center)
                  : Text(""),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                // height: 320,
                child: Wrap(
                    children: List.generate(
                        Provider.of<TagProvider>(context, listen: false)
                            .tags
                            .where((element) => element.contains("Uni"))
                            .toList()
                            .length, (index) {
                  final uniTags =
                      Provider.of<TagProvider>(context, listen: false)
                          .tags
                          .where((element) => element.contains("Uni"))
                          .toList();
                  return ClickableTag(
                      text: uniTags[index],
                      isSelected: true,
                      onTap_: () {
                        setState(() {
                          allUnis.add(uniTags[index].split(" ")[0]);
                          context.read<TagProvider>().removeTag(uniTags[index]);
                        });
                      });
                })),
              ),
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
