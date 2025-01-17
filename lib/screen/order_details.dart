import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sunpower/localization/AppLocal.dart';

class OrderDetailsPage extends StatelessWidget {
  final DocumentSnapshot order;

  OrderDetailsPage({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).trans("orderDetails")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              '${AppLocalizations.of(context).trans("orderId")}: ${order.id}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            buildDetailRow(AppLocalizations.of(context).trans('date'),order['date']),
            SizedBox(height: 8),
            buildDetailRow(AppLocalizations.of(context).trans('customer'),order['userName']),
            buildDetailRow(AppLocalizations.of(context).trans('address'),order['userAddress']),
            buildDetailRow(AppLocalizations.of(context).trans('phone'),order['userPhone']),
            Divider(
              color: Colors.grey[300],
            ),
            Text(
              '${AppLocalizations.of(context).trans('products')}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            ...order['productList'].map((product) {
              return Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text(product['itemCode'],style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12
                                  ),)),
                                ],
                              ),
                              Expanded(child: CachedNetworkImage(imageUrl:product['img'])),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(product['name'] , style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600
                                  ),),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          '${AppLocalizations.of(context).trans("quantity")}: ${product['quantity']}  ${AppLocalizations.of(context).trans("price")}: ${product['price']}'),
                                    ),
                                    Text('${AppLocalizations.of(context).trans("total")}: ${(product['quantity'] * product['price']).toStringAsFixed(2)} \$',
                                        style:TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600
                                        )
                                    )

                                  ],
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 24,
                    thickness: 0.1,
                    color: Colors.black54,
                    indent: 16,
                    endIndent: 16,
                  )
                ],
              );
              /*return ListTile(
                leading: Container(
                    width: 70,
                    color: Colors.red,
                    child: Column(
                      children: [
                        Text(product['itemCode']),
                        Expanded(child: CachedNetworkImage(imageUrl:product['img'])),
                      ],
                    )
                ),
                title: Text(product['name'] , style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                ),),
                subtitle: Text(
                    '${AppLocalizations.of(context).trans("quantity")}: ${product['quantity']}  ${AppLocalizations.of(context).trans("price")}: ${product['price']}'),
                trailing: Text('${AppLocalizations.of(context).trans("total")}: ${(product['quantity'] * product['price']).toStringAsFixed(2)}'),

              );*/
            }

            ),
            Divider(
              color: Colors.grey[300],
            ),
            buildDetailRow(AppLocalizations.of(context).trans('subtotal'),order['subTotal'].toStringAsFixed(2)+ ' \$'),
            buildDetailRow(AppLocalizations.of(context).trans('deliveryFee'),order['deliveryFee'].toStringAsFixed(2)+ ' \$'),
            buildDetailRow(AppLocalizations.of(context).trans('total'),order['totalPrice'].toStringAsFixed(2)+ ' IQD'),
            SizedBox(height: 16),
            Text(
              '${AppLocalizations.of(context).trans('orderStatus')}: ${order['OrderStatus']}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: order['OrderStatus'] == 'Rejected'
                    ? Colors.red:
                order['OrderStatus'] == 'Pending'?
                Colors.orange
                    : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, dynamic value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

}
