const express = require('express');

const app = express();

app.get('/', (req, res) => {
  res.send('First Server is running!');
});

app.listen(3001);
