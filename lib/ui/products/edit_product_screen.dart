import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../shared/dialog_utils.dart';

import 'products_manager.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  EditProductScreen(
    Product? product, {
    super.key,
  }) {
    if (product == null) {
      this.product = Product(
        title: '',
        description: '',
        price: 0,
        imageUrl: '',
        imageUrl2: '',
        imageUrl3: '',
        imageUrl4: '',
      );
    } else {
      this.product = product;
    }
  }

  late final Product product;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlController2 = TextEditingController();
  final _imageUrlController3 = TextEditingController();
  final _imageUrlController4 = TextEditingController();

  final _imageUrlFocusNode = FocusNode();
  final _imageUrlFocusNode2 = FocusNode();
  final _imageUrlFocusNode3 = FocusNode();
  final _imageUrlFocusNode4 = FocusNode();

  final _editForm = GlobalKey<FormState>();
  late Product _editedProduct;
  var _isLoading = false;

  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('.jpeg'));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        // Ảnh hợp lệ -> Vẽ lại màn hình để hiện preview
        setState(() {});
      }
    });
    _imageUrlFocusNode2.addListener(() {
      if (!_imageUrlFocusNode2.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController2.text)) {
          return;
        }
        // Ảnh hợp lệ -> Vẽ lại màn hình để hiện preview
        setState(() {});
      }
    });

    _imageUrlFocusNode3.addListener(() {
      if (!_imageUrlFocusNode3.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController3.text)) {
          return;
        }
        // Ảnh hợp lệ -> Vẽ lại màn hình để hiện preview
        setState(() {});
      }
    });

    _imageUrlFocusNode4.addListener(() {
      if (!_imageUrlFocusNode4.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController4.text)) {
          return;
        }
        // Ảnh hợp lệ -> Vẽ lại màn hình để hiện preview
        setState(() {});
      }
    });

    _editedProduct = widget.product;
    _imageUrlController.text = _editedProduct.imageUrl;
    _imageUrlController2.text = _editedProduct.imageUrl2;
    _imageUrlController3.text = _editedProduct.imageUrl3;
    _imageUrlController4.text = _editedProduct.imageUrl4;
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlController2.dispose();
    _imageUrlController3.dispose();
    _imageUrlController4.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode2.dispose();
    _imageUrlFocusNode3.dispose();
    _imageUrlFocusNode4.dispose();

    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final productsManager = context.read<ProductsManager>();
      if (_editedProduct.id != null) {
        await productsManager.updateProduct(_editedProduct);
      } else {
        await productsManager.addProduct(_editedProduct);
      }
    } catch (error) {
      await showErrorDialog(context, 'Something went wrong.');
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _editForm,
                child: ListView(
                  children: <Widget>[
                    buildTitleField(),
                    buildPriceField(),
                    buildDescriptionField(),
                    buildProductPreview(1),
                    buildProductPreview(2),
                    buildProductPreview(3),
                    buildProductPreview(4),
                  ],
                ),
              ),
            ),
    );
  }

  TextFormField buildTitleField() {
    return TextFormField(
      initialValue: _editedProduct.title,
      decoration: const InputDecoration(labelText: 'Title'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(title: value);
      },
    );
  }

  TextFormField buildPriceField() {
    return TextFormField(
      initialValue: _editedProduct.price.toString(),
      decoration: const InputDecoration(labelText: 'Price'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a price.';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number.';
        }
        if (double.parse(value) <= 0) {
          return 'Please enter a number greater than zero';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(price: double.parse(value!));
      },
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: _editedProduct.description,
      decoration: const InputDecoration(labelText: 'Description'),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a description.';
        }
        if (value.length < 10) {
          return 'Should be at least 10 characters long.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(description: value);
      },
    );
  }

  Widget buildProductPreview(int number) {
    final _imageUrlControllerText;
    final _imageUrlControllerTextIsEmpty;
    if (number == 1) {
      _imageUrlControllerText = _imageUrlController.text;
      _imageUrlControllerTextIsEmpty = _imageUrlController.text.isEmpty;
    } else if (number == 2) {
      _imageUrlControllerText = _imageUrlController2.text;
      _imageUrlControllerTextIsEmpty = _imageUrlController2.text.isEmpty;
    } else if (number == 3) {
      _imageUrlControllerText = _imageUrlController3.text;
      _imageUrlControllerTextIsEmpty = _imageUrlController3.text.isEmpty;
    } else {
      _imageUrlControllerText = _imageUrlController4.text;
      _imageUrlControllerTextIsEmpty = _imageUrlController4.text.isEmpty;
    }

    return Row(
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
              color: Colors.grey,
            ),
          ),
          child: _imageUrlControllerTextIsEmpty
              ? const Text('Enter a URL')
              : FittedBox(
                  child: Image.network(
                    _imageUrlControllerText,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Expanded(
          child: buildImageUrlField(number),
        ),
      ],
    );
  }

  TextFormField buildImageUrlField(int number) {
    final imageUrlFocusNode;
    final imageUrlController;
    if (number == 1) {
      imageUrlFocusNode = _imageUrlFocusNode;
      imageUrlController = _imageUrlController;
    } else if (number == 2) {
      imageUrlFocusNode = _imageUrlFocusNode2;
      imageUrlController = _imageUrlController2;
    } else if (number == 3) {
      imageUrlFocusNode = _imageUrlFocusNode3;
      imageUrlController = _imageUrlController3;
    } else {
      imageUrlFocusNode = _imageUrlFocusNode4;
      imageUrlController = _imageUrlController4;
    }

    return TextFormField(
      decoration: const InputDecoration(labelText: 'Image URL'),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: imageUrlController,
      focusNode: imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a image URL.';
        }
        if (!_isValidImageUrl(value)) {
          return 'Please enter a valid image URL.';
        }
        return null;
      },
      onSaved: (value) {
        if (number == 1) {
          _editedProduct = _editedProduct.copyWith(imageUrl: value);
        } else if (number == 2) {
          _editedProduct = _editedProduct.copyWith(imageUrl2: value);
        } else if (number == 3) {
          _editedProduct = _editedProduct.copyWith(imageUrl3: value);
        } else {
          _editedProduct = _editedProduct.copyWith(imageUrl4: value);
        }
      },
    );
  }
}
