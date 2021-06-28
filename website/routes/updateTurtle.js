var express = require('express');
const { config } = require('../db/config')
const sql = require('mssql/msnodesqlv8')
var router = express.Router();

/* GET users listing. */
router.get('/update', function(req, res, next) {

    if (req.session.isAdmin == true) {
        res.render('updateTurtle')
    } else {
        res.render('adminRestricted')
    }
});



router.post('/update', async function(req, res, next) {

    //console.log(req.body)

    try {

        if (typeof req.body.breed !== "undefined" && req.body.breed === "") {
            throw Error("The name cannot be empty!");
        }

        console.log(req.body.id, req.body.releaseDate)

        // SAVE DATA TO SQL
        const pool = await sql.connect(config);
        const result = await pool.request()
            .input("Id", sql.Int, req.body.id)
            .input("ReleaseDate", sql.Date, req.body.releaseDate)
            .query(`UPDATE AnimalRecords SET ReleasedOn = @ReleaseDate
            WHERE AnimalId = @Id
                  `)
            //console.log(result)

    } catch (e) {
        console.log(e);

        if (e instanceof sql.RequestError) {
            return displayError(res, "A database error has occured! Please try again later.");
        } else {
            return displayError(res, e.message);
        }
    }

    res.redirect("/turtles/update");
});
module.exports = router;