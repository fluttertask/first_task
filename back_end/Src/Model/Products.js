const { Schema, model } = require('mongoose');

const productSchema =
	new Schema({
		image_url: String,
		doors: String,
		color: String,
		type: String,
		passenger_capacity: Number,
		private_or_type: String,
		make: String,
		model: String,
		manufacturing_year: String,
    	plate_number: String,
		active: Boolean
	})

module.exports = model('product', productSchema);