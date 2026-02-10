import 'package:flutter/material.dart';
import 'counter_controller.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final CounterController _controller = CounterController();
  final TextEditingController _stepController = TextEditingController(text: '1');

  @override
  void dispose() {
    _stepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LogBook: Multi-Step + History"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              "Total Hitungan:",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),

            Text(
              '${_controller.value}',
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            // Input Step
            SizedBox(
              width: 180,
              child: TextField(
                controller: _stepController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'Step',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    int? newStep = int.tryParse(value);
                    if (newStep != null && newStep >= 1) {
                      _controller.setStep(newStep);
                    }
                  }
                },
              ),
            ),

            const SizedBox(height: 40),

            // Tombol + dan -
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () => setState(() => _controller.decrement()),
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 40),
                FloatingActionButton(
                  onPressed: () => setState(() => _controller.increment()),
                  child: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Tombol Reset
            ElevatedButton.icon(
              onPressed: () => setState(() => _controller.reset()),
              icon: const Icon(Icons.refresh, size: 20),
              label: const Text("Reset"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),

            const SizedBox(height: 40),

            // Riwayat
            const Text(
              "Riwayat Terakhir",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: ListView.builder(
                itemCount: _controller.history.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        _controller.history[index],
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[800],  // ← ini tidak boleh const
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}