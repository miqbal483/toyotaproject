import 'package:flutter/material.dart';

void main() {
  runApp(WeddingInvitationApp());
}

class WeddingInvitationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeddingHomePage(),
    );
  }
}

class WeddingHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/everestmounts.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "The Wedding of",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 5,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Novi S.Hum & Arifin Amd.T",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.lightBlueAccent,
                  shadows: [
                    Shadow(
                      offset: Offset(3, 3),
                      blurRadius: 10,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "7 December 2025",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 5,
                      color: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.withOpacity(0.8),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeddingDetailPage(),
                    ),
                  );
                },
                child: Text(
                  "View Details",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeddingDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wedding Details"),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Invited you !!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "The Wedding of Novi Rahma.P S.Hum & Arifin Amd.T",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.blueGrey),
                  SizedBox(width: 10),
                  Text(
                    "Date: 7 Juli 2025",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.blueGrey),
                  SizedBox(width: 10),
                  Text(
                    "Time: 10:00 AM - selesai",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.blueGrey),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Venue: Durian , Kediaman Mempelai putri SIMARASOK",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Additional Information:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "We are excited to celebrate our special day with you!",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  onPressed: () {
                    // Tambahkan navigasi ke halaman RSVP jika diperlukan
                  },
                  child: Text(
                    "Online GIFT",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
