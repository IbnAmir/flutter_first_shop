import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    // final ordersData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future:
                Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
            builder: (ctx,dataSnapshot){
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // else {
              //   if (dataSnapshot.connectionState == null ) {
              //     //TODO: error handling if needed
              //     return const Center(child: Text('There is no order placed yet \n :('),);
              //   }
                else {
                  return
                    Provider.of<Orders>(context).orders.isEmpty
                      ? const Center(
                          child: Text(
                            'No orders have been placed \n :\'(',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      :
                    Consumer<Orders>(
                      builder: (ctx, orderData, child) =>
                          ListView.builder(
                            itemCount: orderData.orders.length,
                            itemBuilder: (ctx, i) =>
                                OrderItem(
                                  orderData.orders[i],
                                ),
                          ),
                    );

              }
            },
        ),
        // _isLoading
        //   ? const Center(
        //       child: CircularProgressIndicator(),
        //     )
        //   : ordersData.orders.isEmpty
        //       ? const Center(
        //           child: Text(
        //             'No orders have been placed \n :\'(',
        //             style: TextStyle(
        //               fontSize: 20,
        //               fontWeight: FontWeight.bold,
        //             ),
        //             textAlign: TextAlign.center,
        //           ),
        //         )
        //       : ListView.builder(
        //           itemCount: ordersData.orders.length,
        //           itemBuilder: (ctx, i) => OrderItem(
        //             ordersData.orders[i],
        //           ),
        //         ),
        );
  }
}
