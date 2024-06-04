import 'package:basic_api_riverpod/data/model/user_model.dart';
import 'package:basic_api_riverpod/data/network_caller/network_provider.dart';
import 'package:basic_api_riverpod/ui/screens/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(userDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('RiverPod'),
        ),
      ),
      body: data.when(
          // data is a function that takes only a list as a parameter
          data: (data) {
            List<UserModel> userList = data.map((e) => e).toList();

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final user = userList[index];
                      return ListTile(
                        onLongPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UserDetailsScreen(user: user))),
                        title: Text('${user.firstName} ${user.lastName} '),
                        subtitle: Text('${user.email}'),
                        trailing: CircleAvatar(
                          backgroundImage: NetworkImage(user.avatar!),
                        ),
                      );
                    },
                    itemCount: userList.length,
                  ),
                )
              ],
            );
          },
          error: (err, s) => Text(err.toString()),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
