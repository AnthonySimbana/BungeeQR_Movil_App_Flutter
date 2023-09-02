import 'package:flutter/material.dart';

class BarraBusquedaWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function onSearch;
  final Function onClear;

  const BarraBusquedaWidget({
    required this.controller,
    required this.onSearch,
    required this.onClear,
  });

  @override
  _BarraBusquedaWidget createState() => _BarraBusquedaWidget();
}

class _BarraBusquedaWidget extends State<BarraBusquedaWidget> {
  bool _isSearching = false;

  void _onTextChanged(String text) {
    setState(() {
      _isSearching = text.isNotEmpty;
    });
    widget.onSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      //color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: 'Buscar',
                suffixIcon: IconButton(
                  onPressed: () {
                    widget.controller.clear();
                    widget.onClear();
                    setState(() {
                      _isSearching = false;
                    });
                  },
                  icon: _isSearching
                      ? const Icon(Icons.cancel)
                      : const Icon(Icons.search),
                ),
                border: const OutlineInputBorder(),
              ),
              onChanged: _onTextChanged,
            ),
          ),
        ],
      ),
    );
  }
}
