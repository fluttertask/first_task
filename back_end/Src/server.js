const express = require('express');

const app = express()
require('./Config/connection')();

const route = require('./routes/route');

const PORT = process.env.PORT || 3000;

// app.use(cors())

app.listen(PORT, () => {
	console.log(`server connected to ${PORT}`);
})
