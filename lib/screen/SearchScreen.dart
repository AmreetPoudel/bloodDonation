// ignore_for_file: camel_case_types, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class searchPost extends StatefulWidget {
  const searchPost({Key? key}) : super(key: key);

  @override
  _searchPostState createState() => _searchPostState();
}

class _searchPostState extends State<searchPost> {
  String selectedDistrict = 'Achham';

  var districts = [
    'Achham',
    'Arghakhanchi',
    'Baglung',
    'Baitadi',
    'Bajhang',
    'Bajura',
    'Banke',
    'Bara',
    'Bardiya',
    'Bhaktapur',
    'Bhojpur',
    'Chitwan',
    'Dadeldhura',
    'Dailekh',
    'Dang',
    'Darchula',
    'Dhading',
    'Dhankuta',
    'Dhanusha',
    'Dolakha',
    'Dolpa',
    'Doti',
    'Gorkha',
    'Gulmi',
    'Humla',
    'Illam',
    'Jajarkot',
    'Jhapa',
    'Jumla',
    'Kailali',
    'Kalikot',
    'Kanchanpur',
    'Kapilavastu',
    'Kaski',
    'Kathmandu',
    'Kavrepalanchok',
    'Khotang',
    'Lalitpur',
    'Lamjung',
    'Mahottari',
    'Makwanpur',
    'Manang',
    'Morang',
    'Mugu',
    'Mustang',
    'Myagdi',
    'Nawalpur',
    'Nuwakot',
    'Okhaldhunga',
    'Palpa',
    'Panchthar',
    'Parasi',
    'Parbat',
    'Parsa',
    'Pyuthan',
    'Ramechhap',
    'Rasuwa',
    'Rautahat',
    'Rolpa',
    'Rukum',
    'Rupandehi',
    'Salyan',
    'Sankhuwasabha',
    'Saptari',
    'Sarlahi',
    'Sindhuli',
    'Sindhupalchok',
    'Siraha',
    'Solukhumbu',
    'Sunsari',
    'Surkhet',
    'Syangja',
    'Tanahun',
    'Taplejung',
    'Tehrathum',
    'Udayapur'
  ];

  final Stream<QuerySnapshot> allPost =
      FirebaseFirestore.instance.collection('Post').snapshots();

  // // For Deleting User..............................................................................................
  // CollectionReference posts =
  //     FirebaseFirestore.instance.collection('Post');
  // Future<void> deleteUser(id) {
  //   // print("User Deleted $id");
  //   return students
  //       .doc(id)
  //       .delete()
  //       .then((value) => print('User Deleted'))
  //       .catchError((error) => print('Failed to Delete user: $error'));
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: allPost,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
            // print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map item = document.data() as Map<String, dynamic>;
            storedocs.add(item);
            item['uid'] = document.id;
            // print(storedocs);
          }).toList();
          //here we have all items in the list i.e all blood group on bloodgroup and similarly for district post and phone number
          //tried this because if kei add garnu paryo vane simply copy garara thorai change garda hunxa

          List bloodGroup = storedocs.map((i) => i['bloodGroup']).toList();
          List district = storedocs.map((i) => i['district']).toList();
          List post = storedocs.map((i) => i['post']).toList();
          List phoneNo = storedocs.map((i) => i['phoneNo']).toList();
          return SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              padding: const EdgeInsets.all(5),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        height: 40,
                        padding: const EdgeInsets.all(10),
                        child: Center(
                            child: Text('select district',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)))),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 40,
                      padding: const EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 0.30),
                      ),
                      //dropdown
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          elevation: 0,
                          value: selectedDistrict,
                          //problem
                          //The argument type 'List<dynamic>' can't be assigned to the parameter type 'List<DropdownMenuItem<String>>?'.
                          //so we have to use dynamic
                          //here distri
                          items: districts.map((String districts) {
                            return DropdownMenuItem(
                              value: districts,
                              child: Text(districts),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDistrict = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    for (var i = 0; i < storedocs.length; i++)
                      if (district[i] == selectedDistrict)
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 11.0),
                            elevation: 7,
                            shadowColor: Colors.red,
                            borderOnForeground: true,
                            // width: double.infinity,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              textDirection: TextDirection.rtl,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  'blood group: ${bloodGroup[i]}',
                                  style: TextStyle(
                                    color: Colors.red.shade500,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'district: ${district[i]}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'request: ${post[i]}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'phone Number: ${phoneNo[i]}',
                                  style: TextStyle(
                                    color: Colors.red.shade500,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
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
        });
  }
}
