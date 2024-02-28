import 'package:counter_with_bloc/bloc/todo_bloc.dart';
import 'package:counter_with_bloc/data/todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  addTodo(Todo todo) {
    context.read<TodoBloc>().add(
          AddTodo(todo),
        );
  }

  removeTodo(Todo todo) {
    context.read<TodoBloc>().add(
          RemoveTodo(todo),
        );
  }

  alterTodo(int index) {
    context.read<TodoBloc>().add(
          AlterTodo(index),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                TextEditingController controller1 = TextEditingController();
                TextEditingController controller2 = TextEditingController();
                return AlertDialog(
                  title: Text("Add a task"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: controller1,
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        decoration: InputDecoration(
                          hintText: "Task Title..",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: controller2,
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        decoration: InputDecoration(
                          hintText: "Task Description..",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextButton(
                        onPressed: () {
                          addTodo(
                            Todo(
                              title: controller1.text,
                              subtitle: controller2.text,
                            ),
                          );
                          controller1.text = '';
                          controller2.text = '';
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          foregroundColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Icon(
                            CupertinoIcons.checkmark,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: Text(
          "Todo",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
          if (state.status == TodoStatus.success) {
            return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, int i) {
                  return Card(
                    color: Theme.of(context).colorScheme.primary,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Slidable(
                      key: ValueKey(0),
                      startActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) {
                              removeTodo(
                                state.todos[i],
                              );
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          state.todos[i].title,
                        ),
                        subtitle: Text(
                          state.todos[i].subtitle,
                        ),
                        trailing: Checkbox(
                          value: state.todos[i].isDone,
                          activeColor: Theme.of(context).colorScheme.primary,
                          onChanged: (value) {
                            alterTodo(i);
                          },
                        ),
                      ),
                    ),
                  );
                });
          } else if (state.status == TodoStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
