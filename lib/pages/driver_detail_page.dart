import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverDetailPage extends StatefulWidget {
  final Map<String, dynamic> driver;

  const DriverDetailPage({super.key, required this.driver});

  @override
  State<DriverDetailPage> createState() => _DriverDetailPageState();
}

class _DriverDetailPageState extends State<DriverDetailPage> {
  late List<bool> _animated;

  @override
  void initState() {
    super.initState();
    _animated = List.generate(10, (_) => false);
    _startAnimations();
  }

  void _startAnimations() async {
    for (int i = 0; i < _animated.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) {
        setState(() {
          _animated[i] = true;
        });
      }
    }
  }

  Widget _buildAnimatedItem(int index, Widget child) {
    return AnimatedOpacity(
      opacity: _animated[index] ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      child: AnimatedSlide(
        offset: _animated[index] ? Offset.zero : const Offset(0, 0.3),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final career = widget.driver['careerStatus'] ?? {};

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Main container with all text info
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAnimatedItem(
                    0,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Follow',
                            style: GoogleFonts.orbitron(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildAnimatedItem(
                    1,
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.driver['firstName'] ?? '',
                                style: GoogleFonts.orbitron(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.driver['lastName'] ?? '',
                                    style: GoogleFonts.orbitron(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildAnimatedItem(
                      2,
                      _buildStatRow('World Championships',
                          career['World Championships'] ?? '-')),
                  const SizedBox(height: 15),
                  _buildAnimatedItem(
                      3,
                      _buildStatRow('Grand Prix Entered',
                          career['Grand Prix Entered'] ?? '-')),
                  const SizedBox(height: 15),
                  _buildAnimatedItem(
                      4, _buildStatRow('Podiums', career['Podiums'] ?? '-')),
                  const SizedBox(height: 15),
                  _buildAnimatedItem(
                      5,
                      _buildStatRow(
                          'Career Points', career['Career Points'] ?? '-')),
                  const SizedBox(height: 15),
                  _buildAnimatedItem(
                      6,
                      _buildStatRow('Highest Race Finish',
                          career['Highest Race Finish'] ?? '-')),
                  const SizedBox(height: 25),
                  _buildAnimatedItem(
                    7,
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Biography',
                        style: GoogleFonts.orbitron(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildAnimatedItem(
                      8,
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: SingleChildScrollView(
                          child: Text(
                            widget.driver['bio'] ?? 'No biography available.',
                            style: GoogleFonts.orbitron(
                              fontSize: 14,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Positioned driver image on center-right with animation applied to Image itself
            Positioned(
              top: screenSize.height * 0.05,
              left: screenSize.width *
                  0.35, // you can adjust this to fine-tune horizontal position
              child: _buildAnimatedItem(
                9,
                Image.asset(
                  widget.driver['fullImage'] ?? widget.driver['image'],
                  height: screenSize.height * 0.6,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.orbitron(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.orbitron(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
