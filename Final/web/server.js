var express = require('express');
var bodyParser = require('body-parser');
var mysql = require('mysql');
var $ = require('jquery');
var app = express();
var handlebars = require('express-handlebars').create({defaultLayout: 'main'});

app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');
app.set('port', 56789);
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());
app.use(express.static('public'));

var pool = mysql.createPool({
   host: 'classmysql.engr.oregonstate.edu',
   database: 'cs340_fondellb',
   user: 'cs340_fondellb',
   password: '1507'
});

module.exports.pool = pool;
console.log("success");

app.get('/', function(req, res) {
	res.render('home');
});

var get_cell_data = function(res, table) {
  var ctx = {};
  pool.query('SELECT * FROM ' + table, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = rows;
    res.send(ctx);
  });
};

app.get('/artists', function(req, res) {
  get_cell_data(res, 'artists');
});

app.get('/country', function(req, res) {
  get_cell_data(res, 'country');
});

app.get('/city', function(req, res) {
  get_cell_data(res, 'city');
});

app.get('/medium', function(req, res) {
  get_cell_data(res, 'medium');
});

app.get('/artists_medium', function(req, res) {
  get_cell_data(res, 'artists_medium');
});

app.get('/artists_residence', function(req, res) {
  get_cell_data(res, 'artists_residence');
});


app.post('/search_artists', function(req, res) {
  console.log("Searching...");
  var ctx = {};
  var body = req.body;
  var queryStr = "SELECT artists.fname, artists.lname FROM artists ";
  queryStr += 'INNER JOIN artists_residence ON artists.id = artists_residence.artists_id ';
  queryStr += 'INNER JOIN city ON artists_residence.city_id = city.id';
  queryStr += 'INNER JOIN country ON city.fk_country_id = country.country_id';
  queryStr += ' WHERE country.name = "' + body.name + '";';

  pool.query(queryStr, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = rows;
    res.render(ctx.results);
    res.send(ctx);
  });
});

var update_query = function(body, table) {
  var keys = [];
  var values = [];
  var str = '';
  for (var key in body) {
    keys.push(key);
    values.push("'" + body[key] + "'");
  }
  str += "INSERT INTO " + table;
  str += "(" + keys.join(",") + ")";
  str += " VALUES (" + values.join(",") + ");";

  return str;
};

var update_table = function(req, res, table) {
  var update_string = update_query(req.body, table);

  pool.query(update_string, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    res.send(JSON.stringify(rows));
  });
};

app.post('/artists', function(req, res) {
  update_table(req, res, 'artists');
});

app.post('/country', function(req, res) {
  update_table(req, res, 'country');
});

app.post('/city', function(req, res) {
  update_table(req, res, 'city');
});

app.post('/medium', function(req, res) {
  update_table(req, res, 'medium');
});

app.post('/artists_medium', function(req, res) {
  update_table(req, res, 'artists_medium');
});

app.post('/artists_residence', function(req, res) {
  update_table(req, res, 'artists_residence');
});

var delete_cell = function(req, res, table) {
  var ctx = {};
  var id = req.body.id;
  pool.query('DELETE FROM ' + table + ' WHERE id = ' + id, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = JSON.stringify(rows);
    res.send(ctx);
  });
};

app.delete('/artists', function(req, res) {
  delete_cell(req, res, 'artists');
});

app.delete('/country', function(req, res) {
  delete_cell(req, res, 'country');
});

app.delete('/city', function(req, res) {
  delete_cell(req, res, 'city');
});

app.delete('/medium', function(req, res) {
  delete_cell(req, res, 'medium');
});

app.delete('/artists_medium', function(req, res) {
  delete_cell(req, res, 'artists_medium');
});

app.delete('/artists_residence', function(req, res) {
  delete_cell(req, res, 'artists_residence');
});

app.delete('/artists_residence', function(req, res) {
  var ctx = {};
  var body = req.body;
  var actor_id = body.artists_id;
  var series_id = body.city_id;

  var queryStr = 'DELETE FROM artists_residence WHERE artists_residence = ' + artists_id;
  queryStr += ' AND city_id = ' + city_id + ';';

  pool.query(queryStr, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = JSON.stringify(rows);
    res.send(ctx);
  });
});

app.delete('/artists_medium', function(req, res) {
  var ctx = {};
  var body = req.body;
  var actor_id = body.artists_id;
  var character_id = body.medium_id;

  var queryStr = 'DELETE FROM artists_medium WHERE artists_id = ' + artists_id;
  queryStr += ' AND medium_id = ' + medium_id + ';';

  pool.query(queryStr, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = JSON.stringify(rows);
    res.send(ctx);
  });
});


app.use(function(req, res) {
	res.status(404);
	res.render('404');
});

app.use(function(err, req, res, next){
	console.log(err.stack);
	res.status(500);
	res.render('500');
});

app.listen(app.get('port'), function() {
	console.log('Application started on port ' + app.get('port'));
});