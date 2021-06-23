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
            .query(`SELECT [Username], [PasswordHash] FROM Admins`)

        const crypto = require('crypto')

        const sha256sum = crypto.createHash('sha256');
        const passHashed = sha256sum.update(req.body.password).digest('hex');

        //console.log(res);

        if (req.body.username == result.recordset[0].Username) {
            console.log("Username matched")
        }

        if (passHashed == result.recordset[0].PasswordHash) {
            console.log("Password matched")
        }

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