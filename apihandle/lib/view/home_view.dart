// ignore_for_file: must_be_immutable

import 'package:apihandle/controller/homeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(builder: (context) {
        print("calling future builder ...");
        return FutureBuilder(
            future: homeController.getCrudUser(),
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            // onPressed: (){},
                            onPressed: () async {
                              await homeController
                                  .deleteUser(snapshot.data[index]["_id"]);
                            },
                          ),
                          leading: IconButton(
                            icon: const Icon(Icons.edit),
                            // onPressed: (){},
                            onPressed: () async {
                              await homeController
                                  .updateUser(snapshot.data[index]["_id"]);
                            },
                          ),
                          title: Text(snapshot.data[index]['name'] ?? ''),
                          subtitle: Text(snapshot.data[index]['email'] ?? ''),
                        );
                      })
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await homeController.postUser();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
