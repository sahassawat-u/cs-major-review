import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/data/tags_data.dart';
import 'package:cs_major_review/data/uni_data.dart';
import 'package:cs_major_review/providers/unis_provider.dart';
import 'package:cs_major_review/widgets/clickable_tag.dart';
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
  List<String> unis = [];
  List<String> displayedUnis = [];
  List<String> tags = allTags;
  List<bool> flagUnis = [];
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    unis = context.read<UniProvider>().getUniNames();
    displayedUnis = context.read<UniProvider>().getUniNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: ListView(
            shrinkWrap: true,
            children: [
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
                  ? displayedUnis.length != 0
                      ? Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var uni in displayedUnis.sublist(
                                  0,
                                  displayedUnis.length <= 4
                                      ? displayedUnis.length
                                      : 5))
                                GestureDetector(
                                  onTap: () {
                                    if (!context
                                        .read<TagProvider>()
                                        .containUniTag(uni)) {
                                      setState(() {
                                        context
                                            .read<TagProvider>()
                                            .addUniTag(uni);
                                        unis.remove(uni);
                                        displayedUnis.remove(uni);
                                        this.query = '';
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
                child: Wrap(
                    children: List.generate(
                        context.read<TagProvider>().uniTags.length, (index) {
                  final uniTags = context.read<TagProvider>().uniTags;
                  // });
                  print(uniTags);
                  return ClickableTag(
                      text: uniTags[index],
                      isSelected: true,
                      onTap_: () {
                        unis.add(uniTags[index]);
                        context
                            .read<TagProvider>()
                            .removeUniTag(uniTags[index]);
                        setState(() {});
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
                child: Wrap(
                    children: List.generate(tags.length, (index) {
                  return ClickableTag(
                      text: tags[index],
                      isSelected: context
                          .read<TagProvider>()
                          .containsCourseTag(tags[index]),
                      onTap_: () {
                        if (!context
                            .read<TagProvider>()
                            .containsCourseTag(tags[index])) {
                          setState(() {});
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
                          Navigator.pop(context);
                        },
                        child: Text("Apply", style: TextStyle()),
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all(kForegroundColor1),
                          side: MaterialStateProperty.all(
                              const BorderSide(color: kForegroundColor2)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            unis = allUnis;
                            tags = allTags;
                            context.read<TagProvider>().reset();
                          });
                        },
                        child: Text("Reset", style: TextStyle()),
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all(kForegroundColor1),
                          side: MaterialStateProperty.all(
                              const BorderSide(color: kForegroundColor2)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  void searchUni(String query) {
    final unis = this.unis.where((uni) {
      final name = uni.toLowerCase();
      final search = query.toLowerCase();
      return name.contains(search);
    }).toList();
    setState(() {
      this.query = query;
      this.displayedUnis = unis;
    });
  }
}
