import 'package:flutter/material.dart';

class Student {
  final String name;
  final int score1;
  final int score2;

  Student({required this.name, required this.score1, required this.score2});
}

class ScoreInputPage extends StatefulWidget {
  const ScoreInputPage({super.key});

  @override
  _ScoreInputPageState createState() => _ScoreInputPageState();
}

class _ScoreInputPageState extends State<ScoreInputPage> {
  final _formKey = GlobalKey<FormState>();
  final List<Student> _students = [];

  late String _name;
  late int _score1;
  late int _score2;
  late double average;
  late double percentage;
  late int sum;
  


  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final student = Student(name: _name, score1: _score1, score2: _score2);
      setState(() {
        _students.add(student);
      });
      sum = _score1 + _score2;
      average = sum/2;
      percentage = (sum/200) * 100;
      print('Name: $_name, Score1: $_score1, Score2: $_score2, Average: $average, Percentage: $percentage%');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Score'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MOAD Score',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a score';
                  }
                  final score = int.tryParse(value);
                  if (score == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _score1 = int.parse(value!);
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'MOS Score',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a score';
                  }
                  final score = int.tryParse(value);
                  if (score == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _score2 = int.parse(value!);
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: _submitForm,
              ),
              SizedBox(height: 16.0),
              Text('Scores:'),
              Expanded(
                child: ListView.builder(
                  itemCount: _students.length,
                  itemBuilder: (BuildContext context, int index) {
                    final student = _students[index];
                    return ListTile(
                      title: Text(student.name),
                      subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('MOAD: ${student.score1}'),
              Text('MOS: ${student.score2}'),
              Text('average: $average'),
              Text('percentage: $percentage'),
            ],
          ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
