import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final controller = TextEditingController();
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
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        decoration: InputDecoration(
          icon: const Icon(Icons.search, color: Color(0xff0B302C)),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: const Icon(Icons.close, color: Color(0xff0B302C)),
                  onTap: () {
                    controller.clear();
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
