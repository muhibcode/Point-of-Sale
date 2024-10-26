// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return PaginatedDataTable(columns: [], source: pagedata);
//   }
// }

class MyData {
  var pagedata =
      //  [
      //   {'name': 'muhib', 'age': 35},
      //   {'name': 'yasir', 'age': 45},
      //   {'name': 'tahir', 'age': 55},
      //   {'name': 'khan', 'age': 25},
      //   {'name': 'bilal', 'age': 15},
      // ];
      List.generate(100, (index) => {'id': index, 'Product': 'Item $index'});
}
