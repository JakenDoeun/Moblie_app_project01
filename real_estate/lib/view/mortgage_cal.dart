import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

void main() {
  runApp(MortgageCalculatorApp());
}

class MortgageCalculatorApp extends StatelessWidget {
  const MortgageCalculatorApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MortgageCalculatorScreen(),
    );
  }
}

class MortgageCalculatorScreen extends StatefulWidget {
  const MortgageCalculatorScreen({super.key});
  @override
  _MortgageCalculatorScreenState createState() => _MortgageCalculatorScreenState();
}

class _MortgageCalculatorScreenState extends State<MortgageCalculatorScreen> {
  final TextEditingController housePriceController = TextEditingController();
  final TextEditingController downPaymentController = TextEditingController();
  final TextEditingController downPaymentPercentageController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  String? selectedLoanTerm;

  void updateDownPaymentFields() {
    double housePrice = double.tryParse(housePriceController.text) ?? 0;
    double downPayment = double.tryParse(downPaymentController.text) ?? 0;
    
    if (housePrice > 0) {
      double percentage = (downPayment / housePrice) * 100;
      downPaymentPercentageController.text = percentage.toStringAsFixed(2);
    }
  }

  void updateDownPaymentFromPercentage() {
    double housePrice = double.tryParse(housePriceController.text) ?? 0;
    double percentage = double.tryParse(downPaymentPercentageController.text) ?? 0;
    
    if (housePrice > 0) {
      double downPayment = (percentage / 100) * housePrice;
      downPaymentController.text = downPayment.toStringAsFixed(2);
    }
  }

void calculateAndNavigate() {
  double housePrice = double.tryParse(housePriceController.text) ?? 0;
  double downPayment = double.tryParse(downPaymentController.text) ?? 0;
  double interestRate = double.tryParse(interestRateController.text) ?? 0;
  int loanTermYears = int.tryParse(selectedLoanTerm?.split(' ')[0] ?? '0') ?? 0;

  if (housePrice == 0 || loanTermYears == 0) return;

  double loanAmount = housePrice - downPayment;
  double monthlyInterestRate = (interestRate / 100) / 12;
  int totalPayments = loanTermYears * 12;
  
  double monthlyPayment;
  if (monthlyInterestRate == 0) {
    monthlyPayment = loanAmount / totalPayments;  // Handle 0% interest scenario
  } else {
    monthlyPayment = (loanAmount * monthlyInterestRate) /
        (1 - pow(1 + monthlyInterestRate, -totalPayments));
  }

  double totalPayment = monthlyPayment * totalPayments;
  double totalInterest = totalPayment - loanAmount;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ResultScreen(
        monthlyPayment: monthlyPayment,
        loanAmount: loanAmount,
        totalInterest: totalInterest,
        interestRate: interestRate,
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mortgage Calculator', style: TextStyle(color: const Color.fromARGB(255, 33, 33, 33))),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField('House Price', housePriceController, prefix: '\$', keyboardType: TextInputType.number, onChanged: (_) => updateDownPaymentFields()),
            SizedBox(height: 22),
            Text('Down Payment'),
            Row(
              children: [
                Expanded(child: buildTextField('', downPaymentController, prefix: '\$', keyboardType: TextInputType.number, onChanged: (_) => updateDownPaymentFields())),
                SizedBox(width: 10),
                Expanded(child: buildTextField('', downPaymentPercentageController, suffix: '%', keyboardType: TextInputType.number, onChanged: (_) => updateDownPaymentFromPercentage())),
              ],
            ),
            SizedBox(height: 8),
            Text('Input either one: in USD or percentage', style: TextStyle(fontSize: 12, color: Colors.grey)),
            SizedBox(height: 22),
            buildTextField('Interest Rate', interestRateController, suffix: '%', keyboardType: TextInputType.number),
            SizedBox(height: 30),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Loan Term',
                border: OutlineInputBorder(),
              ),
              items: ['10 years', '15 years', '20 years', '30 years']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedLoanTerm = value;
                });
              },
            ),
            SizedBox(height: 70),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculateAndNavigate,
                //child: Text('Calculate'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 102, 33, 228),
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Calculate', style: TextStyle(fontSize: 20),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, {String? prefix, String? suffix, TextInputType? keyboardType, Function(String)? onChanged}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixText: prefix,
        suffixText: suffix,
      ),
      onChanged: onChanged,
    );
  }
}

class ResultScreen extends StatelessWidget {
  final double monthlyPayment;
  final double loanAmount;
  final double totalInterest;
  final double interestRate;

  const ResultScreen({
    super.key,
    required this.monthlyPayment,
    required this.loanAmount,
    required this.totalInterest,
    required this.interestRate,
  });

  @override
  Widget build(BuildContext context) {
    double monthlyInterestPayment = totalInterest / (loanAmount / monthlyPayment);

    return Scaffold(
      appBar: AppBar(title: const Text('Mortgage Result'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 45,
                  sections: [
                    PieChartSectionData(
                      value: loanAmount,
                      title: 'Principal',
                      color: const Color.fromARGB(255, 102, 33, 228),
                      radius: 60,
                      titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    PieChartSectionData(
                      value: totalInterest,
                      title: 'Interest',
                      color: const Color.fromARGB(255, 231, 69, 57),
                      radius: 60,
                      titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 247, 240, 255),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 247, 240, 255).withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('Total Monthly Payment', monthlyPayment),
                  buildInfoRow('Principal Payment', monthlyPayment - monthlyInterestPayment),
                  buildInfoRow('Interest Rate', interestRate, isPercentage: true),
                  buildInfoRow('Monthly Interest Payment', monthlyInterestPayment),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 102, 33, 228),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: const Text('Recalculate', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon:
                Icon(Icons.dashboard, color: Color(0xFF322D29)), // Changed icon
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.grey), // Changed icon
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark, color: Colors.grey), // Changed icon
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(Icons.account_circle, color: Colors.grey), // Changed icon
            label: 'Account',
          ),
        ],
        selectedItemColor: Color(0xFF322D29),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget buildInfoRow(String label, double value, {bool isPercentage = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(
            isPercentage ? '${value.toStringAsFixed(2)}%' : '\$${value.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}