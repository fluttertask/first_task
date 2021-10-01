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
              tabs: const [
                Tab(
                  child: Text(
                    'Motorbikes',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )
                ),
                Tab(
                  child: Text(
                    'Vehicles',
                    style: TextStyle(
                      fontSize: 20,
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
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 50),
        child: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text(
                'Add new',
                style: TextStyle(
                  fontSize: 18,
                ),
              )
            ),
            Tab(
              child: Text(
                'Active',
                style: TextStyle(
                  fontSize: 18,
                ),
              )
            ),
            Tab(
              child: Text(
                'Inactive',
                style: TextStyle(
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
            return const Center(
              child: Text(
                'Empty List',
                style: TextStyle(
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
        height: 700,
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
            CustomTextField(textEditingController: _plateNumberCT),
            const SizedBox(height: 10,),
            FloatingActionButton.extended(
              label: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: _submitData
            )
          ],
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