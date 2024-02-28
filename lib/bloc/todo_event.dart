part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable {
  TodoEvent();
  @override
  List<Object?> get props => [];
}



class TodoStarted extends TodoEvent{}



class AddTodo extends TodoEvent{
  final Todo todo;
   AddTodo(this.todo);


  @override
  List<Object?> get props => [todo];
}

class RemoveTodo extends TodoEvent{
  final Todo todo;
  RemoveTodo(this.todo);


  @override
  List<Object?> get props => [todo];
}


class AlterTodo extends TodoEvent{
  final int index;
  AlterTodo(this.index);


  @override
  List<Object?> get props => [index];
}




