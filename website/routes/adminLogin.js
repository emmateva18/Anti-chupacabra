var express = require('express');
var router = express.Router();

router.get('/', function(req, res, next) {
    res.render('adminLogin')
});

router.get('/registration', async function(req, res, next) {
    console.log(req.body)

    try {

        /*if (typeof req.body.name !== "undefined" && req.body.name === "") {
            throw Error("The name cannot be empty!");
        }*/

        const pool = await sql.connect(config);
        const result = await pool.request()
            //.query(`SELECT TOP 2 * FROM production.products;`) 
            .input("Username", sql.NVarChar, req.body.username)
            .input("Password", sql.NVarChar, req.body.password)

        .query(`
                SELECT [Username], [Password] 
                FROM Admin

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


    res.redirect("/registration");
});
module.exports = router;