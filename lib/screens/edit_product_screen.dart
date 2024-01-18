// ignore_for_file: unnecessary_null_comparison, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/products.dart';
import 'package:shopping_app/theme/size_box.dart';
import '../providers/product_provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  static const routeName = '/edit-product-item';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _editProduct = Product(
    id: '',
    title: '',
    description: '',
    imageUrl: '',
    price: 0,
  );
  bool _isInit = true;
  var _initValue = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': ''
  };

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments as String;
      if (productId != null) {
        _editProduct = Provider.of<ProductProviders>(
          context,
          listen: false,
        ).findById(productId);
        _initValue = {
          'title': _editProduct.title,
          'description': _editProduct.description,
          'price': _editProduct.price.toString(),
          //'imageUrl': _editProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editProduct.imageUrl;
      }
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImage);
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImage() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final validate = _formKey.currentState?.validate();
    if (!validate!) {
      return;
    } else {
      _formKey.currentState?.save(); // will auto save
    }

    if (_editProduct.id != null) {
      Provider.of<ProductProviders>(
        context,
        listen: false,
      ).updateProduct(
        _editProduct,
        _editProduct.id,
      );
    } else {
      Provider.of<ProductProviders>(
        context,
        listen: false,
      ).addProduct(_editProduct);
    }
    Navigator.of(context).pop();
    // print(_editProduct.title);
    // print(_editProduct.imageUrl);

    // print(_editProduct.description);

    // print(_editProduct.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editing'),
        actions: <Widget>[
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(
              Icons.save_alt,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValue['title'],
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  return FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Value';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _editProduct = Product(
                    id: _editProduct.id,
                    isFavorite: _editProduct.isFavorite,
                    title: newValue!,
                    description: _editProduct.description,
                    imageUrl: _editProduct.imageUrl,
                    price: _editProduct.price,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValue['price'],
                decoration: const InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter
                      .digitsOnly, //as per this will accept the digit only
                ],
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  return FocusScope.of(context).requestFocus(_descFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Price';
                  }
                  if (double.tryParse(value) == null) {
                    return "Invalid Number";
                  }
                  if (double.parse(value) <= 0) {
                    return "Enter Valid Number";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _editProduct = Product(
                    id: _editProduct.id,
                    isFavorite: _editProduct.isFavorite,
                    title: _editProduct.title,
                    description: _editProduct.description,
                    imageUrl: _editProduct.imageUrl,
                    price: double.parse(newValue!),
                  );
                },
              ),
              TextFormField(
                initialValue: _initValue['description'],
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                focusNode: _descFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Description';
                  }
                  if (value.length <= 10) {
                    return 'Enter Detailed Description';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _editProduct = Product(
                    id: _editProduct.id,
                    isFavorite: _editProduct.isFavorite,
                    title: _editProduct.title,
                    description: newValue!,
                    imageUrl: _editProduct.imageUrl,
                    price: _editProduct.price,
                  );
                },
              ),
              sizedBox(10, 0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.blueGrey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Enter Url')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.contain,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      //initialValue: _initValue['imageUrl'],
                      decoration: const InputDecoration(
                        labelText: 'Image URL',
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (value) => _saveForm(),
                      onSaved: (newValue) {
                        _editProduct = Product(
                          id: _editProduct.id,
                          isFavorite: _editProduct.isFavorite,
                          title: _editProduct.title,
                          description: _editProduct.description,
                          imageUrl: newValue!,
                          price: _editProduct.price,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
