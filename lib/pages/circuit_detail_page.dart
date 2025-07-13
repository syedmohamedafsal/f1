import 'package:f1/pages/circuit_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SilverstonePage extends StatefulWidget {
  final Circuit circuit;

  const SilverstonePage({super.key, required this.circuit});

  @override
  State<SilverstonePage> createState() => _SilverstonePageState();
}

class _SilverstonePageState extends State<SilverstonePage> {
  bool _showTop = false;
  bool _showMap = false;
  bool _showStats = false;
  List<bool> _showResults = [];

  @override
  void initState() {
    super.initState();
    _showResults = List.generate(6, (_) => false);
    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() => _showTop = true);

    await Future.delayed(const Duration(milliseconds: 300));
    setState(() => _showMap = true);

    await Future.delayed(const Duration(milliseconds: 300));
    setState(() => _showStats = true);

    for (int i = 0; i < _showResults.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() => _showResults[i] = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final circuit = widget.circuit;

    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D),
      body: SafeArea(
        child: Column(
          children: [
            _buildAnimatedSlide(
              _showTop,
              child: _buildTopSection(circuit),
            ),
            _buildAnimatedSlide(
              _showMap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Transform.rotate(
                        angle: 1.5708, // 90 degrees in radians
                        child: Image.asset(
                          circuit.circuitImage,
                          height: 320,
                          width: 300,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    SizedBox(
                        height: 8), // Reduced from 20 to 8 for tighter spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatBox("Race Distance", circuit.raceDistance),
                        _buildStatBox("Circuit Length", circuit.circuitLength),
                        _buildStatBox("Number of Laps", circuit.numberOfLaps),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _buildAnimatedSlide(
                _showStats,
                child: _buildResultSection(circuit),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.orbitron(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedSlide(bool visible, {required Widget child}) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      child: AnimatedSlide(
        offset: visible ? Offset.zero : const Offset(0, 0.1),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        child: child,
      ),
    );
  }

  Widget _buildTopSection(Circuit circuit) {
    return Container(
      padding: const EdgeInsets.only(bottom: 24),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 48, 47, 47),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Image.asset(
                  'assets/image/drivers/f1-logo-bg.png',
                  height: 40,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                const Spacer(),
                const Icon(Icons.search, color: Colors.white, size: 28),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  circuit.name,
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  circuit.description,
                  style: GoogleFonts.orbitron(
                    // or any other Google Font
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultSection(Circuit circuit) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10),
              child: Text(
                "Racing Result",
                style: GoogleFonts.orbitron(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            for (int i = 0; i < 6; i++)
              _buildAnimatedSlide(
                _showResults[i],
                child: _buildDriverResult(
                  team: _driverData[i]['team']!,
                  name: _driverData[i]['name']!,
                  time: _driverData[i]['time']!,
                  number: _driverData[i]['number']!,
                  image: _driverData[i]['image']!,
                  isGap: i != 0,
                ),
              ),
          ],
        ),
      ),
    );
  }

  final List<Map<String, String>> _driverData = [
    {
      'team': "Mercedes Benz",
      'name': "Lewis Hamilton",
      'time': "1:35:50.443",
      'number': "44",
      'image': 'assets/image/cars/Mercidies_side_view.png',
    },
    {
      'team': "Red Bull Racing",
      'name': "Max Verstappen",
      'time': "1.512 sec",
      'number': "1",
      'image': 'assets/image/cars/Red_bull_side_view.png',
    },
    {
      'team': "Ferrari",
      'name': "Charles Leclerc",
      'time': "5.623 sec",
      'number': "16",
      'image': 'assets/image/cars/ferrari_side_view.png',
    },
    {
      'team': "McLaren",
      'name': "Lando Norris",
      'time': "8.342 sec",
      'number': "4",
      'image': 'assets/image/cars/McLaren_side_view.png',
    },
    {
      'team': "Mercedes Benz",
      'name': "George Russell",
      'time': "10.974 sec",
      'number': "63",
      'image': 'assets/image/cars/Mercidies_side_view.png',
    },
    {
      'team': "Ferrari",
      'name': "Carlos Sainz",
      'time': "14.222 sec",
      'number': "55",
      'image': 'assets/image/cars/ferrari_side_view.png',
    },
  ];

  Widget _buildDriverResult({
    required String team,
    required String name,
    required String time,
    required String number,
    required String image,
    bool isGap = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  team,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  name,
                  style: GoogleFonts.orbitron(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isGap ? "Time Gap" : "Race Time",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isGap ? "+$time" : time,
                style: TextStyle(
                  color: isGap ? Colors.red : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Text(
            number,
            style: GoogleFonts.orbitron(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          Image.asset(
            image,
            height: 48,
            width: 88,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
