import 'package:device_shop_firebase/ui/tab_box/card/card_info.dart';
import 'package:device_shop_firebase/view_models/orders_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card"),
      ),
      body: Consumer<OrdersViewModel>(
        builder: (context, orderViewModel, child) {
          return ListView(
            children: List.generate(orderViewModel.userOrders.length, (index) {
              var order = orderViewModel.userOrders[index];
              return ListTile(
                title: Text(order.productName),
                onTap: () {
                  orderViewModel.getSingleOrder(order.orderId);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => CardInfo()));
                },
                trailing: Text("Count:${order.count}"),
              );
            }),
          );
        },
      ),
    );
  }
}
