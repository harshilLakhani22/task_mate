const UserService = require("../services/user_services");

/// Signup
exports.signup = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    const user = await UserService.signupUser(email, password);

    let tokenData = { _id: user._id, email: user.email };

    const token = await UserService.generateToken(tokenData, "secretKey", "1h");

    res.json({
      status: "success",
      msg: "User Registration Successfully",
      token: token,
    });
  } catch (err) {
    next(err);  // Ensure error is passed to error handling middleware
  }
};

/// Login
exports.login = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    const user = await UserService.checkUser(email);

    if (!user) {
      throw new Error("User Not Found");
    }

    const isMatch = await user.comparePassword(password);

    if (!isMatch) {
      throw new Error("Invalid Password");
    }

    let tokenData = { _id: user._id, email: user.email };

    const token = await UserService.generateToken(tokenData, "secretKey", "1h");

    res.status(200).json({
      status: "success",
      msg: "User Login Successfully",
      token: token,
    });
  } catch (error) {
    next(error);  // Ensure error is passed to error handling middleware
  }
};
