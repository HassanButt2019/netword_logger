import 'package:flutter/material.dart';
import 'package:netword_logger/feature/api_response/provider/api_response.dart';
import 'package:provider/provider.dart';

class ResponseScreen extends StatefulWidget {
  final String apiEndpoint;

  const ResponseScreen({required this.apiEndpoint, Key? key}) : super(key: key);

  @override
  _ResponseScreenState createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ApiResponseProvider>().fetchApi(widget.apiEndpoint, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Response Details")),
      body: Consumer<ApiResponseProvider>(builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: provider.isLoading
              ? const Center(child: AnimatedEllipsis())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                          children: [
                            const TextSpan(
                              text: "Endpoint: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: provider.response!.endpoint,
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                          children: [
                            const TextSpan(
                              text: "Status: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "${provider.response!.statusCode}",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: provider.response!.statusCode == 200
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                          children: [
                            const TextSpan(
                              text: "Body: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: provider.response!.response ??
                                  "No response body.",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (provider.response!.errorResponse != null)
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                            children: [
                              const TextSpan(
                                text: "Error: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              TextSpan(
                                text: provider.response!.errorResponse!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
        );
      }),
    );
  }
}

class AnimatedEllipsis extends StatefulWidget {
  const AnimatedEllipsis({Key? key}) : super(key: key);

  @override
  _AnimatedEllipsisState createState() => _AnimatedEllipsisState();
}

class _AnimatedEllipsisState extends State<AnimatedEllipsis>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _dots;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
    _dots = StepTween(begin: 1, end: 3).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _dots,
      builder: (context, child) {
        return Text(
          'Getting response${'.' * _dots.value}',
          style: const TextStyle(fontSize: 16),
        );
      },
    );
  }
}
