import 'package:covid_app/View/World_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Deatailscreen extends StatefulWidget {
  String name;
  String image;
  int totalCases,totalDeaths,totalRecovered,active,critical,todayRecovered,test;
   Deatailscreen({super.key,required this.name,required this.image,required this.totalCases,required this.totalDeaths,required this.todayRecovered,required this.active,required this.critical,required this.totalRecovered,required this.test});

  @override
  State<Deatailscreen> createState() => _DeatailscreenState();
}

class _DeatailscreenState extends State<Deatailscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text(widget.name),
  centerTitle: true,
),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Card(
                child: Column(
                  children: [

                    ReuseableRow(title: "Cases", value: widget.totalCases.toString()),
                    ReuseableRow(title: 'Recovered', value:  widget.totalRecovered.toString(),),
                    ReuseableRow(title: 'Death', value:  widget.totalDeaths.toString(),),
                    ReuseableRow(title: 'Critical', value: widget.critical.toString(),),
                    ReuseableRow(title: 'Today Recovered', value:widget.totalRecovered.toString(),),
                  ],
                ),
              ),
            ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
