import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'constantes_arbitraries.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  List<dynamic> usuarios = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsuarios();
  }

  // Função para carregar os usuários do backend
  Future<void> _loadUsuarios() async {
    final response = await http.get(Uri.parse('$LINK_BASE/login'));
    if (response.statusCode == 200) {
      setState(() {
        usuarios = jsonDecode(response.body);
        isLoading = false;
      });
    } else {
      print('Erro ao carregar usuários: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuários'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: usuarios.length,
                    itemBuilder: (context, index) {
                      final usuario = usuarios[index];
                      return ListTile(
                        title: Text(usuario['user']),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
