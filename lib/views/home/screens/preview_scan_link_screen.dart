import 'package:flutter/material.dart';

class PreviewScanLinkScreen extends StatelessWidget {
  final dynamic data;
  const PreviewScanLinkScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Links'),
              ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final results = data[index];
                  return ListTile(
                    title: const Text('Random'),
                    subtitle: Text(results),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
