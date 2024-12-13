import 'package:flutter/material.dart';
import 'feature/api_response/screen/response_screen.dart';

class ApiListScreen extends StatelessWidget {
  final List<String> apiEndpoints = [
    "https://jsonplaceholder.typicode.com/posts",
    "https://jsonplaceholder.typicode.com/users/1",
    "http://localhost:3500/api/v1/products/get"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API List")),
      body: ListView.builder(
        itemCount: apiEndpoints.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(apiEndpoints[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ResponseScreen(apiEndpoint: apiEndpoints[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
