import 'package:breaking_bad/breaking_bad_model.dart';
import 'package:flutter/material.dart';
import 'package:breaking_bad/network.dart';

class BreakingBadHomeView extends StatefulWidget {
  const BreakingBadHomeView({Key? key}) : super(key: key);

  @override
  _BreakingBadHomeViewState createState() => _BreakingBadHomeViewState();
}

class _BreakingBadHomeViewState extends State<BreakingBadHomeView> {
  Future<List<BreakingBadApi>>? apiData;

  ApiNetwork apiNetwork = ApiNetwork();

  @override
  void initState() {
    apiData = apiNetwork.breakingBadApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Breaking Bad Characters",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: apiData,
          builder: (context, AsyncSnapshot<List<BreakingBadApi>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData == false) {
              return const Center(
                  child: Text(
                "Check your internet connectivity ☹",
                style: TextStyle(
                  fontSize: 20,
                ),
              ));
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Character Details"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      backgroundImage: NetworkImage(
                                          snapshot.data![index].img!),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.work),
                                      title: Text("Occupation"),
                                      subtitle: Text(
                                          "${snapshot.data![index].occupation![0]}"),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.calendar_today_sharp),
                                      title: Text("Date of Birth"),
                                      subtitle: Text(
                                          "${snapshot.data![index].birthday.toString().contains("Birthday.UNKNOWN") ? ("Unavailable") : snapshot.data![index].birthday}"),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.book),
                                      title: Text("Date of Birth"),
                                      subtitle: Text(
                                          "${snapshot.data![index].status!}"),
                                    )
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text("Ok"),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text("Cancel"),
                                  ),
                                ],
                              );
                            });
                      },
                      title: Text("${snapshot.data![index].name!}"),
                      subtitle: Text("${snapshot.data![index].nickname}"),
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data![index].img!),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
