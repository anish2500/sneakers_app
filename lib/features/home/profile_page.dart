import 'package:flutter/material.dart';
import 'package:sneakers_app/app/widgets/show_confirm_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  SizedBox(width: 10),
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(
                height: 130,
                width: double.infinity,
                padding: EdgeInsets.all(10),

                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: const Color.fromARGB(255, 13, 93, 221),
                  border: Border.all(
                    color: const Color.fromARGB(255, 235, 235, 235),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Image.asset('assets/images/userprofile.png'),
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'user@example.com',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '@user123',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 50),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Profile Edit clicked',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              duration: Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: const Color.fromARGB(
                                255,
                                29,
                                12,
                                222,
                              ),
                            ),
                          );
                        },
                        child: Icon(Icons.edit_rounded, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Card(
                elevation: 2,
                color: const Color.fromARGB(255, 248, 246, 246),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.logout,
                          size: 40,
                          color: Colors.blue,
                        ),
                        title: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            // SizedBox(height: 2),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Logout of your application!',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            showConfirmDialog(
                              context: context,
                              title: "Logout",
                              message: "Are you sure you want to logout?",
                              onYes: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Logged out successfully'),
                                  ),
                                );
                              },
                            );
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
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
