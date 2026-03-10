import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:qarz_daftar/src/ui/search/search_screen.dart';
import 'package:qarz_daftar/src/widgets/my_textfield_widget.dart';

import '../blocs/product_bloc.dart';
import '../model/product_model.dart';
import '../repository/repository_product.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            children: [
              Text("Qarz Daftari"),
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                },
                child: Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // ListView uchun joy
          Expanded(
            // Bu qo'shildi
            child: StreamBuilder<List<ProductModel>>(
              stream: contactBlocProduct.getStreamProduct,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!;
                  if (data.isEmpty) {
                    return Center(child: Text("Ma'lumot yo'q"));
                  }
                  return ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const BehindMotion(),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          // Bu qo'shildi
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          builder: (context) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(
                                                  context,
                                                ).viewInsets.bottom,
                                                left: 16,
                                                right: 16,
                                                top: 16,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                // Bu o'zgartirildi
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Qarz qo'shish",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  MyTextfield(
                                                    controller: controllerName,
                                                    hintText: "Ism kiriting",
                                                    obscureText: false,
                                                  ),
                                                  SizedBox(height: 15),
                                                  MyTextfield(
                                                    controller:
                                                        controllerNumber,
                                                    hintText: "Telefon raqam",
                                                    obscureText: false,
                                                  ),
                                                  SizedBox(height: 15),
                                                  MyTextfield(
                                                    controller: controllerPrice,
                                                    hintText: "Qarzni kiriting",
                                                    obscureText: false,
                                                  ),
                                                  SizedBox(height: 50),
                                                  InkWell(
                                                    onTap: () async {
                                                      if (
                                                      controllerName.text.isEmpty ||
                                                          controllerPrice.text.isEmpty ||
                                                          controllerNumber.text.isEmpty) {
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              "Iltimos barcha maydonni to'ldiring",
                                                            ),
                                                            backgroundColor:
                                                                Colors
                                                                    .redAccent,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    12,
                                                                  ),
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        RepositoryProduct repo =
                                                            RepositoryProduct();
                                                        ProductModel
                                                        updateData = ProductModel(
                                                          id: data[index].id,
                                                          name: controllerName.text,
                                                          price: double.tryParse(
                                                                controllerPrice.text,
                                                              ) ??
                                                              0,
                                                          number: int.tryParse(
                                                                controllerNumber.text,
                                                              ) ??
                                                              0,
                                                        );
                                                        await repo.updateBase(
                                                          updateData,
                                                        );
                                                        await contactBlocProduct
                                                            .getAllName();
                                                        controllerPrice.clear();
                                                        controllerName.clear();
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              20,
                                                            ),
                                                        color: Colors.blue,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Saqlash",
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                          color: Colors.blue,
                                        ),
                                        child: Icon(Icons.edit),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    InkWell(
                                      onTap: () async {
                                        RepositoryProduct repo =
                                            RepositoryProduct();
                                        await repo.deleteBaseProduct(
                                          data[index].id,
                                        );
                                        contactBlocProduct.getAllName();
                                      },
                                      child: Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                          color: Colors.red,
                                        ),
                                        child: Icon(Icons.delete_outline),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Ismi:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      data[index].name,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "Qarzi:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${data[index].price} so'm",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "Telefon Raqami:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${data[index].number}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  contactBlocProduct.getAllName();
                  return Center(child: Text("Malumot topilmad"));
                }
              },
            ),
          ),

          // FloatingActionButton pastda
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                child: Icon(Icons.add, size: 30),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, // Bu qo'shildi
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16,
                          top: 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min, // Bu o'zgartirildi
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Qarz qo'shish",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            MyTextfield(
                              controller: controllerName,
                              hintText: "Ism kiriting",
                              obscureText: false,
                            ),
                            SizedBox(height: 15),
                            MyTextfield(
                              controller: controllerPrice,
                              hintText: "Qarzni kiriting",
                              obscureText: false,
                            ),
                            SizedBox(height: 50),
                            InkWell(
                              onTap: () async {
                                if (controllerName.text.isEmpty ||
                                    controllerPrice.text.isEmpty) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Iltimos barcha maydonni to'ldiring",
                                      ),
                                      backgroundColor: Colors.redAccent,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  );
                                } else {
                                  RepositoryProduct repo = RepositoryProduct();
                                  ProductModel data = ProductModel(
                                    id: 0,
                                    name: controllerName.text,
                                    price:
                                        double.tryParse(controllerPrice.text) ??
                                        0,
                                      number: int.tryParse(controllerNumber.text) ?? 0
                                  );
                                  await repo.saveProduct(data);
                                  await contactBlocProduct.getAllName();
                                  controllerPrice.clear();
                                  controllerName.clear();
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Text(
                                    "Saqlash",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
