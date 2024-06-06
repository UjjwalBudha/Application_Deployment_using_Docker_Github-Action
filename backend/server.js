const express = require('express');
const bodyParser = require('body-parser');
const db = require('./database');

const app = express();
const PORT = 3000;

app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({ extended: false }));

app.get('/', (req, res) => {
  db.query("SELECT * FROM users", (err, rows) => {
    if (err) {
      throw err;
    }
    res.render('index', { users: rows });
  });
});

app.get('/add', (req, res) => {
  res.render('add');
});

app.post('/add', (req, res) => {
  const name = req.body.name;
  db.query("INSERT INTO users (name) VALUES (?)", [name], (err) => {
    if (err) {
      throw err;
    }
    res.redirect('/');
  });
});

app.listen(PORT, () => {
  console.log(`Server running at http://0.0.0.0:${PORT}/`);
});
