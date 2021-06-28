var express = require('express');
const { config } = require('../db/config')
const sql = require('mssql/msnodesqlv8')
var session = require('express-session')
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
    //res.render('team', { user: { name: "Jelyazko", id: 16 } })

    async function run() {

        res.render('charts', {
            chartByDaysData: await getchartByDaysDataData(),
            chartByYearCountData: await getchartByYearCountDataData(),
            chartByGenderData: await getchartByGenderDataData(),
            charByTopCities: {
                data1: 1,
                data2: 4,
                data3: 5,
                data4: 2,
                data5: 6
            }
        });
    }

    run();

});

async function getchartByGenderDataData() {
    try {

        // SAVE DATA TO SQL


        const pool = await sql.connect(config);
        const resultMale = await pool.request()
            //.query(`SELECT TOP 2 * FROM production.products;`) 
            .query(`
            SELECT [Sex] FROM Animals WHERE [Sex] = 'true'
        `)
        const resultFemale = await pool.request()
            //.query(`SELECT TOP 2 * FROM production.products;`) 
            .query(`
        SELECT [Sex] FROM Animals WHERE [Sex] = 'false'
    `)
        console.log(resultMale.recordset.length, resultFemale.recordset.length)
        return [resultMale.recordset.length, resultFemale.recordset.length]


    } catch (e) {
        console.log(e);

        if (e instanceof sql.RequestError) {
            return displayError(res, "A database error has occured! Please try again later.");
        } else {
            return displayError(res, e.message);
        }
    }
}



async function getchartByYearCountDataData() {
    try {

        // SAVE DATA TO SQL

        let data1 = 0,
            data2 = 0,
            data3 = 0,
            data4 = 0,
            data5 = 0;
        const pool = await sql.connect(config);
        const result = await pool.request()
            //.query(`SELECT TOP 2 * FROM production.products;`) 
            .query(`
        SELECT [Duration] FROM AnimalRecords WHERE [Duration] is not NULL
        `)
            //.query(`EXEC Tutorial.dbo.CreateUser N'User1' N'Pass123'`)
            //console.log(result.recordsets[0][0].Duration)



    } catch (e) {
        console.log(e);

        if (e instanceof sql.RequestError) {
            return displayError(res, "A database error has occured! Please try again later.");
        } else {
            return displayError(res, e.message);
        }
    }
}

async function getchartByDaysDataData() {
    try {

        // SAVE DATA TO SQL

        let data1 = 0,
            data2 = 0,
            data3 = 0,
            data4 = 0,
            data5 = 0;
        const pool = await sql.connect(config);
        const result = await pool.request()
            //.query(`SELECT TOP 2 * FROM production.products;`) 
            .query(`
        SELECT [Duration] FROM AnimalRecords WHERE [Duration] is not NULL
        `)
            //.query(`EXEC Tutorial.dbo.CreateUser N'User1' N'Pass123'`)
            //console.log(result.recordsets[0][0].Duration)

        for (let i = 0; i < result.recordset.length; i++) {
            if (result.recordsets[i][0].Duration >= 1 && result.recordsets[i][0].Duration <= 5) {
                data1++;
            } else if (result.recordsets[i][0].Duration >= 6 && result.recordsets[i][0].Duration <= 10) {
                data2++;
            } else if (result.recordsets[i][0].Duration >= 11 && result.recordsets[i][0].Duration <= 20) {
                data3++;
            } else if (result.recordsets[i][0].Duration >= 21 && result.recordsets[i][0].Duration <= 50) {
                data4++;
            } else if (result.recordsets[i][0].Duration >= 51) {
                data5++;
            }
            //console.log(data1, data2, data3, data4, data5)
            return [data1, data2, data3, data4, data5];
        }

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