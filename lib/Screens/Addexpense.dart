import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/services/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddExpensePage extends StatefulWidget {
  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedTransaction = 'Netflix'; // Default value

  @override
  Widget build(BuildContext context) {
    bool _validateForm() {
      // Add your form validation logic here
      return _amountController.text.isNotEmpty && _selectedDate != null;
    }

    Future<void> _addOutcome() async {
      if (_validateForm()) {
        final user = FirebaseAuth.instance.currentUser;
        double amount = double.tryParse(_amountController.text) ?? 0.0;
        if (user != null) {
          String userId = user.uid;

          // Create an instance of TransactionService
          final TransactionService transactionService = TransactionService();

          try {
            Timestamp dateTimestamp = _selectedDate != null
                ? Timestamp.fromDate(_selectedDate!)
                : Timestamp
                    .now(); // Default to current timestamp if no date selected
            // Call addTransaction on the instancea
            await transactionService.addOutcomeTransaction(
              userId: userId,
              amount: amount,
              date: dateTimestamp,
              type: "expenses",
              status: "pending",
              description: _selectedTransaction ?? 'Other',
            );

            // Show success message
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Outcome Added'),
                content: Text('Your outcome has been added successfully.'),
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
            print("Error adding outcome: $e");
            // Show a generic error message if something goes wrong
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Error'),
                content: Text(
                    'An error occurred while adding the outcome. Please try again later.'),
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
              content: Text('Please login to add outcome.'),
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

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200), // Increase the height here
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.teal,
          leading: Icon(Icons.arrow_back),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(
                top: 30.0), // Adjust top padding for title
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Зарлага нэмэх',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400), // Bigger title
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.teal,
        child: Column(
          children: [
            // Form Section
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Transaction Name
                    Text(
                      'Гүйлгээний нэр',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedTransaction,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedTransaction = newValue;
                          });
                        },
                        items: <String>[
                          'Netflix',
                          'Amazon',
                          'Spotify',
                          'Food',
                          'Youtube',
                          'Other'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    'https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg',
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(value, style: TextStyle(fontSize: 18)),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Amount
                    Text(
                      'Үнийн дүн',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: '\$ ',
                        prefixStyle:
                            TextStyle(color: Colors.teal, fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Date
                    Text(
                      'Огноо',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: _selectDate,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedDate != null
                                  ? DateFormat('EEE, dd MMM yyyy')
                                      .format(_selectedDate!)
                                  : 'Select a date',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            Icon(Icons.calendar_today, color: Colors.teal),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Payment Button
                    Text(
                      'Төлбөр',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        _addOutcome();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.shade300, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.teal),
                            SizedBox(width: 10),
                            Text(
                              'Төлбөр нэмэх',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.teal),
                            ),
                          ],
                        ),
                      ),
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

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: AddExpensePage(),
  ));
}
