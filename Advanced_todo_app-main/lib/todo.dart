
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'database.dart';

class FinalTodo extends StatefulWidget {
  const FinalTodo({super.key});
  @override
  State<FinalTodo> createState() => _FinalTodoState();
}

class TodoModel {
  int? taskId;
  String head;
  String desc;
  String date;
  bool isChecked;
  TodoModel({
    this.taskId,
    required this.head,
    required this.desc,
    required this.date,
    this.isChecked = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'head': head,
      "desc": desc,
      "date": date,
    };
  }

  @override
  String toString() {
    return 'head:$head,desc:$desc,date:$date';
  }
}

class _FinalTodoState extends State<FinalTodo> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await databaseFun();
      await getallTask();
    });
  }

  void showMyBottomsheet(bool isedit, [TodoModel? todoobj]) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Create Tasks ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Form(
                      key: _formkey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Title",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(89, 57, 241, 1),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: titlecontroller,
                              decoration: InputDecoration(
                                  hintText: 'Enter Title',
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(89, 57, 241, 1),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(89, 57, 241, 1),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: desccontroller,
                              maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: 'Enter desciption',
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(89, 57, 241, 1)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Date",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(89, 57, 241, 1),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                                controller: datecontroller,
                                decoration: InputDecoration(
                                    hintText: 'Select Date',
                                    suffixIcon: const Icon(
                                        Icons.calendar_month_outlined),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(89, 57, 241, 1)),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                    )),
                                readOnly: true,
                                onTap: () async {
                                  //pick the data from the date picker
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2024),
                                      lastDate: DateTime(2025));
                                  //format the date into the required format out the date
                                  String formatDate =
                                      DateFormat.yMMMd().format(pickedDate!);
                                  setState(() {
                                    datecontroller.text = formatDate;
                                  });
                                }),
                          ]),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 50,
                      width: 300,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          backgroundColor: const Color.fromRGBO(89, 57, 241, 1),
                        ),
                        onPressed: () {
                          if (isedit == true) {
                            submit(isedit, todoobj);
                          } else {
                            submit(isedit);
                          }
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  List cardList = [];
  List imagelist = [
    "assets/images/person.png",
    "assets/images/professor.png",
    "assets/images/female.png",
    "assets/images/dr.png",
  ];
List<bool> isDone=[false];
  void editTask(TodoModel todoobj) {
    titlecontroller.text = todoobj.head;
    desccontroller.text = todoobj.desc;
    datecontroller.text = todoobj.date;
    showMyBottomsheet(true, todoobj);
  }

  void submit(bool isedit, [TodoModel? todoobj]) async {
    if (titlecontroller.text.isNotEmpty &&
        desccontroller.text.isNotEmpty &&
        datecontroller.text.isNotEmpty) {
      if (!isedit) {
        setState(() {
          importData(TodoModel(
              head: titlecontroller.text.trim(),
              desc: desccontroller.text.trim(),
              date: datecontroller.text.trim()));
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            content: Text(
              "Todo item added",
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
            backgroundColor: Color.fromRGBO(142, 147, 150, 0.655),
            duration: Durations.extralong4,
            padding: EdgeInsets.all(
                10), // backgroundColor: Color.fromARGB(147, 84, 158, 237),
          ));
        });
      } else {
        setState(() async {
          todoobj!.head = titlecontroller.text.trim();
          todoobj.desc = desccontroller.text.trim();
          todoobj.date = datecontroller.text.trim();
          await updateTask(todoobj);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            content: Text(
              "Todo item edited",
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
            backgroundColor: Color.fromRGBO(142, 147, 150, 0.655),
            duration: Durations.extralong4,
            padding: EdgeInsets.all(10),
          ));
        });
        await getallTask();
        setState(() {});
      }
      titlecontroller.clear();
      desccontroller.clear();
      datecontroller.clear();
    }
  }

  Future getallTask() async {
    List listData = await getData();
    setState(() {
      cardList = listData;
    });
  }

  @override
  Widget build(BuildContext context) {
    getallTask();
    // getData();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(111, 81, 255, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Text(
                    "Good Morning",
                    style: GoogleFonts.quicksand(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Pranjal",
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  )
                ],
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(217, 217, 217, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )),
                  child: Column(
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(top: 7, bottom: 8)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "CREATE TO DO LIST",
                        style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: const Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                          child: Container(
                        width: 420,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            )),
                        child: ListView.builder(
                          itemCount: cardList.length,
                          itemBuilder: (context, index) {
                            isDone.add(false);
                            return Slidable(
                              direction: Axis.horizontal,
                              closeOnScroll: true,
                              endActionPane: ActionPane(
                                  extentRatio: 0.2,
                                  motion: const DrawerMotion(),
                                  children: [
                                    Expanded(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            GestureDetector(
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                              onTap: () {
                                                editTask(cardList[index]);
                                              },
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            GestureDetector(
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  deletetask(cardList[index]);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10))),
                                                    content: Text(
                                                      "Todo item deleted",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                    backgroundColor:
                                                        Color.fromRGBO(142, 147,
                                                            150, 0.655),
                                                    duration:
                                                        Durations.extralong4,
                                                    padding: EdgeInsets.all(10),
                                                  ));
                                                });
                                              },
                                            ),
                                          ]),
                                    )
                                  ]),
                              key: ValueKey(index),
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 20, bottom: 2),
                                padding: const EdgeInsets.all(16),
                                width: 390,
                                height: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Color.fromRGBO(200, 199, 202, 0.733),
                                      blurRadius: 10,
                                    )
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 52,
                                      width: 52,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromRGBO(217, 217, 217, 1),
                                          boxShadow: []),
                                      child: Image.asset(
                                          imagelist[index % imagelist.length]),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${cardList[index].head}",
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            "${cardList[index].desc}",
                                            style: GoogleFonts.inter(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${cardList[index].date}",
                                          style: GoogleFonts.inter(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),

                                    //const SizedBox(width: 15,),
                                    Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      activeColor: Colors.green,
                                      value:isDone[index],
                                      onChanged: (val) {
                                        // log("In checkbox");
                                        
                                        setState(() {
                                         isDone[index]=!isDone[index];
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )),
                    ],
                  )),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(89, 57, 241, 1),
        onPressed: () {
          showMyBottomsheet(false);
          titlecontroller.clear();
          desccontroller.clear();
          datecontroller.clear();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 27,
        ),
      ),
    );
  }
}
