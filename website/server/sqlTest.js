// NOT NEEDED: const SQL = require('mssql')
// FIRST DO: 
// npm install mssql
// npm install msnodesqlv8
const sql = require('mssql/msnodesqlv8')

const sqlConfig = {
    database: 'AntiChupacabra',
    server: '.\\SQLExpress',
    pool: {
        max: 10,
        min: 0,
        idleTimeoutMillis: 30000
    },
    options: {
        trustedConnection: true,
        encrypt: false, // FOR Azure
        trustServerCertificate: false // CHANGE TO TRUE FOR LOCAL dev / self-signed certs
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
        const pool = await sql.connect(sqlConfig)
        console.log("Connected")
        let inp = "SELECT * FROM Admins";
        const result = await pool.request()
            //.query(`SELECT TOP 2 * FROM production.products;`) 
            //.INPUT("fn", SQL.NVarChar, "Мария")           
            .query(`SELECT * FROM Admins`)
            //.query(`EXEC Tutorial.dbo.CreateUser N'User1' N'Pass123'`)
        console.log(result)
            //console.log(RESULT.recordset[0].PasswordHash.toString('utf16le'))
            //RESULT.recordset.map(rec => console.log(rec.product_name))
    } catch (err) {
        console.log(err)
    }
})()