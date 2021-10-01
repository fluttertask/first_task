const mongoose =  require('mongoose');

const connection = () => {
	mongoose.connect('mongodb://localhost:27017/ProDB',
	{ 
		useCreateIndex: true,
		useFindAndModify: true,
		useUnifiedTopology: true,
		useNewUrlParser: true
	}
	);

	mongoose.connection.once('open', ()=>{
		console.log('Db open successfully');
	})
}

module.exports =  connection;
