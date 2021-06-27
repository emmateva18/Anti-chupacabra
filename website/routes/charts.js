var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
    //res.render('team', { user: { name: "Jelyazko", id: 16 } })
    res.render('charts', {
        chartByDaysData: {
            data1: 1,
            data2: 2,
            data3: 3,
            data4: 4,
            data5: 5
        },
        chartByYearCountData: {
            data1: 1,
            data2: 2,
            data3: 5,
            data4: 3,
            data5: 6
        },
        chartByGenderData: {
            data1: 10,
            data2: 13
        },
        charByTopCities: {
            data1: 1,
            data2: 4,
            data3: 5,
            data4: 2,
            data5: 6
        }
    });
});

async function getData() {
    try {

        // SAVE DATA TO SQL
        const pool = await sql.connect(config);
        const result = await pool.request()
            //.query(`SELECT TOP 2 * FROM production.products;`) 

        .input("Id", sql.Int, req.body.id)
            .input("Age", sql.SmallInt, req.body.age)
            .query(`
            UPDATE Animals
            SET Age = @Age
            WHERE Id = @Id
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

module.exports = router;