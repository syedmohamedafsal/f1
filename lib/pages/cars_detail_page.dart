import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'cars_page.dart'; // Make sure CarModel is correctly imported

class CarsDetailPage extends StatefulWidget {
  final CarModel car;

  const CarsDetailPage({super.key, required this.car});

  @override
  State<CarsDetailPage> createState() => _CarsDetailPageState();
}

class _CarsDetailPageState extends State<CarsDetailPage>
    with TickerProviderStateMixin {
  final List<bool> _visibleList = List.generate(10, (_) => false);

  // Add animation controllers for header elements
  late AnimationController _avatarController;
  late AnimationController _teamNameController;
  late AnimationController _driverNameController;
  late AnimationController _carImageController;
  bool _headerAnimationDone = false;

  @override
  void initState() {
    super.initState();

    const duration = Duration(milliseconds: 600);

    _avatarController = AnimationController(vsync: this, duration: duration);
    _teamNameController = AnimationController(vsync: this, duration: duration);
    _driverNameController =
        AnimationController(vsync: this, duration: duration);
    _carImageController = AnimationController(vsync: this, duration: duration);

    _avatarController.forward().then((_) {
      _teamNameController.forward().then((_) {
        _driverNameController.forward().then((_) {
          _carImageController.forward().then((_) {
            // ✅ Set the flag here after all header animations finish
            setState(() {
              _headerAnimationDone = true;
            });

            // ✅ Trigger first few section animations manually without scroll
            _triggerAnimation(1); // About this car
            _triggerAnimation(2); // Stats
            _triggerAnimation(3); // Constructor
            if (widget.car.wins.isNotEmpty) {
              _triggerAnimation(4); // Wins
            }
            _triggerAnimation(5); // Highlights text
            _triggerAnimation(6); // Video
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _avatarController.dispose();
    _teamNameController.dispose();
    _driverNameController.dispose();
    _carImageController.dispose();
    super.dispose();
  }

  // Helper for animated fade+scale using controller
  Widget _animatedWithController(AnimationController controller, Widget child) {
    return FadeTransition(
      opacity: controller,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.85, end: 1.0).animate(
          CurvedAnimation(parent: controller, curve: Curves.easeIn),
        ),
        child: child,
      ),
    );
  }

  // Your existing _animated for other sections remains unchanged
  Widget _animated(int index, Widget child) {
    return VisibilityDetector(
      key: Key('section-$index'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1) {
          _triggerAnimation(index);
        }
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeIn,
        opacity: _visibleList[index] ? 1.0 : 0.0,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 600),
          scale: _visibleList[index] ? 1.0 : 0.85,
          curve: Curves.easeIn,
          child: child,
        ),
      ),
    );
  }

  void _triggerAnimation(int index) {
    if (!_headerAnimationDone)
      return; // ⛔ Don't animate if header isn't done yet
    if (!_visibleList[index]) {
      setState(() {
        _visibleList[index] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final car = widget.car;
    final Color dynamicColor = Color(
      int.parse(car.backgroundColorHex.replaceFirst('#', '0xff')),
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // HEADER (custom animated parts)
                Container(
                  width: double.infinity,
                  height: 420,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, dynamicColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 40,
                        left: 20,
                        right: 20,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                            ),
                            const Spacer(),
                            // Animate CircleAvatar sequentially
                            _animatedWithController(
                              _avatarController,
                              CircleAvatar(
                                backgroundImage: AssetImage(car.driverImage),
                                radius: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 40,
                        top: 90,
                        right: 40,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          // Animate teamName sequentially
                          child: _animatedWithController(
                            _teamNameController,
                            Text(
                              car.teamName,
                              style: GoogleFonts.orbitron(
                                fontSize: 80,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 100,
                        top: 75,
                        // Animate driverName sequentially
                        child: _animatedWithController(
                          _driverNameController,
                          Text(
                            car.driverName,
                            style: GoogleFonts.orbitron(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 130,
                        left: 0,
                        right: 0,
                        // Animate car image sequentially
                        child: Hero(
                          tag: car.carImage,
                          child: _animatedWithController(
                            _carImageController,
                            Image.asset(
                              car.carImage2,
                              height: 300,
                              width: 400,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Other sections animate on scroll as before
                _animated(
                  1,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About This Car',
                          style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.amberAccent,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          car.description,
                          style: GoogleFonts.orbitron(
                            fontSize: 14,
                            letterSpacing: 3,
                            wordSpacing: 2,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                _animated(
                  2,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatCard(
                              Icons.speed, 'Top Speed', '${car.topSpeed} km/h'),
                          _buildStatCard(Icons.show_chart, 'Avg Speed',
                              '${car.avgSpeed.toStringAsFixed(1)} km/h'),
                          _buildStatCard(
                              Icons.timer, 'Best Lap', '${car.bestLap}'),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                _animated(
                  3,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          car.constructor,
                          style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                if (car.wins.isNotEmpty)
                  _animated(
                    4,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'World Championship Wins',
                            style: GoogleFonts.orbitron(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.amberAccent,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...car.wins.map((win) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    const Icon(Icons.emoji_events,
                                        color: Colors.amberAccent, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${win.year} - ${win.driver}',
                                      style: GoogleFonts.orbitron(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 30),

                _animated(
                  5,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Highlights',
                        style: GoogleFonts.orbitron(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                _animated(
                  6,
                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(car.videoUrl);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              car.videoThumbnail,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Container(color: Colors.black.withOpacity(0.3)),
                            const Icon(Icons.play_circle_fill,
                                color: Colors.white, size: 64),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.amberAccent, size: 28),
        const SizedBox(height: 10),
        Text(
          label,
          style: GoogleFonts.orbitron(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white60,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.orbitron(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
