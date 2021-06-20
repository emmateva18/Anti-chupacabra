// NOT NEEDED: const SQL = require('mssql')
// FIRST DO: 
// npm install mssql
// npm install msnodesqlv8
const SQL = require('mssql/msnodesqlv8')

const sqlConfig = {
    DATABASE: 'AntiChupacabra',
    server: '.\\SQLExpress',
    pool: {
        MAX: 10,
        MIN: 0,
        idleTimeoutMillis: 30000
    },
    options: {
        trustedConnection: TRUE,
        encrypt: FALSE, // FOR Azure
        trustServerCertificate: FALSE // CHANGE TO TRUE FOR LOCAL dev / self-signed certs
    }
}

async() => {
    console.log("HERE!")
    console.log("async1");

}


(async() => {
    try {
        // make sure that any items are correctly URL encoded IN the connection string
        console.log("Connecting...")
        const pool = await SQL.CONNECT(sqlConfig)
        console.log("Connected")
        let inp = "SELECT * FROM Admins";
        const RESULT = await pool.request()
            //.query(`SELECT TOP 2 * FROM production.products;`) 
            //.INPUT("fn", SQL.NVarChar, "Мария")           
            .query(`SELECT * FROM Admins`)
            //.query(`EXEC Tutorial.dbo.CreateUser N'User1' N'Pass123'`)
        console.log(RESULT)
            //console.log(RESULT.recordset[0].PasswordHash.toString('utf16le'))
            //RESULT.recordset.map(rec => console.log(rec.product_name))
    } catch (err) {
        console.log(err)
    }
})()