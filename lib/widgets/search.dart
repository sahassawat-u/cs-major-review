import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
    required this.isUsedIcon,
    required this.controller,
    // required this.isClearText
  }) : super(key: key);

  final TextEditingController controller;
  // final bool isClearText;
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;
  final bool isUsedIcon;
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xff0B302C),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(0),
      ),
      padding: widget.isUsedIcon
          ? EdgeInsets.symmetric(horizontal: 8)
          : EdgeInsets.only(left: 20),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          icon: widget.isUsedIcon
              ? const Icon(Icons.search, color: Color(0xff0B302C))
              : null,
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: const Icon(Icons.close, color: Color(0xff0B302C)),
                  onTap: () {
                    widget.controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          border: InputBorder.none,
          hintText: widget.hintText,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
