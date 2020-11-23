const express = require("express");
const router = express.Router();
const indexController = require("./../controllers/index.comtroller");

router.get("/", indexController.index);
router.get("/test", indexController.test);

module.exports = router;
