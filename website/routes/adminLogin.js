var express = require('express');
const { config } = require('../db/config')
const sql = require('mssql/msnodesqlv8')
var router = express.Router();



router.get('/login', function(req, res, next) {
    res.render('adminLogin')
});

router.post('/login', async function(req, res, next) {
    //console.log(req.body)

    try {

        /*if (typeof req.body.name !== "undefined" && req.body.name === "") {
            throw Error("The name cannot be empty!");
        }*/

        const pool = await sql.connect(config);
        const result = await pool.request()
            .query(`
                SELECT * FROM Admins
                `)

        if (req.body.username == result.username && req.body.password == result.password) {
            console.log("basi maikata")
        }
        console.log("form: " + req.body.username)
        console.log("result: " + result)
            //console.log(result)

    } catch (e) {
        console.log(e);

        if (e instanceof sql.RequestError) {
            return displayError(res, "A database error has occured! Please try again later.");
        } else {
            return displayError(res, e.message);
        }
    }


    res.redirect("/admin/login");
});
module.exports = router;