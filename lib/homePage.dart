import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riv_gen/main.dart'; // تأكد أن هذا الملف يحتوي على الـ Provider المطور

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String userNo = '1';
  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(fetchUserProvider(userNo));
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // خلفية هادئة مريحة للعين
      appBar: AppBar(
        title: const Text(
          'User Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: userAsync.when(
        data: (user) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: TextField(
                  onSubmitted: (value) {
                    setState(() {
                      userNo = value;
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search',
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.indigo.shade100,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              // 1. الجزء العلوي (صورة رمزية واسم)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.indigo.shade100,
                      child: Text(
                        user.name[0], // أول حرف من الاسم
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '@${user.userName}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 2. كارت معلومات التواصل
              _buildSectionTitle('Contact Information'),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _buildInfoTile(Icons.email_outlined, 'Email', user.email),
                    _buildInfoTile(
                      Icons.phone_android_outlined,
                      'Phone',
                      user.phone,
                    ),
                    _buildInfoTile(
                      Icons.language_outlined,
                      'Website',
                      user.webSite,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 3. كارت العنوان والشركة
              _buildSectionTitle('Business & Location'),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _buildInfoTile(
                      Icons.business_center_outlined,
                      'Company',
                      user.company.name,
                    ),
                    _buildInfoTile(
                      Icons.location_on_outlined,
                      'City',
                      user.address.city,
                    ),
                    _buildInfoTile(
                      Icons.map_outlined,
                      'Street',
                      user.address.street,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 10),
              Text('Error: $err', textAlign: TextAlign.center),
              ElevatedButton(
                onPressed: () => ref.refresh(fetchUserProvider(userNo)),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text('Fetching data via Proxy...'),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget مساعد لعنوان القسم
Widget _buildSectionTitle(String title) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
    ),
  );
}

// Widget مساعد لعرض صفحة المعلومة الواحدة
Widget _buildInfoTile(IconData icon, String label, String value) {
  return ListTile(
    leading: Icon(icon, color: Colors.indigo),
    title: Text(
      label,
      style: const TextStyle(fontSize: 12, color: Colors.grey),
    ),
    subtitle: Text(
      value,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    ),
  );
}
