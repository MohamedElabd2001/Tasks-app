part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, success, error }

class TodoState extends Equatable {
  final List<Todo> todos;
  final TodoStatus status;

  const TodoState({
    this.todos = const <Todo>[],
    this.status = TodoStatus.initial,
  });

  TodoState copyWith({
    TodoStatus? status,
    List<Todo>? todos,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      status: status ?? this.status,
    );
  }

  @override
  factory TodoState.fromJson(Map<String, dynamic> json) {
    try {
      var listOfTodos = (json['todo'] as List<dynamic>)
          .map((e) => Todo.fromJson(e as Map<String, dynamic>))
          .toList();

      return TodoState(
        todos: listOfTodos,
        status: TodoStatus.values.firstWhere(
              (element) => element.toString() == 'TodoStatus.${json['status']}',
          orElse: () => TodoStatus.initial, // Provide a default value if not found
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'todo': todos,
      'status': status.toString().split('.').last, // Convert enum to string
    };
  }


  @override
  // TODO: implement props
  List<Object?> get props => [todos , status];
}
