import 'package:f1/pages/cars_page.dart';
import 'package:f1/pages/circuit_page.dart';
import 'package:f1/pages/driver_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _slideAnimations;
  late final List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      6,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      ),
    );

    _slideAnimations = _controllers
        .map(
          (controller) => Tween<Offset>(
            begin: const Offset(0, 0.2),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeIn),
          ),
        )
        .toList();

    _fadeAnimations = _controllers
        .map(
          (controller) => Tween<double>(
            begin: 0,
            end: 1,
          ).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeIn),
          ),
        )
        .toList();

    _runStaggeredAnimations();
  }

  Future<void> _runStaggeredAnimations() async {
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      _controllers[i].forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SlideTransition(
                position: _slideAnimations[0],
                child: FadeTransition(
                  opacity: _fadeAnimations[0],
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            'assets/image/drivers/f1-logo-bg.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(
                          CupertinoIcons.line_horizontal_3,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Title
              SlideTransition(
                position: _slideAnimations[1],
                child: FadeTransition(
                  opacity: _fadeAnimations[1],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Standings",
                        style: GoogleFonts.orbit(
                          color: Colors.white,
                          fontSize: 50,
                          letterSpacing: 5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SlideTransition(
                      position: _slideAnimations[2],
                      child: FadeTransition(
                        opacity: _fadeAnimations[2],
                        child: _buildStandingsCard(
                          title: "Drivers",
                          imagePath: 'assets/image/drivers/front_image-bg.png',
                          context: context,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SlideTransition(
                      position: _slideAnimations[3],
                      child: FadeTransition(
                        opacity: _fadeAnimations[3],
                        child: _buildStandingsCarCard(
                            title: "Constructors",
                            imagePath: 'assets/image/cars/jan-1-bg.png',
                            context: context),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SlideTransition(
                      position: _slideAnimations[4],
                      child: FadeTransition(
                        opacity: _fadeAnimations[4],
                        child: _buildStandingsCircuitCard(
                          title: "Circuit",
                          context: context,
                          imagePath:
                              'assets/image/circuit/silverstone-removebg-preview.png',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStandingsCard({
    required String title,
    required String imagePath,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DriverPage()),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 300,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  title,
                  style: GoogleFonts.orbitron(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: -25,
              child: Image.asset(
                imagePath,
                height: 300,
                width: 320,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStandingsCircuitCard({
    required String title,
    required String imagePath,
    required BuildContext context, // Add context
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CircuitPage()),
        );
      },
      child: Container(
        height: 300,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  title,
                  style: GoogleFonts.orbitron(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -40,
              right: -20,
              child: Image.asset(
                imagePath,
                height: 300,
                width: 320,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStandingsCarCard({
    required String title,
    required String imagePath,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CarsPage()),
        );
      },
      child: Container(
        height: 300,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  title,
                  style: GoogleFonts.orbitron(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -55,
              right: -120,
              child: Image.asset(
                imagePath,
                height: 300,
                width: 400,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
