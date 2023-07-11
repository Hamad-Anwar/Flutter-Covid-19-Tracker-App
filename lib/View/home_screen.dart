import 'package:corona_info/Model/Home_data_model.dart';
import 'package:corona_info/Services/ApiServices.dart';
import 'package:corona_info/View/CountriesData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    ApiServices services=ApiServices();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: FutureBuilder(
                  future: services.getAllDataApi(),
                  builder: (context,AsyncSnapshot<HomeDataModel> snapshot) {
                    if(snapshot.hasData){
                      return  Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PieChart(
                                animationDuration: const Duration(seconds: 1),
                                chartValuesOptions: const ChartValuesOptions(
                                    showChartValuesInPercentage: true
                                ),
                                legendOptions: const LegendOptions(
                                    legendPosition: LegendPosition.left
                                ),
                                chartType: ChartType.ring,
                                chartRadius: 150,
                                colorList: const [
                                  Colors.blue,
                                  Colors.green,
                                  Colors.red
                                ],
                                dataMap: {
                                  'Total' : double.parse(snapshot.data!.cases.toString()),
                                  'Recovered' : double.parse(snapshot.data!.recovered.toString()),
                                  'Deaths' :  double.parse(snapshot.data!.deaths.toString())
                                }
                            ),
                            const SizedBox(height: 40,),
                            ReuseableRow(title: 'Cases', data: snapshot.data!.cases.toString()),
                            ReuseableRow(title: 'Recovered', data: snapshot.data!.recovered.toString()),
                            ReuseableRow(title: 'Deaths', data: snapshot.data!.deaths.toString()),
                            ReuseableRow(title: 'Active', data: snapshot.data!.active.toString()),
                            ReuseableRow(title: 'Critical', data: snapshot.data!.critical.toString()),
                            ReuseableRow(title: 'Population', data: snapshot.data!.population.toString()),
                            ReuseableRow(title: 'Affected Countries', data: snapshot.data!.affectedCountries.toString()),
                            const SizedBox(height: 40,),
                            InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesData(),)),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text("Track Countries",style: TextStyle(color: Colors.white),),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }else{
                      return const SpinKitFadingCircle(
                        color: Colors.white,
                        duration: Duration(milliseconds: 2),
                      );
                    }
                  },
                )
            ),

          ],
        ),
      ),
    );
  }

}

class ReuseableRow extends StatelessWidget {

  ReuseableRow({super.key,required this.title,required this.data});
  String title,data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0,top: 20,right: 10,left: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: const TextStyle(color: Colors.white),),
              Text(data,style: const TextStyle(color: Colors.white),),
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}
