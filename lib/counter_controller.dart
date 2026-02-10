class CounterController {
  int _counter = 0;
  int _step = 1;

  // Riwayat Task 2
  final List<String> _history = [];

  int get value => _counter;
  int get step => _step;

  // Getter riwayat (copy aman untuk View)
  List<String> get history => List.unmodifiable(_history);

  void setStep(int newStep) {
    if (newStep >= 1) {
      _step = newStep;
    }
  }

  void increment() {
    _counter += _step;
    _addToHistory("User menambah nilai sebesar $_step");
  }

  void decrement() {
    if (_counter >= _step) {
      _counter -= _step;
      _addToHistory("User mengurangi nilai sebesar $_step");
    } else {
      _counter = 0;
      _addToHistory("User mencoba kurang tapi sudah 0");
    }
  }

  void reset() {
    _counter = 0;
    _addToHistory("User mereset counter ke 0");
  }

  // Fungsi private untuk tambah riwayat + limit 5 + hanya jam
  void _addToHistory(String action) {
    // Hanya jam:menit:detik (contoh: 09:13:45)
    String time = DateTime.now().toString().substring(11, 19);
    String entry = "$action pada jam $time";
    _history.insert(0, entry);  // terbaru di atas
    if (_history.length > 5) {
      _history.removeLast();    // hapus yang paling lama
    }
  }
}