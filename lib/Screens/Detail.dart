import 'package:app/Screens/Details.dart';
import 'package:app/Widgets/bottomnav.dart';
import 'package:flutter/material.dart';

class BillDetailsScreen extends StatelessWidget {
  final String uid;
  final String name;
  final double amount;
  final String date;
  BillDetailsScreen({
    required this.uid,
    required this.name,
    required this.amount,
    required this.date,
  });
  @override
  Widget build(BuildContext context) {
    final double rate = amount / 10;
    final double all = rate + amount;
    return Scaffold(
      backgroundColor: Colors.white, // Background color
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: AppBar(
            backgroundColor: Colors.teal,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Bill Details',
                style: TextStyle(color: Colors.black),
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.play_circle_filled,
                            size: 40, color: Colors.red),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$name',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '$date',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Үнэ', style: TextStyle(fontSize: 16)),
                        Text('\$ $amount', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Хураамж', style: TextStyle(fontSize: 16)),
                        Text('\$ $rate', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Нийт',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$ $all',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Төлбөрийн хэрэгсэл сонго', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            PaymentOptionTile(
              label: 'Дебит карт',
              icon: Icons.credit_card,
              selected: true,
            ),
            PaymentOptionTile(
              label: 'Paypal',
              icon: Icons.payment,
              selected: false,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BillDetailsApproveScreen(
                      uid: uid,
                      name: name,
                      amount: amount,
                      date: date,
                      rate: rate,
                      all: all,
                      payment: 'Card',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Төлөх',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentOptionTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;

  const PaymentOptionTile({
    required this.label,
    required this.icon,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: selected
          ? Icon(Icons.check_circle, color: Colors.green)
          : Icon(Icons.radio_button_unchecked),
      onTap: () {},
    );
  }
}
