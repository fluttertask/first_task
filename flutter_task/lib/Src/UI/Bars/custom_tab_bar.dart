import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({ Key? key, required this.onItemTap, required this.currentIndex, required this.items }) : super(key: key);

  final ValueChanged<int> onItemTap;
  final int currentIndex;
  final List<NavbarItemData> items;
  NavbarItemData? get selectedItem => currentIndex >= 0 && currentIndex < items.length ? items[currentIndex] : null;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: items.map((entry){ 
          return _NavbarButton(
            entry,
            entry == selectedItem,
            onTap: (){
              final index = items.indexOf(entry);
              onItemTap(index);
            });
        }).toList(),
      ),
    );
  }
}



class _NavbarButton extends StatefulWidget {

  const _NavbarButton(this.data, this.isSelected, {Key? key, required this.onTap }) : super(key: key);
  final NavbarItemData data;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  _NavbarButtonState createState() => _NavbarButtonState();
}

class _NavbarButtonState extends State<_NavbarButton> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: ()=>widget.onTap(),
      child: Expanded(
        child: Container(
          margin: const EdgeInsets.only(left: 4, right: 4),
          padding: const EdgeInsets.only(top: 16, bottom: 16, left: 4, right: 4),
          child: Text(
            widget.data.title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}


class NavbarItemData{
  NavbarItemData(this.title, this.icon, this.selectedColor, this.width);

  final String title;
  final IconData icon;
  final Color selectedColor;
  final double width;
}