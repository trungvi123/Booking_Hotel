// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../shared/dialog_utils.dart';

import '../widgets/post_app_bar.dart';
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
        bathroom: 0,
        bedroom: 0,
        quantityPerson: 0,
        types: '',
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
  final List typeSelect = [];
  var _isLoading = false;

  final checkBoxList = [
    
  ];

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

    checkBoxList.add(CheckBoxModal(
        titleCheckBox: 'Sang trọng',
        value: _editedProduct.types.contains('Sang trọng')));
    checkBoxList.add(CheckBoxModal(
        titleCheckBox: 'Gia đình',
        value: _editedProduct.types.contains('Gia đình')));
    checkBoxList.add(CheckBoxModal(
        titleCheckBox: 'Cặp đôi',
        value: _editedProduct.types.contains('Cặp đôi')));
    checkBoxList.add(CheckBoxModal(
        titleCheckBox: 'Giá rẻ',
        value: _editedProduct.types.contains('Giá rẻ')));
    checkBoxList.add(CheckBoxModal(
        titleCheckBox: 'Gần biển',
        value: _editedProduct.types.contains('Gần biển')));

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
    _editedProduct = _editedProduct.copyWith(types: typeSelect.toString());

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: Container(
            margin: const EdgeInsets.only(top: 50),
            child: const PostAppBar(false, false)),
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
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Loại',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        ...checkBoxList.map((item) => Row(
                              children: [
                                Checkbox(
                                  value: item.value,
                                  onChanged: (value) {
                                    setState(() {
                                      item.value = !item.value;
                                      if (value == true) {
                                        typeSelect.add(item.titleCheckBox);
                                      } else {
                                        typeSelect.remove(item.titleCheckBox);
                                      }
                                    });
                                  },
                                ),
                                Text(
                                  item.titleCheckBox,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ],
                            ))
                      ],
                    ),
                    buildTitleField(),
                    buildPriceField(),
                    buildDescriptionField(),
                    buildProductPreview(1),
                    buildProductPreview(2),
                    buildProductPreview(3),
                    buildProductPreview(4),
                    buildBedroomField(),
                    buildBathroomField(),
                    buildQuantityPersonField(),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: IconButton(
          icon: const Icon(Icons.save),
          onPressed: _saveForm,
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

  TextFormField buildBedroomField() {
    return TextFormField(
      initialValue: _editedProduct.bedroom.toString(),
      decoration: const InputDecoration(labelText: 'Bedroom'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the number of bedrooms.';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number.';
        }
        if (int.parse(value) <= 0) {
          return 'Please enter a number greater than zero';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(bedroom: int.parse(value!));
      },
    );
  }

  TextFormField buildBathroomField() {
    return TextFormField(
      initialValue: _editedProduct.bathroom.toString(),
      decoration: const InputDecoration(labelText: 'Bathroom'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the number of bathrooms.';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number.';
        }
        if (int.parse(value) <= 0) {
          return 'Please enter a number greater than zero';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(bathroom: int.parse(value!));
      },
    );
  }

  TextFormField buildQuantityPersonField() {
    return TextFormField(
      initialValue: _editedProduct.quantityPerson.toString(),
      decoration: const InputDecoration(labelText: 'Person'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the number of people.';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter a valid number.';
        }
        if (int.parse(value) <= 0) {
          return 'Please enter a number greater than zero';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct =
            _editedProduct.copyWith(quantityPerson: int.parse(value!));
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
    // ignore: no_leading_underscores_for_local_identifiers
    final _imageUrlControllerText;
    // ignore: no_leading_underscores_for_local_identifiers
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

class CheckBoxModal {
  String titleCheckBox;
  bool value;

  CheckBoxModal({required this.titleCheckBox, this.value = false});
}
