var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
    if (req.session.isAdmin == true) {
        res.render('adminIndex');
    } else {
        res.render('adminRestricted')
    }
});

module.exports = router;