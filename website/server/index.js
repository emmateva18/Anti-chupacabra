const express = require('express')
const app = express()
const port = 3001

//express.static('??', [options])
//app.use(express.static('public'))

// set the view engine to ejs
app.set('view engine', 'ejs');

app.get('/', (req, res) => {
    //res.send('Hello World!')
    res.render('../public/index');
})

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
})