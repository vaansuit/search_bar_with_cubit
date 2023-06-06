import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Fabrica {
  int? id;
  String? nome;
  String? nrCodbarra;
  String? email;
  String? site;
  String? telefone;
  String? whatsapp;

  Fabrica({
    this.id,
    this.nome,
    this.nrCodbarra,
    this.email,
    this.site,
    this.telefone,
    this.whatsapp,
  });
}

class FabricaCubit extends Cubit<List<Fabrica>> {
  final List<Fabrica> fabricas;

  FabricaCubit(this.fabricas) : super(fabricas);

  void filterByNome(String searchTerm) {
    if (searchTerm.isEmpty) {
      emit(fabricas);
    } else {
      final filteredList = fabricas
          .where((fabrica) =>
              fabrica.nome?.toLowerCase().contains(searchTerm.toLowerCase()) ==
              true)
          .toList();
      emit(filteredList);
    }
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => FabricaCubit(createFabricasList()),
        child: const HomePage(),
      ),
    );
  }
}

List<Fabrica> createFabricasList() {
  return [
    Fabrica(
      id: 1,
      nome: 'Joãozinho boca de lodo',
      nrCodbarra: '123456789',
      email: 'maluco@example.com',
      site: 'www.fabrica1.com',
      telefone: '1234567890',
      whatsapp: '1234567890',
    ),
    Fabrica(
      id: 2,
      nome: 'Ivonete Amassa Mendigo',
      nrCodbarra: '987654321',
      email: 'maluca@example.com',
      site: 'www.fabrica2.com',
      telefone: '0987654321',
      whatsapp: '0987654321',
    ),
    Fabrica(
      id: 3,
      nome: 'Cachorro do Coringa',
      nrCodbarra: '987654321',
      email: 'titei@example.com',
      site: 'www.fabrica2.com',
      telefone: '0987654321',
      whatsapp: '0987654321',
    ),
  ];
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  List<Fabrica> createFabricasList() {
    return [
      Fabrica(
        id: 1,
        nome: 'Fabrica 1',
        nrCodbarra: '123456789',
        email: 'fabrica1@example.com',
        site: 'www.fabrica1.com',
        telefone: '1234567890',
        whatsapp: '1234567890',
      ),
      Fabrica(
        id: 2,
        nome: 'Fabrica 2',
        nrCodbarra: '987654321',
        email: 'fabrica2@example.com',
        site: 'www.fabrica2.com',
        telefone: '0987654321',
        whatsapp: '0987654321',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final fabricaCubit = context.watch<FabricaCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                fabricaCubit.filterByNome(value);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                hintText: 'Search by name',
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<FabricaCubit, List<Fabrica>>(
              builder: (context, filteredFabricas) {
                return ListView.builder(
                  itemCount: filteredFabricas.length,
                  itemBuilder: (context, index) {
                    Fabrica fabrica = filteredFabricas[index];
                    return ListTile(
                      title: Text(fabrica.nome ?? ''),
                      subtitle: Text(fabrica.email ?? ''),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
