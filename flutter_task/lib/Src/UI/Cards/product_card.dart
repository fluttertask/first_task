import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/Src/Models/Product.dart';
import 'package:image_picker/image_picker.dart';

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
      _passengerCapacityCT,
      _ownerCT,
      _makeCT,
      _modelCT,
      _yearCT,
      _plateNumberCT;

  Product? product;
  
  bool edit = false;

  @override
  void initState() { 
    super.initState();
    product = widget.product;
    
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

    return Container(
      color: Colors.white,
      width: size.width - 20,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      height: 600,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: (size.width/2) - 20,
                child: CarBox(
                  onImageChange: (){},
                  imageSource: product!.imageUrl,

                )
              ),
              SizedBox(
                width: (size.width/2) - 20,
                child: Column(
                  children: [
                    CustomTextField(textEditingController: _doorsCT, hintText: product!.doors),
                    CustomTextField(textEditingController: _colorCT, hintText: product!.color),
                    CustomTextField(textEditingController: _typeCT, hintText: product!.type),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: (size.width/2) - 20,
                child: CustomTextField(textEditingController: _passengerCapacityCT, hintText: product!.passengerCapacity.toString())
              ),

              SizedBox(
                width: (size.width/2) - 20,
                child: CustomTextField(textEditingController: _ownerCT, hintText: product!.owner)
              )
            ],
          ),
          CustomTextField(textEditingController: _makeCT, hintText: product!.make),
          CustomTextField(textEditingController: _modelCT, hintText: product!.model),
          CustomTextField(textEditingController: _yearCT, hintText: product!.manufacturingYear),
          CustomTextField(textEditingController: _plateNumberCT, hintText: product!.plateNumber)
        ],
      ),
    );
  }
}


class CarBox extends StatefulWidget {

  const CarBox({
    Key? key,
    this.child,
    this.onImageChange,
    this.imageSource
  }) : super(key: key);

  final Widget? child;
  final Function? onImageChange;
  final String? imageSource;

  @override
  State<CarBox> createState() => _CarBoxState();
}

class _CarBoxState extends State<CarBox> {
  String? imageSource;

  @override
  void initState() {
    super.initState();
    if (widget.imageSource != null){
      imageSource = widget.imageSource!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: (size.width/2) - 10,
      width: (size.width/2) - 10,
      child: Stack(
        children: [
          Positioned(
            top: 10,
            child:
            widget.imageSource != null ?
            CachedNetworkImage(
              imageUrl: widget.imageSource!,
              imageBuilder: (context, imageProvider) => Container(
              height: (size.width/2) - 30,
              width: (size.width/2) - 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular((size.width/2) - 30),
                color: Colors.white,
                border: Border.all(
                  color: Theme.of(context).dividerColor
                ),
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
            :
            Container(
              height: (size.width/2) - 30,
              width: (size.width/2) - 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular((size.width/2) - 30),
                color: Colors.white,
                border: Border.all(
                  color: Theme.of(context).dividerColor
                ),
                image: imageSource == null ?
                  null:
                  DecorationImage(
                    image: FileImage(File(imageSource!))
                  )
              ),
            )
          ),
          Positioned(
            right: 15,
            bottom: 0,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular((size.width/2) - 30),
                color: Colors.white,
                border: Border.all(
                  color: Theme.of(context).dividerColor)
              ),
              child: IconButton(
                onPressed: _addImage,
                icon: Icon(
                  Icons.camera_alt_outlined,
                  size: 28,
                  color: Theme.of(context).dividerColor,
                ),
              )
            ),
          ),
        ],
      ),
    );
  }

  void _addImage (){
    final _picker = ImagePicker(); 

    _picker.pickImage(source: ImageSource.gallery).then(
      (_pickedImage) {
        setState(() {
          imageSource = _pickedImage!.path;
        });

        if (widget.onImageChange != null) widget.onImageChange!(imageSource);
      }
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({required this.textEditingController, Key? key, required this.hintText }) : super(key: key);

  final TextEditingController textEditingController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            spreadRadius: 2,
            blurRadius: 5,
          ),
          BoxShadow(
            color: Colors.grey[100]!,
            blurRadius: 2.5,
          )
        ]
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: hintText,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
                style: BorderStyle.none
              ),
              gapPadding: 6
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
                style: BorderStyle.none
              ),
              gapPadding: 6
            ),
          )
        ),
      ),
    );
  }
}



