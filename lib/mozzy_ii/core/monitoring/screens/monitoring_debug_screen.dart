import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import '../crashlytics_service.dart';
import '../performance_monitoring_service.dart';

class MonitoringDebugScreen extends StatefulWidget {
  const MonitoringDebugScreen({super.key});

  @override
  State<MonitoringDebugScreen> createState() => _MonitoringDebugScreenState();
}

class _MonitoringDebugScreenState extends State<MonitoringDebugScreen> {
  bool _crashlyticsEnabled = false;
  bool _performanceEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    // ignore: invalid_use_of_visible_for_testing_member
    final crashlyticsEnabled = CrashlyticsService.mockInstance != null 
        ? true : FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
    // ignore: invalid_use_of_visible_for_testing_member
    final performanceEnabled = PerformanceMonitoringService.mockInstance != null 
        ? true : await FirebasePerformance.instance.isPerformanceCollectionEnabled();
    
    if (mounted) {
      setState(() {
        _crashlyticsEnabled = crashlyticsEnabled;
        _performanceEnabled = performanceEnabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitoring Debug'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Crashlytics Status'),
            trailing: Icon(
              _crashlyticsEnabled ? Icons.check_circle : Icons.cancel,
              color: _crashlyticsEnabled ? Colors.green : Colors.red,
            ),
          ),
          ListTile(
            title: const Text('Performance Status'),
            trailing: Icon(
              _performanceEnabled ? Icons.check_circle : Icons.cancel,
              color: _performanceEnabled ? Colors.green : Colors.red,
            ),
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () {
              CrashlyticsService.recordNonFatal(
                Exception('This is a test non-fatal error'),
                StackTrace.current,
                reason: 'test_non_fatal',
                context: {'screen': 'monitoring_debug'},
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Non-fatal error sent')),
              );
            },
            child: const Text('Send test non-fatal error'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              // ignore: invalid_use_of_visible_for_testing_member
              if (CrashlyticsService.mockInstance != null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Crash prevented in test mode')));
              } else {
                FirebaseCrashlytics.instance.crash();
              }
            },
            child: const Text('Force test crash', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              await PerformanceMonitoringService.trace(
                name: 'test_trace',
                action: () async {
                  await Future.delayed(const Duration(seconds: 2));
                  return true;
                },
                attributes: {'test_attr': 'value'},
              );
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Test trace completed (2s)')),
                );
              }
            },
            child: const Text('Run performance test trace'),
          ),
        ],
      ),
    );
  }
}
