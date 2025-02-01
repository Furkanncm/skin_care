import 'package:bloc_clean_architecture/src/common/configuration/configuration.dart';
import 'package:bloc_clean_architecture/src/data/model/todo_model/response/todo_model.dart';
import 'package:bloc_clean_architecture/src/presentation/todo/bloc/todo_bloc.dart';
import 'package:bloc_clean_architecture/src/presentation/todo/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (context) => getIt<TodoBloc>()..add(TodoInitializedEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<CounterCubit>(),
        ),
      ],
      child: const Scaffold(
        appBar: TodoAppBar(),
        body: TodoList(),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AddTodoWidget(),
            verticalBox12,
            CounterWidget(),
          ],
        ),
      ),
    );
  }
}

class AddTodoWidget extends StatelessWidget {
  const AddTodoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: UniqueKey().toString(),
      onPressed: () {
        final uniqueKey = UniqueKey().toString();
        final todo = TodoModel(title: 'Title $uniqueKey', description: 'Description $uniqueKey', dateTime: DateTime.now(), isSelected: false);
        context.read<TodoBloc>().add(TodoAddClickedEvent(todo));
      },
      child: const Icon(Icons.add),
    );
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: UniqueKey().toString(),
      onPressed: () {},
      child: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state.status == TodoStatus.success) {
            context.read<CounterCubit>().set(state.todos.where((element) => element.isSelected ?? false).length);
          }
        },
        child: Text(context.watch<CounterCubit>().state.toString()),
      ),
    );
  }
}

class TodoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TodoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
        decoration: const InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
        ),
        onChanged: (String value) => context.read<TodoBloc>().add(
              TodoSearchTriggeredEvent(value),
            ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return switch (state.status) {
          TodoStatus.loading => const Center(child: CircularProgressIndicator()),
          TodoStatus.success => ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return GestureDetector(
                  onLongPress: () {
                    context.read<TodoBloc>().add(TodoDeleteClickedEvent(todo));
                  },
                  child: CheckboxListTile(
                    value: todo.isSelected ?? false,
                    title: Text(todo.title ?? ''),
                    subtitle: Text(todo.description ?? ''),
                    onChanged: (value) {
                      context.read<TodoBloc>().add(TodoCheckboxClickedEvent(todo));
                    },
                  ),
                );
              },
            ),
          TodoStatus.error => Center(child: Text(state.errorMessage)),
        };
      },
    );
  }
}
