import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  static const routeName = '/edit-product-item';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  return FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  return FocusScope.of(context).requestFocus(_descFocusNode);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                focusNode: _descFocusNode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
