import 'package:flutter/material.dart';
import 'package:page/common_widgets/build_custom_text.dart';
import 'package:page/features/imagedata.dart';
import 'package:page/pages/screen_page.dart';
import 'package:page/pages/teachers_info_page.dart';

class TeachersPage extends StatelessWidget {
  TeachersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ModalRoute? route = ModalRoute.of(context);
    final String argumentText = route?.settings.arguments as String? ?? '';

    List<ImageData> curList = _getImageDataList(argumentText);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Teachers'),
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: _TeachersGridView(curList: curList),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => null,
          child: const Icon(Icons.add),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/teachers_info_pages': (context) => TeachersInfoPage(),
        '/screen_page': (context) => ScreenPage(),
      },
    );
  }

  List<ImageData> _getImageDataList(String argumentText) {
    if (argumentText == 'It') {
      return imageDataList;
    } else if (argumentText == 'Audit') {
      return imageDataList2;
    } else if (argumentText == 'All') {
      return imageDataList3;
    }
    return [];
  }

  List<ImageData> imageDataList = [
    ImageData(
      imagePath: "assets/photo_it_1.png",
      name: "Қазанғапов Бақытжан",
      description: "It пәнінің мұғалімі",
    ),
    ImageData(
      imagePath: "assets/it_1.png",
      name: "Ниязов Мұхтар",
      description: "АӘД пәнінің мұғалімі",
    ),
    ImageData(
      imagePath: "assets/it_2.png",
      name: "Қазанғапов Бақытжан",
      description: "It пәнінің мұғалімі",
    ),
    ImageData(
      imagePath: "assets/it_3.png",
      name: "Ниязов Мұхтар",
      description: "АӘД пәнінің мұғалімі",
    ),
  ];
  List<ImageData> imageDataList2 = [
    ImageData(
      imagePath: "assets/photo_audit_1.png",
      name: "Бахыт Жанат",
      description: "Audit пәнінің мұғалімі",
    ),
    ImageData(
      imagePath: "assets/photo_audit_2.png",
      name: "Абеева Маржан",
      description: "Audit пәнінің мұғалімі",
    ),
    ImageData(
      imagePath: "assets/audit_2.png",
      name: "Бахыт Жанат",
      description: "Audit пәнінің мұғалімі",
    ),
    ImageData(
      imagePath: "assets/audit_3.png",
      name: "Абеева Маржан",
      description: "Audit пәнінің мұғалімі",
    ),
  ];
  List<ImageData> imageDataList3 = [
    ImageData(
      imagePath: "assets/photo_it_1.png",
      name: "Қазанғапов Бақытжан",
      description: "It пәнінің мұғалімі",
    ),
    ImageData(
      imagePath: "assets/it_1.png",
      name: "Абеева Маржан",
      description: "Экономика пәнінің мұғалімі",
    ),
    ImageData(
      imagePath: "assets/it_2.png",
      name: "Алиева Ғазиза",
      description: "It пәнінің мұғалімі",
    ),
    ImageData(
      imagePath: "assets/it_3.png",
      name: "Тулгенова Ғайша",
      description: "Тарих пәнінің мұғалімі",
    ),
    ImageData(
      imagePath: "assets/photo_audit_1.png",
      name: "Бахыт Жанат",
      description: "Түрік тілі пәнінің мұғалімі",
    ),
    ImageData(
      imagePath: "assets/photo_audit_2.png",
      name: "Абеева Маржан",
      description: "Audit пәнінің мұғалімі",
    ),
    ImageData(
      imagePath: "assets/audit_2.png",
      name: "Тулегенова Ғайша",
      description: "Тарих пәнінің мұғалімі",
    ),
    ImageData(
      imagePath: "assets/audit_3.png",
      name: "Тоқтар Нұргүл",
      description: "Экономика пәнінің мұғалімі",
    ),
  ];
}

class _TeachersGridView extends StatelessWidget {
  final List<ImageData> curList;

  const _TeachersGridView({Key? key, required this.curList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // primary: true,
      padding: const EdgeInsets.all(4),
      itemCount: curList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.38,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
      ),
      itemBuilder: (context, index) {
        return _FullImageData(imageData: curList[index]);
      },
    );
  }
}

class _FullImageData extends StatelessWidget {
  final ImageData imageData;

  const _FullImageData({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imageData.imagePath),
        BuildCustomText(text: imageData.name),
        TextButton(
          child: BuildCustomText(text: imageData.description),
          onPressed: () {
            Route route = MaterialPageRoute(
                builder: (context) => const TeachersInfoPage());
            Navigator.push(context, route);
          },
        ),
        _AddButton(imageData: imageData),
      ],
    );
  }
}

class _AddButton extends StatelessWidget {
  final ImageData imageData;

  const _AddButton({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        _InputDialog.show(context, imageData);
        Navigator.of(context).pop();
      },
      child: const Text('Add Info'),
    );
  }
}

class _InputDialog {
  static void show(BuildContext context, ImageData imageData) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Add Information',
            style: TextStyle(
              color: Colors.deepPurple,
            ),
          ),
          content: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (context) => const TeachersInfoPage());
                Navigator.push(context, route);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
