import 'package:app/Screens/HomePage.dart';
import 'package:app/Screens/MainPage.dart';
import 'package:flutter/material.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String name;
  final double amount;
  final double rate;
  final double all;
  final String payment;
  PaymentSuccessScreen(
      {required this.name,
      required this.amount,
      required this.all,
      required this.rate,
      required this.payment});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 60,
            ),
            SizedBox(height: 10),
            Text(
              'Амжилттай Төлөгдлөө',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              '$name',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 20),
            Card(
              color: Colors.white70,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PaymentDetailRow(
                        title: 'Төлбөрийн хэрэгсэл', value: payment),
                    PaymentDetailRow(
                      title: 'Төлөв',
                      value: 'Хийгдсэн',
                      isBold: true,
                    ),
                    PaymentDetailRow(title: 'Цаг', value: '08:15 AM'),
                    PaymentDetailRow(title: 'Огноо', value: 'Feb 28, 2022'),
                    PaymentDetailRow(
                      title: 'Гүйлгээний дугаар',
                      value: '209291383247...',
                      isCopyable: true,
                    ),
                    Divider(),
                    PaymentDetailRow(title: 'Үнэ', value: '\$11.99'),
                    PaymentDetailRow(title: 'Хураамж', value: '\$1.99'),
                    Divider(),
                    PaymentDetailRow(
                      title: 'Нийт',
                      value: '\$13.98',
                      isBold: true,
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        color: Colors.grey[300], // Simulated QR code
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Homepage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                // primary: Colors.white,
                // onPrimary: Colors.teal,
                side: BorderSide(color: Colors.teal),
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'Share Receipt',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentDetailRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isBold;
  final bool isCopyable;

  const PaymentDetailRow({
    required this.title,
    required this.value,
    this.isBold = false,
    this.isCopyable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
                ),
              ),
              if (isCopyable)
                IconButton(
                  icon: Icon(Icons.copy, size: 18),
                  onPressed: () {
                    // Add copy functionality
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}