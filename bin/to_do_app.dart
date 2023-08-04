import 'dart:io';

void main() {
  List<Task> toDoList = [];

  while (true) {
    showMenu();
    String input = getInput();
    switch (input) {
      case '1':
        addTask(toDoList);
        break;
      case '2':
        completeTask(toDoList);
        break;
      case '3':
        removeTask(toDoList);
        break;
      case '4':
        viewList(toDoList);
        break;
      case '5':
        print('\u001b[1mExiting Application... Goodbye 👋\u001b[0m');
        return;
      default:
        invalidError();
        break;
    }
  }
}

class Task {
  String description;
  bool isComplete;

  Task(this.description, this.isComplete);
}

/// Displays the to-do app menu in the console
void showMenu() {
  print('\u001b[1m~~~~~~~~~~ Menu ~~~~~~~~~~\u001b[0m');
  print('1. Add a task');
  print('2. Complete a task');
  print('3. Delete a task');
  print('4. View to-do list');
  print('5. Exit application');
  print('');
  print('\u001b[38;5;4mSelect an option (1-5):\u001b[0m');
}

/// Returns sanitized user input from the console
String getInput() {
  String? input = stdin.readLineSync();
  print('');
  return sanitizeString(input ?? '');
}

/// Removes leading and trailing whitespace from [input]
String sanitizeString(String input) {
  return input.trim();
}

/// Adds a task to the to-do list
void addTask(List<Task> toDoList) {
  // User input
  print('\u001b[38;5;4mEnter task description:\u001b[0m');
  String task = getInput();

  // Add task to list
  toDoList.add(Task(task, false));
  print('\u001b[38;5;2m✅ Task added to to-do list\u001b[0m');
  print('');
}

/// Marks a to-do list task as complete
void completeTask(List<Task> toDoList) {
  // Handle all tasks already complete
  if (toDoList.every((task) => task.isComplete)) {
    print('\u001b[38;5;1m❌ All tasks already complete\u001b[0m');
    print('');
  } else {
    // Print current to-do list (handles empty list)
    viewList(toDoList);

    // User input
    print('\u001b[38;5;4mEnter the task number to be completed:\u001b[0m');
    int index = int.parse(getInput());

    // Handle invalid input
    if (index == 0 || index > toDoList.length) {
      invalidError();
    } else {
      // Mark task as complete
      Task task = toDoList[index - 1];
      task.isComplete = true;
      print(
          '\u001b[38;5;2m✅ \u001b[1m${task.description}\u001b[0m completed\u001b[0m');
      print('');
    }
  }
}

/// Removes a task from the to-do list
void removeTask(List<Task> toDoList) {
  // Print current to-do list (handles empty list)
  viewList(toDoList);

  // User input
  print('\u001b[38;5;4mEnter the task number to be removed:\u001b[0m');
  int index = int.parse(getInput());

  // Handle invalid input
  if (index == 0 || index > toDoList.length) {
    invalidError();
  } else {
    // Remove task from list
    String task = toDoList.removeAt(index - 1).description;
    print('\u001b[38;5;2m🗑️ \u001b[1m$task\u001b[0m removed\u001b[0m');
    print('');
  }
}

/// Prints the current to-do list to the console
void viewList(List<Task> toDoList) {
  if (toDoList.isEmpty) {
    print('\u001b[38;5;1m❌ To-do list is empty\u001b[0m');
  } else {
    print('\u001b[1mTo-do List:\u001b[0m');
    for (int i = 0; i < toDoList.length; i++) {
      String status = toDoList[i].isComplete ? 'X' : ' ';
      print('${i + 1}. [$status] ${toDoList[i].description}');
    }
    print('');
  }
}

/// Prints an invalid input error message to the console
void invalidError() {
  print('\u001b[38;5;1m❌ Invalid response\u001b[0m');
  print('');
}
