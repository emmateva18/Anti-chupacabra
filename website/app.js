var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var session = require('express-session')



var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var teamRouter = require('./routes/team');
var turtleRegistrationRouter = require('./routes/turtleRegistration');
var adminLogin = require('./routes/adminLogin');
var chartRouter = require('./routes/charts');
var turtleUpdateRouter = require('./routes/updateTurtle');
var turtleDataRouter = require('./routes/turtleData');
var adminRouter = require('./routes/adminIndex');
var bodyParser = require('body-parser')

var app = express();

app.use(session({
    secret: 'keyboard cat',
    resave: false,
    saveUninitialized: true
}))

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/team', teamRouter);
app.use('/turtles', turtleRegistrationRouter);
app.use('/admin', adminLogin);
app.use('/charts', chartRouter);
app.use('/turtles', turtleUpdateRouter);
app.use('/turtles', turtleDataRouter);
app.use('/admin', adminRouter);


// catch 404 and forward to error handler
app.use(function(req, res, next) {
    next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    // render the error page
    res.status(err.status || 500);
    res.render('error');
});

module.exports = app;