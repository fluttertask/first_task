const ProductsModel = require('../Model/Products.js')

class ProductRepo {
	async getProduct(next) {
		ProductsModel.find(
			{},
			(err, result)=>{
				if (err) return next(err, null);
				return next(null, result);
			}
		)
	}

	async addProduct(next) {
		const { doors, color, type, passenger_capacity, make, model, manufacturing_year, plate_number } = data

		var product = ProductsModel({
			doors: doors,
			color: color,
			type: type,
			passenger_capacity: passenger_capacity,
			make: make,
			model: model,
			manufacturing_year: manufacturing_year,
			plate_number: plate_number
		});
		product.save()
			.then((result)=>{
				return next(null, result);
			}).catch((err)=>{
				return next(err, null);
			})

	}

	async updateProduct(data, next) {
		const { doors, color, type, passenger_capacity, make, model, manufacturing_year, plate_number, active } = data;

		await Products.findOneAndUpdate(
			{ name: data.name },
			{
				$set: {
					doors: doors,
					color: color,
					type: type,
					passenger_capacity: passenger_capacity,
					make: make,
					model: model, manufacturing_year: manufacturing_year,
					plate_number: plate_number,
					active: active
				},
			},
			(err, result)=>{
				if (err)
				return next(err, null);
				else
				return next(null, result);
			}
		)
	}


}

module.exports = new ProductRepo()
