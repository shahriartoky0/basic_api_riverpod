import 'package:basic_api_riverpod/data/network_caller/network_caller.dart';
import 'package:riverpod/riverpod.dart';


// as the Provider is handling async type of operation. FutureProvider should be used.
final userDataProvider = FutureProvider((ref) async {
  return ref.watch(userProvider).getData();
});
