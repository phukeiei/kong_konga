const createError = require("http-errors");

module.exports = {
  index: async (req, res, next) => {
    const message = "Hello from docker API INDEX Router /";
    res.send({ message });
  },
  test: async (req, res, next) => {
    const message = "Hello from docker API INDEX Router /test";
    res.send({ message });
  },
};
