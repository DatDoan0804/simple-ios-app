import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FlashlightApp());
}

class FlashlightApp extends StatefulWidget {
  const FlashlightApp({super.key});

  @override
  State<FlashlightApp> createState() => _FlashlightAppState();
}

class _FlashlightAppState extends State<FlashlightApp> {
  bool _isTorchOn = false;
  String _statusMessage = 'Initializing...';

  @override
  void initState() {
    super.initState();
    _enableTorchOnLaunch();
  }

  Future<void> _enableTorchOnLaunch() async {
    try {
      final isAvailable = await TorchLight.isTorchAvailable();
      if (isAvailable) {
        await TorchLight.enableTorch();
        setState(() {
          _isTorchOn = true;
          _statusMessage = 'Torch active';
        });
      } else {
        setState(() {
          _statusMessage = 'Torch hardware unavailable';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Failed to enable torch: $e';
      });
    }
  }

  Future<void> _toggleTorch() async {
    try {
      if (_isTorchOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      setState(() {
        _isTorchOn = !_isTorchOn;
        _statusMessage = _isTorchOn ? 'Torch active' : 'Torch disabled';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Toggle error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 96.0,
                icon: Icon(
                  _isTorchOn ? Icons.flash_on : Icons.flash_off,
                  color: _isTorchOn ? Colors.yellow : Colors.grey,
                ),
                onPressed: _toggleTorch,
              ),
              const SizedBox(height: 24.0),
              Text(
                _statusMessage,
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
