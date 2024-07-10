const router = require('express').Router();
const TodoController = require('../controllers/todo_controller');
const authMiddleware = require('../middleware/auth_middleware');


// router.post("/addTodo", authMiddleware, ToDoController.addTodo);
// router.get("/getToDoList", authMiddleware, ToDoController.getUserTodos);

router.post('/addToDo', TodoController.addTodo);

router.get('/getToDoList', TodoController.getToDoList);
router.post('/getToDoList', TodoController.getToDoList);

router.post('/updateToDo', TodoController.updateTodo);

module.exports = router;