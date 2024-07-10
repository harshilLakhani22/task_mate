const app = require("./app");
const connection = require('./config/db');
const UserModel = require('./models/user_model');
const ToDoModel = require('./models/todo_model');

const PORT = 3000;


app.listen(PORT, () => console.log(`Server Started At Port :- ${PORT}`));
