/*final fetchUserProvider = FutureProvider((ref) async {
  const fullUrl = 'https://jsonplaceholder.typicode.com/users/1';
  Uri url = Uri.parse(fullUrl);
  http.Response response = await http.get(url);
  var responseData = json.decode(response.body);
  if (response.statusCode == 201 || response.statusCode == 200) {
    return User.fromJson(responseData);
  } else {
    String serverMessage = responseData['message'] ?? "Invalid data provided.";
    throw (serverMessage);
  }
});*/

// final nameProvier = Provider<String>((ref) {
//   return 'abc';
// });
// final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
//   return UserNotifier();
// });
// final userChangeNotifierProvider = ChangeNotifierProvider((ref) {
//   return UserNotifierChange();
// });
