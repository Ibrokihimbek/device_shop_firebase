import 'package:device_shop_firebase/data/models/order_model.dart';
import 'package:device_shop_firebase/data/models/product_model.dart';
import 'package:device_shop_firebase/view_models/orders_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key, required this.productModel}) : super(key: key);
  final ProductModel productModel;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Info page"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Card(
              color: Colors.deepPurple.shade800.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Mahsulot nomi",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.productModel.productName,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Card(
              color: Colors.deepPurple.shade800.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                      child: Text(
                    "Mahsulot narxi",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  )),
                  Text(
                    widget.productModel.price.toString(),
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.productModel.currency.toString(),
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Card(
              color: Colors.deepPurple.shade800.withOpacity(0.4),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                      child: Text(
                    "Mahsulot haqida ma'lumot",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.productModel.description.toString(),
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Card(
              color: Colors.deepPurple.shade800.withOpacity(0.4),
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 18.0),
                      child: Text(
                        "Mahsulot soni",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      width: 115,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.deepPurple.shade800.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(60)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: Colors.red.withOpacity(0.4)),
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey.withOpacity(0.4)),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  if (count > 1) {
                                    count--;
                                  }
                                });
                              },
                              child: const Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "${count}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 26,
                                color: Colors.white),
                          ),
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: Colors.red.withOpacity(0.4)),
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey.withOpacity(0.4)),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  count++;
                                });
                              },
                              child: const Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: widget.productModel.productImages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(
                        top: 6, left: 4, right: 4, bottom: 6),
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                              topRight: Radius.circular(12),
                              topLeft: Radius.circular(12),
                            ),
                            image: DecorationImage(
                                image: NetworkImage(
                                    widget.productModel.productImages[index]),
                                fit: BoxFit.fill,
                                scale: 6),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  List<OrderModel> orders =
                      Provider.of<OrdersViewModel>(context, listen: false)
                          .userOrders;

                  List<OrderModel> exists = orders
                      .where(
                          (e) => e.productId == widget.productModel.productId)
                      .toList();

                  if (exists.isNotEmpty) {
                    orders.forEach((element) {
                      if (element.productId == widget.productModel.productId) {
                        Provider.of<OrdersViewModel>(context, listen: false)
                            .updateOrderIfExists(
                                productId: element.productId, count: count);
                      }
                    });
                  } else {
                    Provider.of<OrdersViewModel>(context, listen: false)
                        .addOrder(
                      OrderModel(
                          count: count,
                          totalPrice: widget.productModel.price * count,
                          orderId: "",
                          productId: widget.productModel.productId,
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          orderStatus: "ordered",
                          createdAt: DateTime.now().toString(),
                          productName: widget.productModel.productName),
                    );
                  }
                  Navigator.pop(context);
                },
                child: Text("Add to card"))
          ],
        ),
      ),
    );
  }
}
