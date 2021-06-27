var express = require('express');
const { config } = require('../db/config')
const sql = require('mssql/msnodesqlv8')
var router = express.Router();

/* GET users listing. */
router.get('/update', function(req, res, next) {
    //res.render('team', { user: { name: "Jelyazko", id: 16 } })
    res.render('updateTurtle')
});

module.exports = router;