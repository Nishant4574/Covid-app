import 'dart:async';


import 'package:covid_app/View/Countries_list.dart';
import 'package:covid_app/model/WorldStatesModel.dart';
import 'package:covid_app/services/states_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> with TickerProviderStateMixin{

  late final  AnimationController _controller =AnimationController(
      duration: Duration(seconds: 3),
      vsync:this)..repeat();
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override

  Widget build(BuildContext context) {
  StatesServices statesServices =StatesServices();
    return Scaffold(
body: ListView(
  children: [
    SafeArea(child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
    SizedBox(height: MediaQuery.of(context).size.height*.01,),
          FutureBuilder(future: statesServices.fetchWorkStatesRecords(), builder: (context,AsyncSnapshot<WorldStatesModel>snapshot){
    if(!snapshot.hasData){
    return Expanded(
        flex: 1,
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 50,
          controller: _controller,
        ));
    }else{
    return Column(
      children: [
        PieChart(dataMap: {
          "Total":double.parse(snapshot.data!.cases!.toString()),
          "Recovered":double.parse(snapshot.data!.recovered!.toString()),
          "Death":double.parse(snapshot.data!.deaths!.toString()),
        },
          chartValuesOptions: ChartValuesOptions(
            showChartValuesInPercentage: true
          ),
          animationDuration: Duration(microseconds: 1200),
          chartRadius: MediaQuery.of(context).size.width/3.2,
          legendOptions: LegendOptions(
              legendPosition: LegendPosition.left
          ),
          chartType: ChartType.ring,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Card(
            child: Column(
              children: [
                ReuseableRow(title: "Total", value: snapshot.data!.cases.toString()),
                ReuseableRow(title: "Total", value: snapshot.data!.recovered.toString()),
                ReuseableRow(title: "Total", value: snapshot.data!.deaths.toString()),
                ReuseableRow(title: "Total", value: snapshot.data!.active.toString()),
                ReuseableRow(title: "Total", value: snapshot.data!.critical.toString()),
                ReuseableRow(title: "Total", value: snapshot.data!.todayDeaths.toString()),
                ReuseableRow(title: "Total", value: snapshot.data!.todayRecovered.toString()),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap:(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesList()));
            },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green
            ),
            child: Center(
              child: Text("Track Countries",style: TextStyle(fontSize: 20),),
            ),
          ),
        )
      ],
    );
    }
          }),

        ],
      ),
    )),
  ],
),
    );
  }
}
class ReuseableRow extends StatelessWidget {
  String title, value;
   ReuseableRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],

          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}
