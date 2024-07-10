const ToDoService = require("../services/todo_service");
const UserService = require("../services/user_services");

/// Add Todo
exports.addTodo = async (req, res, next) => {
  try {
    const { userId, title, description } = req.body;

    let todo = await ToDoService.addToDO(userId, title, description);

    res.json({
      status: "success",
      msg: "Todo added Successfully",
      data: todo,
    });
  } catch (error) {
     next(error);
  }
};

/// Get Todo
exports.getToDoList = async (req, res, next) => {
  try {
    const { userId } = req.body;

    let toDoList = await ToDoService.getToDoList(userId);

    res.json({
      status: "success",
      msg: "Todos fetched Successfully",
      todoListData: toDoList,
    });
  } catch (error) {
     next(error);
  }
};

/// Edit Todo
exports.updateTodo = async (req, res, next) => {
  try {
    // const todoId = req.body.id;
    const {todoId, title, description } = req.body;

    const updatedToDo = await ToDoService.updatedToDo(todoId, {
      title,
      description,
    });

    if (!updatedToDo) {
      return res.status(404).json({ status: "error", mss: "Todo not found" });
    }

    return res.status(200).json({
      status: "success",
      msg: "Todo Updated Successfully",
      todo: updatedToDo,
    });
    
  } catch (error) {
     next(error);
  }
};
