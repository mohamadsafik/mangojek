import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangojek/ui/listproduct/bloc/food_state.dart';
import 'package:mangojek/models/food_model.dart';
import '../bloc/food_bloc.dart';

class ListProduct extends StatelessWidget {
  const ListProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.info)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Red Pizza, Haugeulis",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromARGB(255, 255, 106, 0)),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.logo_dev,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Super Partner",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        const SizedBox(width: 10),
                        const Text("Pizza & Pasta"),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: const Color.fromARGB(255, 240, 238, 238),
                height: 70,
                child: Row(
                  children: [
                    Container(
                        height: 70,
                        width: 100,
                        child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                Text("4.3"),
                              ],
                            ))),
                    Container(
                      height: 70,
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.location_on,
                            color: Colors.orange,
                          ),
                          Text("11.08 km"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 70,
                width: 360,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey)),
                child: Align(
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.motorcycle,
                        color: Colors.white,
                      ),
                    ),
                    title: const Text("Delivery"),
                    subtitle: const Text("Delivery in 23 min"),
                    trailing: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text(
                        "Change",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: BlocBuilder<FoodBloc, FoodState>(
                      builder: (context, state) {
                    if (state is FoodLoadState) {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.50,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: state.foods.length,
                        itemBuilder: (BuildContext context, int index) {
                          FoodModel food = state.foods[index];
                          return Container(
                              height: 600,
                              width: 200,
                              child: Column(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: SizedBox(
                                        height: 180,
                                        width: 180,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                              food.image.toString(),
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                            return const Text('😢');
                                          }, fit: BoxFit.cover),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                      height: 30,
                                      child: Text(
                                        food.name.toString(),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      food.price.toString(),
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 180,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.blueAccent)),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Add",
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ));
                        },
                      );
                    } else if (state is FoodErrorState) {
                      return Center(child: Text(state.error));
                    }
                    return const CircularProgressIndicator();
                  }))
            ],
          ),
        ));
  }
}
