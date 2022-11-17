import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myshop/models/order.dart';
import 'package:myshop/ui/cart/cart_manager.dart';
import 'package:myshop/ui/orders/orders_manager.dart';
import 'package:provider/provider.dart';

import '../shared/dialog_utils.dart';
import '../widgets/post_app_bar.dart';

class FormScreen extends StatefulWidget {
  static const routeName = '/form-info';

  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  late String _name;
  late String _email;
  late String _numberphone;
  late String _note;

  bool showFavoriteIcon = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Tên'),
      maxLength: 20,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vui lòng điền tên của bạn!';
        }

        return null;
      },
      onSaved: (value) {
        _name = value!;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vui lòng điền email của bạn!';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Vui lòng kiểm tra lại email của bạn!';
        }

        return null;
      },
      onSaved: (value) {
        // order = order.copyWith(email: value!);
        _email = value!;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Số điện thoại'),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vui lòng điền số điện thoại của bạn!';
        }

        return null;
      },
      onSaved: (value) {
        _numberphone = value!;

        // order = order.copyWith(numberphone: value!);
      },
    );
  }

  Widget _buildNote() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Ghi chú'),
      validator: (value) {
        return null;
      },
      onSaved: (value) {
        // order = order.copyWith(note: value!);
        _note = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<CartManager>().products;
    var prodName = [];

    for (var element in products) {
      prodName.add(element.title);
    };

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: Container(
            margin: const EdgeInsets.only(top: 50),
            child: PostAppBar(false, showFavoriteIcon)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                _buildEmail(),
                _buildPhoneNumber(),
                _buildNote(),
                const SizedBox(height: 100),
                ElevatedButton(
                  child: const Text(
                    'Gửi',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    _formKey.currentState?.save();

                    final order = Order(
                        name: _name,
                        numberphone: _numberphone,
                        email: _email,
                        note: _note,
                        product: prodName.toString());

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Cảm ơn, chúng tôi sẽ liên lạc sớm nhất với bạn qua email hoặc số điện thoại',
                          ),
                          duration: Duration(seconds: 5),
                        ),
                      );

                    //Send to API
                    try {
                      final orderManager = context.read<OrderManager>();
                      await orderManager.addOrder(order);
                    } catch (error) {
                      // print(error);
                      await showErrorDialog(context, 'Something went wrong.');
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('_email', _email));
  }
}
