const UserModel = require("../models/user_model");
const jwt = require("jsonwebtoken");

class UserService {
  static async signupUser(email, password) {
    try {
      const createdUser = new UserModel({ email, password });
      return await createdUser.save();
    } catch (err) {
      throw err;
    }
  }

  static async checkUser(email) {
    try {
      return await UserModel.findOne({ email });
    } catch (error) {
      throw error;
    }
  }

  static async generateToken(tokenData, secretKey, jwt_expire) {
    try {
      return jwt.sign(tokenData, secretKey, { expiresIn: jwt_expire });
    } catch (error) {
      throw error;
    }
  }
}

module.exports = UserService;
