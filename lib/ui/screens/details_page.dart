import 'package:basic_api_riverpod/data/model/user_model.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Details'),
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (user.avatar != null)
                CircleAvatar(
                  backgroundImage: NetworkImage(user.avatar!),
                  radius: 40.0,
                ),
              const SizedBox(height: 10.0), // Add spacing

              // Display user ID with label
              Row(
                children: [
                  const Text(
                    'ID: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(user.id?.toString() ?? 'NA'), // Handle null ID
                ],
              ),
              const SizedBox(height: 5.0), // Add smaller spacing

              // Display user name with labels
              Row(
                children: [
                  const Text(
                    'First Name: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(user.firstName ?? 'NA'), // Handle null firstName
                ],
              ),
              const SizedBox(height: 5.0), // Add smaller spacing

              // Display user last name with label
              Row(
                children: [
                  const Text(
                    'Last Name: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(user.lastName.toString())
                ],
              ),
              const SizedBox(height: 5.0), // Add smaller spacing

              // Display user email with label (if available)
              if (user.email != null)
                Row(
                  children: [
                    const Text(
                      'Email Address: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(user.email.toString()),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
