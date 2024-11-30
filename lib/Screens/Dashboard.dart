import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal,
        child: Column(
          children: [
            // Balance Section
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Text(
                    'Нийт үлдэгдэл',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '\$2,548.00',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildActionButton(Icons.add, 'Нэмэх'),
                      _buildActionButton(Icons.grid_view, 'Төлөх'),
                      _buildActionButton(Icons.send, 'Илгээх'),
                    ],
                  ),
                ],
              ),
            ),
            // Tab Section
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTab('Гүйлгээнүүд', isSelected: true),
                _buildTab('Хүлээгдэж буй гүйлгээ'),
              ],
            ),
            SizedBox(height: 10),
            // Transactions Section
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: ListView(
                  children: [
                    _buildTransaction(
                        'Upwork', '+ \$850.00', 'Today', Colors.green),
                    _buildTransaction(
                        'Transfer', '- \$85.00', 'Yesterday', Colors.red),
                    _buildTransaction(
                        'Paypal', '+ \$1,406.00', 'Jan 30, 2022', Colors.green),
                    _buildTransaction(
                        'Youtube', '- \$11.99', 'Jan 16, 2022', Colors.red),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.teal.shade100,
          child: Icon(icon, color: Colors.teal, size: 30),
        ),
        SizedBox(height: 10),
        Text(label, style: TextStyle(fontSize: 16, color: Colors.teal)),
      ],
    );
  }

  Widget _buildTab(String label, {bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.teal : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          color: isSelected ? Colors.white : Colors.teal,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTransaction(
      String name, String amount, String date, Color amountColor) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        child: Text(name[0],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      title: Text(name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      subtitle: Text(date, style: TextStyle(color: Colors.grey)),
      trailing: Text(
        amount,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: amountColor),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: DashboardPage(),
    ));
