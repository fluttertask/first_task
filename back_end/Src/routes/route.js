const express = require('express')
const ProductFunctions = require('../Functions/Product')

const router = express.Router();

router.get('/getProduct', ProductFunctions.getProduct);

router.post('/addProduct', ProductFunctions.addProduct)

router.post('/updateProduct', ProductFunctions.updateProduct);


module.exports = router;
