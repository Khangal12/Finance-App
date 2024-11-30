import 'package:app/services/transaction.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CardDetailsPage extends StatefulWidget {
  @override
  _CardDetailsPageState createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  TransactionService transactionService = TransactionService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String cardName = '';
  String cardNumber = '';
  String cvc = '';
  String expiryDate = '';
  String amount = '';

  // Function to validate the form
  bool _validateForm() {
    if (_nameController.text.isEmpty ||
        _cardNumberController.text.isEmpty ||
        _cvcController.text.isEmpty ||
        _expiryDateController.text.isEmpty ||
        _amountController.text.isEmpty) {
      return false; // If any field is empty, return false
    }
    return true;
  }

  Future<void> _addIncome() async {
    if (_validateForm()) {
      final user = FirebaseAuth.instance.currentUser;
      double amount = double.tryParse(_amountController.text) ?? 0.0;
      if (user != null) {
        String userId = user.uid;

        // Create an instance of TransactionService
        final TransactionService transactionService = TransactionService();

        try {
          // Call addTransaction on the instance
          await transactionService.addTransaction(
            userId: userId,
            amount: amount,
            type: "income",
            status: "success",
            description: "Income added through card",
          );

          // Show success message
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Income Added'),
              content: Text(
                  'Your income has been added successfully using the card.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } catch (e) {
          print("Error adding income: $e");
          // Show a generic error message if something goes wrong
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Error'),
              content: Text(
                  'An error occurred while adding the income. Please try again later.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        // User is not authenticated
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Error'),
            content: Text('Please login to add income.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      // If form validation fails
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all fields correctly.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _updateCardDetails() {
    setState(() {
      cardName = _nameController.text;
      cardNumber = _cardNumberController.text;
      cvc = _cvcController.text;
      expiryDate = _expiryDateController.text;
      amount = _amountController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal,
        leading: Icon(Icons.arrow_back),
        title: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            'Түрийвч цэнэглэх',
            style: TextStyle(fontSize: 20),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Colors.teal,
        child: Column(
          children: [
            // Tabs Section
            Container(
              padding: EdgeInsets.only(right: 20, left: 20, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Картууд',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Text(
                          'Аккаунт',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Card Section
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    // Card Image
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Debit Card',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text(
                            cardName.isEmpty ? 'Name' : cardName,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text(
                            cardNumber.isEmpty
                                ? '---- ---- ---- ----'
                                : cardNumber,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                letterSpacing: 2),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cvc.isEmpty ? 'CVC' : cvc,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                              Text(
                                expiryDate.isEmpty ? 'MM/YY' : expiryDate,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // Input Fields
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'КАРТ ДЭЭРХ НЭР',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (_) => _updateCardDetails(),
                    ),
                    SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _cardNumberController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'КАРТЫН ДУГААР',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (_) => _updateCardDetails(),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 100,
                          child: TextField(
                            controller: _cvcController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'CVC',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _expiryDateController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'ДУУСАХ ХУГАЦАА YYYY/MM',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (_) => _updateCardDetails(),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'ТӨЛБӨР',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),

                    ElevatedButton(
                      onPressed: _addIncome,
                      child: Text('Үндсэн карт ашиглах'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
