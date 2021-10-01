import 'package:flutter/material.dart';
import 'package:flutter_task/Src/Models/Product.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key, this.product}) : super(key: key);
  final Product? product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late TextEditingController _doorsCT,
      _colorCT,
      _typeCT,
      _passengerCapacityCT ,
      _ownerCT,
      _makeCT,
      _modelCT,
      _yearCT,
      _plateNumberCT;

  @override
  void initState() { 
    super.initState();
    
  _doorsCT = TextEditingController();
  _colorCT = TextEditingController();
  _typeCT = TextEditingController();
  _passengerCapacityCT = TextEditingController();
  _ownerCT = TextEditingController();
  _makeCT = TextEditingController();
  _modelCT = TextEditingController();
  _yearCT = TextEditingController();
  _plateNumberCT = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Container(
        color: Colors.white,
        width: size.width - 20,
        padding: const EdgeInsets.all(10),
        height: 600,
        child: Column(
          children: [
            Row(
              children: [
                const CarBox(),
                Column(
                  children: [
                    CustomTextField(textEditingController: _doorsCT),
                    CustomTextField(textEditingController: _colorCT),
                    CustomTextField(textEditingController: _typeCT)
                  ],
                )
              ],
            ),
            Row(
              children: [
                CustomTextField(textEditingController: _passengerCapacityCT),
                CustomTextField(textEditingController: _ownerCT)
              ],
            ),
            CustomTextField(textEditingController: _makeCT),
            CustomTextField(textEditingController: _modelCT),
            CustomTextField(textEditingController: _yearCT),
            CustomTextField(textEditingController: _plateNumberCT)
          ],
        ),
      ),
    );
  }
}


class CarBox extends StatelessWidget {
  const CarBox({ Key? key, this.child }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 200,
          width: 200,
          child: CircleAvatar(
            child: child?? const SizedBox()
          ),
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({required this.textEditingController, Key? key }) : super(key: key);

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}



