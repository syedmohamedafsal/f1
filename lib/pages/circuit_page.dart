import 'package:f1/pages/circuit_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CircuitPage extends StatefulWidget {
  const CircuitPage({super.key});

  @override
  State<CircuitPage> createState() => _CircuitPageState();
}

class _CircuitPageState extends State<CircuitPage> {
  final List<Circuit> circuits = [
    // Your circuit list (unchanged)
    Circuit(
      name: 'Baku City Circuit 🇦🇿',
      countryCode: 'AZ',
      description:
          'A street circuit in Baku, Azerbaijan. Known for long straights and tight corners, making it a unique challenge.',
      circuitImage: 'assets/image/circuit/baku-bg.png',
      circuitLength: '6.003 km',
      numberOfLaps: '51',
      raceDistance: '306.049 km',
      country: 'Azerbaijan',
    ),
    Circuit(
      name: 'Interlagos Circuit 🇧🇷',
      countryCode: 'BR',
      description:
          'Located in São Paulo, Brazil, this circuit is famed for unpredictable weather and thrilling races.',
      circuitImage: 'assets/image/circuit/interlagos-bg.png',
      circuitLength: '4.309 km',
      numberOfLaps: '71',
      raceDistance: '305.909 km',
      country: 'Brazil',
    ),
    Circuit(
      name: 'Circuit de Monaco 🇲🇨',
      countryCode: 'MC',
      description:
          'One of the most iconic tracks in Formula 1, racing through the narrow streets of Monte Carlo.',
      circuitImage: 'assets/image/circuit/monaco-bg.png',
      circuitLength: '3.337 km',
      numberOfLaps: '78',
      raceDistance: '260.286 km',
      country: 'Monaco',
    ),
    Circuit(
      name: 'Autodromo Nazionale Monza 🇮🇹',
      countryCode: 'IT',
      description:
          'Known as the Temple of Speed, this Italian track features high-speed corners and historic significance.',
      circuitImage: 'assets/image/circuit/monzo-bg.png',
      circuitLength: '5.793 km',
      numberOfLaps: '53',
      raceDistance: '306.720 km',
      country: 'Italy',
    ),
    Circuit(
      name: 'Silverstone Circuit 🇬🇧',
      countryCode: 'GB',
      description:
          'Located about 100 kilometers north of London, the British GP was held here in 1948 and was the first World Formula 1 Championship in 1950.',
      circuitImage: 'assets/image/circuit/silverstone_map-bg.png',
      circuitLength: '5.891 km',
      numberOfLaps: '52',
      raceDistance: '306.198 km',
      country: 'UK',
    ),
  ];

  List<bool> isVisibleList = [];

  @override
  void initState() {
    super.initState();
    isVisibleList = List.filled(circuits.length, false);

    // Automatically animate the first 2 cards with a delay
    for (int i = 0; i < circuits.length && i < 2; i++) {
      Future.delayed(Duration(milliseconds: 400 * i), () {
        if (mounted) {
          setState(() {
            isVisibleList[i] = true;
          });
        }
      });
    }
  }

  void _onVisible(int index) {
    if (!isVisibleList[index]) {
      setState(() {
        isVisibleList[index] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Image.asset(
                    'assets/image/drivers/f1_black-bg.png',
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "F1 Circuits",
                    style: GoogleFonts.orbitron(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            /// List of Circuits
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: circuits.length,
                itemBuilder: (context, index) {
                  final circuit = circuits[index];
                  return VisibilityDetector(
                    key: Key('circuit-$index'),
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.1 && index > 1) {
                        _onVisible(index);
                      }
                    },
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 500),
                      offset: isVisibleList[index]
                          ? Offset.zero
                          : const Offset(0, 0.2),
                      curve: Curves.easeOut,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: isVisibleList[index] ? 1.0 : 0.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    SilverstonePage(circuit: circuit),
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.grey.shade900,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: const EdgeInsets.only(bottom: 20),
                            elevation: 8,
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Image.asset(
                                    circuit.circuitImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        circuit.name,
                                        style: GoogleFonts.orbitron(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on,
                                              size: 18, color: Colors.white),
                                          const SizedBox(width: 6),
                                          Text(
                                            circuit.country,
                                            style: const TextStyle(
                                                color: Colors.white70),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _buildStatBox(
                                              "Laps", circuit.numberOfLaps),
                                          _buildStatBox(
                                              "Length", circuit.circuitLength),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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

  Widget _buildStatBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.orbitron(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class Circuit {
  final String name;
  final String description;
  final String circuitImage;
  final String raceDistance;
  final String circuitLength;
  final String numberOfLaps;
  final String country;
  final String countryCode;

  Circuit({
    required this.name,
    required this.description,
    required this.circuitImage,
    required this.raceDistance,
    required this.circuitLength,
    required this.numberOfLaps,
    required this.country,
    required this.countryCode,
  });
}
