const mongoose = require("mongoose");

const connection = mongoose
  .createConnection("mongodb://127.0.0.1:27017/node_with_flutter_1")
  .on("open", () => {
    console.log("MongoDB Connected");
  })
  .on("error", () => {
    console.log("MongoDB Connection failed");
  });

module.exports = connection;
