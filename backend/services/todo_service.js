const ToDoModel = require("../models/todo_model");

class ToDoService {
  static async addToDO(userId, title, description) {
    try {
      const createdTodo = new ToDoModel({ userId, title, description });
      return await createdTodo.save();
    } catch (error) {
      throw error;
    }
  }
  static async getToDoList(userId) {
    try {
      const toDoList = await ToDoModel.find({ userId });
      return toDoList;
    } catch (error) {
      throw error;
    }
  }

  static async updatedToDo(todoId, updateData) {
    try {
      return await ToDoModel.findByIdAndUpdate(todoId, updateData, {
        new: true,
      });
    } catch (error) {
      throw error;
    }
  }
}

module.exports = ToDoService;
