const mongoose = require("mongoose");
const db = require("../config/db");
const bcrypt = require("bcrypt");
const ToDoModel = require("./todo_model");

const userSchema = mongoose.Schema({
  email: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
});

/// Password hashing
userSchema.pre("save", async function () {
  try {
    var user = this;
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(user.password, salt);
    user.password = hashedPassword;
  } catch (error) {
    throw error;
  }
});

userSchema.methods.comparePassword = async function (userPassword) {
  try {
    const isMatch = await bcrypt.compare(userPassword, this.password);
    return isMatch;
  } catch (error) {
    throw error;
  }
};

const UserModel = db.model("user", userSchema);

module.exports = UserModel;
