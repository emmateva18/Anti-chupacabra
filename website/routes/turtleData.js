var express = require('express');
const { config } = require('../db/config')
const sql = require('mssql/msnodesqlv8')
var router = express.Router();


(async() => {
    try {
        let connection = await sql.connect(config);
        const result = await connection.request().query('SELECT * FROM vAnimalRecords');
        console.log(result)
            /* GET users listing. */
        router.get('/data', function(req, res, next) {
            res.render('turtleData', { data: result.recordset });
        });
    } catch (err) {
        console.log(err);
    }
})()

module.exports = router;