const mysql = require('mysql2');

const pool = mysql.createPool({
  host: 'mysql',
  user: 'ujwal',
  password: 'ujwal1234',
  database: 'test_db',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

module.exports = pool;