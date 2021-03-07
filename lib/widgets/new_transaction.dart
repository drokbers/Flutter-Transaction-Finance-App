import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _presentDatePick() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'You didnt select a date  '
                        : 'Picked Date : ${DateFormat('dd/MM/yyyy').format(_selectedDate)}'),
                  ),
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _presentDatePick,
                      child: Text(
                        'Change Date',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[600]),
                      ))
                ],
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text('Add Transaction',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              textColor: Colors.purple[600],
              onPressed: () {
                if (double.parse(_amountController.text) > 0 &&
                    (_titleController.text).isNotEmpty &&
                    (_selectedDate == null) == false) {
                  widget.addTx(
                      _titleController.text,
                      double.parse(
                        _amountController.text,
                      ),
                      _selectedDate);
                } else {
                  print('0 yada -');
                  return;
                }
                Navigator.of(context).pop(); // ekleme kasmini oto kapatmak icin
              },
            )
          ],
        ),
      ),
    );
  }
}
