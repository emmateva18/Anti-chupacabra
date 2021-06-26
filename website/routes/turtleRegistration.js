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

async function insertAnimals(req) {

    try {

        if (typeof req.body.breed !== "undefined" && req.body.breed === "") {
            throw Error("The name cannot be empty!");
        }

        // female = 0, male = 1 
        let gender = (req.body.male == "on")

        // SAVE DATA TO SQL
        const pool = await sql.connect(config);
        const result = await pool.request()
            //.query(`SELECT TOP 2 * FROM production.products;`) 

        .input("Breed", sql.NVarChar, req.body.breed)
            .input("Sex", sql.Bit, gender)
            .input("Age", sql.SmallInt, req.body.age)
            .query(`
                      INSERT INTO Animals (Breed, Sex, Age)
                      VALUES (@Breed, @Sex, @Age)
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
    }
}

async function insertRecord(req, res) {
    try {

        if (typeof req.body.name !== "undefined" && req.body.name === "") {
            throw Error("The name cannot be empty!");
        }

        let isInjured = (req.body.isInjured == "on")
        let severity = null;
        if (req.body.Severity != "undefined") {
            severity = req.body.Severity;
        }
        // SAVE DATA TO SQL
        const pool = await sql.connect(config);
        const result = await pool.request()
            //.query(`SELECT TOP 2 * FROM production.products;`) 
            .input("AnimalId", sql.Int, req.body.id)
            .input("AcceptedOn", sql.Date, req.body.acceptedDate)
            .input("DonatorName", sql.NVarChar, req.body.donatorName)
            .input("DonatorPhone", sql.NVarChar, req.body.donatorPhone)
            .input("Town", sql.SmallInt, req.body.Town)
            .input("Place", sql.SmallInt, req.body.Place)
            .input("IsInjured", sql.SmallInt, isInjured)
            .input("InjurySeverity", sql.SmallInt, req.body.Severity)
            .query(`
                      INSERT INTO Animals (AnimalId, AcceptedOn, DonatorName, DonatorPhone, Town, Place, IsInjured, InjurySeverity)
                      VALUES (@AnimalId, @AcceptedOn, @DonatorName, @DonatorPhone, @Town, @Place, @IsInjured, @InjurySeverity)
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
    }
}

router.post('/registration', async function(req, res, next) {

    console.log(req.body)
        //insertAnimals(req)
        //insertRecord(req, res)

    res.redirect("/turtles/registration");
});

module.exports = router;