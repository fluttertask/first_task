const express = require('express');
const path = require('path');

const app = express()
require('module-alias/register');
require('./Config/connection')();

app.use(express.json());
app.use('/images', express.static('Public/Uploads'));

app.get("/test", (req, res) => {
	res.send("server connection working");
});

app.use('/api', require('@routes/route'));

const PORT = process.env.PORT || 3000;

// app.use(cors())

app.listen(PORT, () => {
	console.log(`server connected to ${PORT}`);
})
