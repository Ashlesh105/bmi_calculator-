import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BMICalculator(),debugShowCheckedModeBanner: false,
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String gender = 'male';
  double bmi = 0.0;

  void calculateBMI() {
    double height = double.tryParse(heightController.text) ?? 0.0;
    double weight = double.tryParse(weightController.text) ?? 0.0;
    double age = double.tryParse(ageController.text) ?? 0.0;

    setState(() {
      if (height > 0 && weight > 0) {
        bmi = weight / ((height / 100) * (height / 100));
      } else {
        bmi = 0.0;
      }
    });

    String comment = '';
    if (bmi >= 30) {
      comment = 'Obese';
    } else if (bmi >= 25) {
      comment = 'Overweight';
    } else if (bmi >= 18.5) {
      comment = 'Normal Weight';
    } else {
      comment = 'Underweight';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('BMI Result'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Your BMI: ${bmi.toStringAsFixed(2)}'),
              Text('Comment: $comment'),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 600,
          height: 400,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.black)),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Height (cm)',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Weight (kg)',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Gender: '),
                  Radio(
                    value: 'male',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                  const Text('Male'),
                  Radio(
                    value: 'female',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                  const Text('Female'),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculateBMI,
                child: const Text('Calculate BMI'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
