const express = require('express');
const multer  = require('multer');

const upload = multer({ dest: 'Public/Uploads/' });
const ProductFunctions = require('../Functions/Product');

const router = express.Router();

router.get('/getProduct', ProductFunctions.getProduct);

router.post('/addProduct',upload.single('image'), ProductFunctions.addProduct);

router.post('/updateProduct',upload.single('image'), ProductFunctions.updateProduct);


module.exports = router;
