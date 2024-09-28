const db = require('../config/db');
const mongoose = require('mongoose');
const UserModel = require('./user_model');

const todoSchema = mongoose.Schema({
    userId : {
        type : mongoose.Schema.Types.ObjectId,
        ref : 'user',
    },
    title : {
        type: String,
        required: true,
    },
    description : {
        type: String,
        required: true,
    },

    isDeleted : {
        type : Boolean,
        default : false
    }

});

const ToDoModel = db.model('todo', todoSchema);

module.exports = ToDoModel;