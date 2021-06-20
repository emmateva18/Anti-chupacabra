var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {
  //res.render('team', { user: { name: "Jelyazko", id: 16 } })
  res.render('team', { user1: { name: "Jelyazko", id: 16 } })
});

module.exports = router;
