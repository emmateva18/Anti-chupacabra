const sqlConfig = {
    database: 'AntiChupacabra',
    server: '(localdb)\\MSSQLLocalDB',
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

module.exports.config = sqlConfig;