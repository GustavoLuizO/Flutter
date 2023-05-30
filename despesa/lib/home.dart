import 'package:despesa/db_helper.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget{
  const Home({super.key});
  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  List<Map<String, dynamic>> _allData = [];
  
  bool _isLoading = true;
  
  void _refreshData() async {
    final data = await SQLHelper.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }
  
  @override
  void initState() {
    super.initState();
    _refreshData();
  }
  
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  
  Future<void> _addData() async {
    await SQLHelper.creatDate(_tipoController.text, _valorController.text);
    _refreshData();
  }
  
  Future<void> _updateData(int id) async {
    await SQLHelper.updateData(id, _tipoController.text, _valorController.text);
    _refreshData();
  }
  
  void _deleteData(int id) async {
    await SQLHelper.deleteData(id);
    ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text("Despesa deletada")));
    _refreshData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Despesas Financeiras"),
      ),
      body: _isLoading ? const Center(
        child: CircularProgressIndicator(
          
        ),
      ):ListView.builder(
        itemCount: _allData.length,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.all(15),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                _allData[index]['tipo'],
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            subtitle: Text(_allData[index]['valor']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: (){
                    showBottomSheet(_allData[index]['id']);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.indigo,
                  ),
                ),
                IconButton(
                  onPressed: (){
                    _deleteData(_allData[index]['id']);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              ]
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(null),
        child: const Icon(Icons.add),
      ),
    );
  }
  
  void showBottomSheet(int? id) async{
    if(id != null) {
      final existingData = _allData.firstWhere((element) => element['id'] == id);
      _tipoController.text = existingData['tipo'];
      _valorController.text = existingData['valor'];
    }
    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context, 
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 15, 
          right: 15, 
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _tipoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tipo',
              ),
            ),
            const SizedBox(height:10),
            TextField(
              controller: _valorController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Valor',
              ),
            ),
            const SizedBox(height: 20),
            
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (id == null) {
                    await _addData();
                  } else {
                    await _updateData(id);
                  }
                  
                  _tipoController.text = "";
                  _valorController.text = "";
                  
                  Navigator.of(context).pop();
                  print("Despesa Adicionada");
                },
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    id == null ? "Adicione despesa" : "Altere Despesa",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}