import 'package:super_get/super_get.dart';

/// Simple user model
class User {
  final int id;
  final String name;
  final String email;
  final String company;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
        company: (json['company'] as Map<String, dynamic>)['name'] as String,
      );
}

/// GetConnect-based API provider
class UserProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://jsonplaceholder.typicode.com';
    httpClient.defaultContentType = 'application/json';

    // Request modifier — add headers to every request
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['X-App'] = 'SuperGetDemo';
      return request;
    });

    super.onInit();
  }

  Future<List<User>> getUsers() async {
    final response = await get('/users');
    if (response.hasError) {
      throw Exception('Failed to load users: ${response.statusText}');
    }
    return (response.body as List)
        .map((json) => User.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

class ApiDemoController extends GetxController with StateMixin<List<User>> {
  final _provider = UserProvider();

  @override
  void onInit() {
    super.onInit();
    _provider.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    change(null, status: RxStatus.loading());
    try {
      final users = await _provider.getUsers();
      if (users.isEmpty) {
        change(null, status: RxStatus.empty());
      } else {
        change(users, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
