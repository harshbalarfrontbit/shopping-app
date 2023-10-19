import 'package:flutter/material.dart';

class StepperScreen extends StatefulWidget {
  const StepperScreen({Key? key}) : super(key: key);

  @override
  State<StepperScreen> createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text('Stepper'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Stepper(
              currentStep: _index,
              onStepCancel: () {
                if (_index > 0) {
                  setState(() {
                    _index -= 1;
                  });
                }
              },
              onStepContinue: () {
                if (_index <= 0) {
                  setState(() {
                    _index += 1;
                  });
                }
              },
              onStepTapped: (int index) {
                setState(() {
                  _index = index;
                });
              },
              steps: <Step>[
                Step(
                  title: const Text(
                    'Step 1 title',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Content for Step 1',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const Step(
                  title: Text(
                    'Step 2 title',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: Text(
                    'Content for Step 2',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomStepper extends StatefulWidget {
  const CustomStepper({Key? key}) : super(key: key);

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.blueGrey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text('Stepper'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Stepper(
              currentStep: _index,
              onStepCancel: () {
                if (_index > 0) {
                  setState(() {
                    _index -= 1;
                  });
                }
              },
              onStepContinue: () {
                if (_index <= 2) {
                  setState(() {
                    _index += 1;
                  });
                }
              },
              onStepTapped: (int index) {
                setState(() {
                  _index = index;
                });
              },
              steps: const <Step>[
                Step(
                  title: Text(
                    "Order Placed",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text("Your order has been placed"),
                  content: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('please select option'),
                    ],
                  ),
                ),
                Step(
                  title: Text(
                    "Preparing",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text("Your order is being prepared"),
                  content: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('please select option'),
                    ],
                  ),
                ),
                Step(
                  title: Text(
                    "On the way",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                      "Our delivery executive is on the way to deliver your item"),
                  content: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('please select option'),
                    ],
                  ),
                ),
                Step(
                  title: Text(
                    "Delivered",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  content: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('please select option'),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyStepper extends StatefulWidget {
  const MyStepper({super.key});

  @override
  _MyStepperState createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  int _currentStep = 0;
  final List<Step> _steps = [
    const Step(
      title: Text('Step 1'),
      content: Text('This is the content of Step 1'),
    ),
    const Step(
      title: Text('Step 2'),
      content: Text('This is the content of Step 2'),
    ),
    const Step(
      title: Text('Step 3'),
      content: Text('This is the content of Step 3'),
    ),
  ];

  void _goToNextStep() {
    setState(() {
      _currentStep < _steps.length - 1 ? _currentStep++ : null;
    });
  }

  void _goToPreviousStep() {
    setState(() {
      _currentStep > 0 ? _currentStep-- : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stepper Example'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _goToNextStep,
        onStepCancel: _goToPreviousStep,
        steps: _steps,
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MyStepper(),
  ));
}
