import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/Src/Cubits/Product/product_cubit.dart';
import 'package:flutter_task/Src/Models/Product.dart';
import 'package:flutter_task/Src/UI/Bars/custom_app_bar.dart';
import 'package:flutter_task/Src/UI/Cards/product_card.dart';
// import 'package:flutter_task/Src/UI/Bars/custom_tab_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 150),
        child: CustomAppBar(
          leading: const Icon(Icons.menu_open, color: Colors.white,),
          title: const Text('My Vehicles'),
          actions: const [ Icon(Icons.notification_important, color: Colors.white) ],
          bottomHeight: 50,
          bottom: SizedBox(
            height: 50,
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  child: Center(
                    child: Text(
                      'Motorbikes',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                      ),
                    ),
                  )
                ),
                Tab(
                  child: Center(
                    child: Text(
                      'Vehicles',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _VeheclesTabs(),
          _VeheclesTabs()
        ],
      ),
      
    );
  }
}


class _VeheclesTabs extends StatefulWidget {
  const _VeheclesTabs({ Key? key }) : super(key: key);

  @override
  _VeheclesTabsState createState() => _VeheclesTabsState();
}

class _VeheclesTabsState extends State<_VeheclesTabs> with TickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 50),
        child: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                'Add new',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                ),
              )
            ),
            Tab(
              child: Text(
                'Active',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                ),
              )
            ),
            Tab(
              child: Text(
                'Inactive',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                ),
              )
            ),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: const [
          VehiclesCreate(),
          _VehiclesState(active: true,),
          _VehiclesState(active: false,),
        ] ,),
    );
  }
}

class _VehiclesState extends StatefulWidget {
  const _VehiclesState({Key? key, required this.active }) : super(key: key);
  final bool active;

  @override
  _VehiclesStateState createState() => _VehiclesStateState();
}

class _VehiclesStateState extends State<_VehiclesState> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductCubit>(context).getProduct();
    return SizedBox(
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state){
          if (state.product == null || state.product!.isEmpty){
            return Center(
              child: Text(
                'Empty List',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                ),),
            );
          }else{
            return ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index){
              return ProductCard(
                product: state.product![index],
              );
            }
          );
          }
          
        }
      ),
    );
  }
}


class VehiclesCreate extends StatefulWidget {

  const VehiclesCreate({ Key? key }) : super(key: key);

  @override
  _VehiclesCreateState createState() => _VehiclesCreateState();
}

class _VehiclesCreateState extends State<VehiclesCreate> {


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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body : SingleChildScrollView(
        child: Container(
          width: size.width - 20,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(5),
          height: 700,
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
                    child: const CarBox()
                  ),
                  SizedBox(
                    width: (size.width/2 )- 20,
                    child: Column(
                      children: [
                        CustomTextField(textEditingController: _doorsCT, hintText: 'Doors'),
                        CustomTextField(textEditingController: _colorCT, hintText: 'Color'),
                        CustomTextField(textEditingController: _typeCT, hintText: 'Type')
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: (size.width/2 )- 20,
                    child: CustomTextField(textEditingController: _passengerCapacityCT, hintText: 'Passenger capacity')
                  ),
                  SizedBox(
                    width: (size.width/2 )- 20,
                    child: CustomTextField(textEditingController: _ownerCT, hintText: 'Private or Taxi')
                  )
                ],
              ),
              CustomTextField(textEditingController: _makeCT, hintText: 'Make'),
              CustomTextField(textEditingController: _modelCT, hintText: 'Model'),
              CustomTextField(textEditingController: _yearCT, hintText: 'Manufacturing year'),
              CustomTextField(textEditingController: _plateNumberCT, hintText: 'Plate number'),
              const SizedBox(height: 10,),
              FloatingActionButton.extended(
                foregroundColor: Colors.white,
                backgroundColor: Colors.white,
                focusColor: Colors.white,
                label: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: _submitData
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitData() async{
    BlocProvider.of<ProductCubit>(context).addProduct(
      Product(
        doors: _doorsCT.text,
        color: _colorCT.text,
        type: _typeCT.text,
        passengerCapacity: int.parse(_passengerCapacityCT.text),
        owner: _ownerCT.text,
        make: _makeCT.text,
        model: _modelCT.text,
        manufacturingYear: _yearCT.text,
        plateNumber: _plateNumberCT.text,
        imageUrl: '',
        active: true,
      )
    );
  }
}