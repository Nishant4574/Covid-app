import 'package:covid_app/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'DeatailScreen.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchcontroller,
              decoration: InputDecoration(
                  hintText: "Search with country name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: statesServices.fetchCountriesRecords(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          children: [
                            ListTile(
                              title: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                              leading: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      );
                    });
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];
                      if (searchcontroller.text.isEmpty) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Deatailscreen(name: snapshot.data![index]["country"], image: snapshot.data![index]
                                ["countryInfo"]["flag"], totalCases:  snapshot.data![index]['cases'] ,
                                  totalRecovered: snapshot.data![index]['recovered'] ,
                                  totalDeaths: snapshot.data![index]['deaths'],
                                  active: snapshot.data![index]['active'],
                                  test: snapshot.data![index]['tests'],
                                  todayRecovered: snapshot.data![index]['todayRecovered'],
                                  critical: snapshot.data![index]['critical'] ,)));
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ["countryInfo"]["flag"]),
                                ),
                              ),
                            )
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(searchcontroller.text.toLowerCase())) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Deatailscreen(name: snapshot.data![index]["country"], image: snapshot.data![index]
                                ["countryInfo"]["flag"], totalCases:  snapshot.data![index]['cases'] ,
                                  totalRecovered: snapshot.data![index]['recovered'] ,
                                  totalDeaths: snapshot.data![index]['deaths'],
                                  active: snapshot.data![index]['active'],
                                  test: snapshot.data![index]['tests'],
                                  todayRecovered: snapshot.data![index]['todayRecovered'],
                                  critical: snapshot.data![index]['critical'] ,)));
                        },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ["countryInfo"]["flag"]),
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    });
              }
            },
          ))
        ],
      )),
    );
  }
}
