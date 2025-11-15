import 'package:flutter/material.dart';

void main() => runApp(const BeamCalculatorApp());

class BeamCalculatorApp extends StatelessWidget {
  const BeamCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beam Calculator',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'SF Pro', // Approximate system font
      ),
      home: const BeamCalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BeamCalculatorScreen extends StatefulWidget {
  const BeamCalculatorScreen({super.key});

  @override
  State<BeamCalculatorScreen> createState() => _BeamCalculatorScreenState();
}

class _BeamCalculatorScreenState extends State<BeamCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _priceController = TextEditingController();
  final _lengthController = TextEditingController();
  final _numberController = TextEditingController();
  final _pricePerMeterController = TextEditingController();
  final _branchPriceController = TextEditingController();
  final _totalPriceController = TextEditingController();

  // Dropdown values
  String? _bottomRebar;
  String? _topRebar;
  String? _beamTrussHeight;
  String? _widthOfBeamHeap;
  String? _zigzag;
  String? _firstReinforcementBar;
  String? _secondReinforcementBar;
  String? _firstReinforcementPercentage;
  String? _secondReinforcementPercentage;

  @override
  void dispose() {
    _priceController.dispose();
    _lengthController.dispose();
    _numberController.dispose();
    _pricePerMeterController.dispose();
    _branchPriceController.dispose();
    _totalPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.calculate, color: Colors.black),
        ),
        title: const Text(
          'Beam Calculator',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.refresh, color: Colors.black),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.dark_mode, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info Text
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'This calculation is based on class A3 rebar.',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 24),

              // Price Input
              _buildTextField(
                controller: _priceController,
                label: 'Enter the Price:',
                prefixIcon: const Icon(Icons.attach_money),
                suffixIcon: const Icon(Icons.check_circle_outline),
              ),
              const SizedBox(height: 24),

              // Length & Number
              Row(
                children: [
                  Expanded(
                    child: _buildLabeledTextField(controller: _lengthController, label: 'Length *'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildLabeledTextField(controller: _numberController, label: 'Number *'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Bottom & Top Rebar
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      label: 'Bottom rebar *',
                      value: _bottomRebar,
                      items: ['Ø8', 'Ø10', 'Ø12', 'Ø16'],
                      onChanged: (val) => setState(() => _bottomRebar = val),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdown(
                      label: 'Top rebar *',
                      value: _topRebar,
                      items: ['Ø8', 'Ø10', 'Ø12', 'Ø16'],
                      onChanged: (val) => setState(() => _topRebar = val),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Beam truss height & Width
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      label: 'Beam truss height *',
                      value: _beamTrussHeight,
                      items: ['10 cm', '15 cm', '20 cm', '25 cm'],
                      onChanged: (val) => setState(() => _beamTrussHeight = val),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdown(
                      label: 'Width of the beam heap *',
                      value: _widthOfBeamHeap,
                      items: ['10 cm', '15 cm', '20 cm', '25 cm'],
                      onChanged: (val) => setState(() => _widthOfBeamHeap = val),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Zigzag
              _buildDropdown(
                label: 'Zigzag *',
                value: _zigzag,
                items: ['Ø6', 'Ø8', 'Ø10'],
                onChanged: (val) => setState(() => _zigzag = val),
              ),
              const SizedBox(height: 24),

              // Reinforcement Bars
              const Text('First reinforcement bar:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildDropdown(
                label: '',
                value: _firstReinforcementBar,
                items: ['None', 'Ø8', 'Ø10', 'Ø12'],
                onChanged: (val) => setState(() => _firstReinforcementBar = val),
              ),
              const SizedBox(height: 16),
              const Text(
                'Second reinforcement bar:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildDropdown(
                label: '',
                value: _secondReinforcementBar,
                items: ['None', 'Ø8', 'Ø10', 'Ø12'],
                onChanged: (val) => setState(() => _secondReinforcementBar = val),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),

              // Reinforcement Percentages
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      label: 'First reinforcement percentage',
                      value: _firstReinforcementPercentage,
                      items: ['0%', '25%', '50%', '75%', '100%'],
                      onChanged: (val) => setState(() => _firstReinforcementPercentage = val),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdown(
                      label: 'Second reinforcement percentage',
                      value: _secondReinforcementPercentage,
                      items: ['0%', '25%', '50%', '75%', '100%'],
                      onChanged: (val) => setState(() => _secondReinforcementPercentage = val),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Calculate Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Add calculation logic here
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Calculating...')));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text(
                    'Calculate',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Results Section
              const Text('Price per meter:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildTextField(controller: _pricePerMeterController, label: '', readOnly: true),
              const SizedBox(height: 16),

              const Text('Branch price:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildTextField(controller: _branchPriceController, label: '', readOnly: true),
              const SizedBox(height: 16),

              const Text('Total price:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildTextField(controller: _totalPriceController, label: '', readOnly: true),
              const SizedBox(height: 24),

              // Footer
              const Center(
                child: Text(
                  'by Soroush Salehizadeh',
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    Icon? prefixIcon,
    Icon? suffixIcon,
    bool readOnly = false,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      keyboardType: readOnly ? null : TextInputType.number,
    );
  }

  Widget _buildLabeledTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        if (label.isNotEmpty) const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((item) {
            return DropdownMenuItem(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          ),
          dropdownColor: Colors.white,
          icon: const Icon(Icons.keyboard_arrow_down),
        ),
      ],
    );
  }
}
