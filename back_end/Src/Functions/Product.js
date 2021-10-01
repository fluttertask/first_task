const express = require('express');
const ProductRepo = require('../Repositories/ProductRepo.js')

const ProductFunctions = {
	getProduct: async (req, res) => {

		await ProductRepo.getProduct((err, product)=>{
			if (err){
				return res.json({ error: error, success: null })
			}
			return res.json({ error: null, success: products })
		});
	},

	addProduct: async (req, res) => {
		try {
			const { doors, color, type, passenger_capacity, make, model, manufacturing_year, plate_number, active } = req.body

			const data = {
				doors: doors,
				color: color,
				type: type,
				passenger_capacity: passenger_capacity,
				make: make,
				model: model,
				manufacturing_year: manufacturing_year,
				plate_number: plate_number
			}

			await ProductRepo.addProduct(data, (err, product) => {
				if (err)
				return res.json({ error: error, success: null });
				else
				return res.json({ error: null, success: product });
			});
			
		} catch (err) {
			return res.json({ error: error, success: false });
		}
	},

	updateProduct: async (req, res) => {
		try {
			const { doors, color, type, passenger_capacity, make, model, manufacturing_year, plate_number } = req.body

			const data = {
				doors: doors,
				color: color,
				type: type,
				passenger_capacity: passenger_capacity,
				make: make,
				model: model, manufacturing_year: manufacturing_year,
				plate_number: plate_number
			}

			await ProductRepo.updateProduct(data);

			return res.json({ error: null, success: true })
		} catch (error) {
			return res.json({ error: error, success: false });
		}
	},
}

module.exports = ProductFunctions;
