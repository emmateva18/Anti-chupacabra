var express = require('express');
const { config } = require('../db/config')
const sql = require('mssql/msnodesqlv8')
var router = express.Router();



/* GET users listing. */
router.get('/registration', function(req, res, next) {
    //res.render('team', { user: { name: "Jelyazko", id: 16 } })
    res.render('turtle-registration')
});

//  localhost/turtles/register GET => show reg form
// POST => process the form / insert into SQL

function displayError(res, message) {
    res.render('turtle-registration', { error: message })
}

router.post('/registration', async function(req, res, next) {
    console.log(req.body)


    try {

        if (typeof req.body.name !== "undefined" && req.body.name === "") {
            throw Error("The name cannot be empty!");
        }

        // SAVE DATA TO SQL
        const pool = await sql.connect(config);
        const result = await pool.request()
            //.query(`SELECT TOP 2 * FROM production.products;`) 
            .input("Name", sql.NVarChar, req.body.name)
            .input("Breed", sql.NVarChar, req.body.breed)
            .input("Sex", sql.Bit, req.body.sex)
            .input("Age", sql.SmallInt, req.body.age)
            .query(`
                INSERT INTO Animals (Name, Breed, Sex, Age)
                VALUES (@Name, @Breed, @Sex, @Age)
            `)
            //.query(`EXEC Tutorial.dbo.CreateUser N'User1' N'Pass123'`)
        console.log(result)

    } catch (e) {
        console.log(e);

        if (e instanceof sql.RequestError) {
            return displayError(res, "A database error has occured! Please try again later.");
        } else {
            return displayError(res, e.message);
        }
        return;
    }

    res.redirect("/turtles/registration");
});

module.exports = router;