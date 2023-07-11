import 'package:corona_info/Services/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesData extends StatefulWidget {
  const CountriesData({super.key});

  @override
  State<CountriesData> createState() => _CountriesDataState();
}

class _CountriesDataState extends State<CountriesData> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var controller = ApiServices();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.arrow_back_ios_sharp,
                color: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                    )),
                height: 50,
                child: TextFormField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Country Name",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: FutureBuilder(
                  future: controller.getCountriesDataApi(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          if (searchController.text.isEmpty) {
                            return ListTile(
                              leading: Image.network(
                                snapshot.data![index]['countryInfo']['flag'],
                                height: 40,
                                width: 60,
                                fit: BoxFit.fill,
                              ),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                            );
                          } else if (snapshot.data![index]['country']
                              .toString()
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return ListTile(
                              leading: Image.network(
                                snapshot.data![index]['countryInfo']['flag'],
                                height: 40,
                                width: 60,
                                fit: BoxFit.fill,
                              ),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: ListTile(
                                leading: Container(
                                  height: 40,
                                  width: 60,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  height: 10,
                                  width: 60,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 60,
                                  color: Colors.white,
                                ),
                              ));
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
