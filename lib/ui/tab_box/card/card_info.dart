import 'package:device_shop_firebase/view_models/orders_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Card info"),
        ),
        body: Consumer<OrdersViewModel>(
          builder: (context, orderViewModel, child) {
            if (orderViewModel.orderModelForInfo != null) {
              var order = orderViewModel.orderModelForInfo!;
              return Column(
                children: [
                  Text(order.orderStatus),
                  Text(order.createdAt),
                  Text(order.count.toString()),
                  Text(order.totalPrice.toString()),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
