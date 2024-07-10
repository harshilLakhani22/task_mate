const express = require('express');
const body_parser = require('body-parser');
const UserRoutes = require('./routes/user_routes');
const TodoRoutes = require('./routes/todo_routes');


const app = express();

app.use(body_parser.json());

app.use('/', UserRoutes);
app.use('/', TodoRoutes);

module.exports = app;