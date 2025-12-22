import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_loja_virtual/controller/user_controller.dart';
import 'package:fl_loja_virtual/functions.dart';
import 'package:fl_loja_virtual/model/endereco_model.dart';
import 'package:fl_loja_virtual/view/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  static String tag = '/perfil-page';

  final String snackbarMessage;

  PerfilPage({this.snackbarMessage});

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final _form = GlobalKey<FormState>();

  final _nome = TextEditingController();
  final _cep = MaskedTextController(mask: '00000-000');
  final _rua = TextEditingController();
  final _numero = TextEditingController();
  final _complemento = TextEditingController();
  final _bairro = TextEditingController();
  final _cidade = TextEditingController();
  final _estado = TextEditingController();

  EnderecoModel _enderecoModel;

  UserController _userController;

  @override
  void initState() {
    super.initState();

    // Se ha mensagem vindo de outra pagina
    // mostramos ela apos o widget terminar de
    // ser contruido
    if (widget.snackbarMessage != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        snackBarWarning(widget.snackbarMessage);
      });
    }
  }

  @override
  Widget build(BuildContext topContext) {
    //

    _userController = Provider.of<UserController>(topContext);

    var container = FutureBuilder(
      future: _loadEndereco(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot,
      ) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }

        if (_nome.text.isEmpty) {
          _nome.text = _userController.user.displayName;
        }

        /// O metodo [_loadEndereco] vai verificar
        /// se o endereco ja foi inserido no banco
        /// caso nao tenha sido, vamos inseri-lo
        if (_enderecoModel == null) {
          _enderecoModel =
              EnderecoModel.fromDocument(snapshot.data.documents.first);

          _cep.text = _enderecoModel.cep;
          _rua.text = _enderecoModel.rua;
          _numero.text = _enderecoModel.numero;
          _complemento.text = _enderecoModel.complemento;
          _bairro.text = _enderecoModel.bairro;
          _cidade.text = _enderecoModel.cidade;
          _estado.text = _enderecoModel.estado;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Editar perfil',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Layout.light(),
                    ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Layout.light(),
                ),
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _form,
                  child: ListView(
                    shrinkWrap: false,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Nome',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Layout.primary(),
                            ),
                          ),
                        ),
                        controller: _nome,
                        validator: (value) {
                          return (value.length < 3)
                              ? 'Campo obrigatório'
                              : null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          helperText: '* Este campo não pode ser modificado',
                          helperStyle: TextStyle(color: Colors.blueGrey[200]),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Layout.primary(),
                            ),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                        initialValue: _userController.user.email,
                        enabled: false,
                      ),
                      SizedBox(height: 40),
                      Text(
                        'Endereço de entrega',
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: 16,
                            ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'CEP',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Layout.primary(),
                            ),
                          ),
                        ),
                        controller: _cep,
                        validator: (value) {
                          return (value.isEmpty) ? 'Campo obrigatório' : null;
                        },
                        onChanged: (value) async {
                          if (value.length == 9) {
                            try {
                              // Obriga o usuario a esperar de carregar
                              // as informacoes do cep fornecido
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );

                              var resp = await Dio().get<Map<String, dynamic>>(
                                'https://viacep.com.br/ws/${value}/json/',
                              );

                              if (resp.data.containsKey('erro') == false) {
                                _rua.text = resp.data['logradouro'];
                                _bairro.text = resp.data['bairro'];
                                _cidade.text = resp.data['localidade'];
                                _estado.text = resp.data['uf'];
                              }
                            } catch (e) {}

                            // Independente do resultado, fecha o dialog
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Rua',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Layout.primary(),
                                  ),
                                ),
                              ),
                              controller: _rua,
                              validator: (value) {
                                return (value.isEmpty)
                                    ? 'Campo obrigatório'
                                    : null;
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Número',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Layout.primary(),
                                  ),
                                ),
                              ),
                              controller: _numero,
                              validator: (value) {
                                return (value.isEmpty)
                                    ? 'Campo obrigatório'
                                    : null;
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Complemento',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Layout.primary(),
                            ),
                          ),
                        ),
                        controller: _complemento,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Bairro',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Layout.primary(),
                            ),
                          ),
                        ),
                        controller: _bairro,
                        validator: (value) {
                          return (value.isEmpty) ? 'Campo obrigatório' : null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Cidade',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Layout.primary(),
                            ),
                          ),
                        ),
                        controller: _cidade,
                        validator: (value) {
                          return (value.isEmpty) ? 'Campo obrigatório' : null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Estado',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Layout.primary(),
                            ),
                          ),
                        ),
                        controller: _estado,
                        validator: (value) {
                          return (value.isEmpty) ? 'Campo obrigatório' : null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            (MediaQuery.of(topContext).viewInsets.bottom == 0)
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: FlatButton(
                        color: Layout.primary(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Salvar',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: Layout.light(),
                                fontSize: 18,
                              ),
                        ),
                        onPressed: () async {
                          //
                          // Valida o formulario
                          if (!_form.currentState.validate()) {
                            return;
                          }

                          if (_nome.text != _userController.user.displayName) {
                            //
                            // Atualiza nome do usuario caso ele tenha mudado
                            var userUpdateInfo = UserUpdateInfo();
                            userUpdateInfo.displayName = _nome.text;

                            await _userController.user.updateProfile(
                              userUpdateInfo,
                            );

                            // Atualiza o objeto do usuario no userController
                            await _userController.setUser(
                              await FirebaseAuth.instance.currentUser(),
                            );
                          }

                          // Atualiza no banco de dados
                          _enderecoModel.cep = _cep.text;
                          _enderecoModel.rua = _rua.text;
                          _enderecoModel.numero = _numero.text;
                          _enderecoModel.complemento = _complemento.text;
                          _enderecoModel.bairro = _bairro.text;
                          _enderecoModel.cidade = _cidade.text;
                          _enderecoModel.estado = _estado.text;

                          await _enderecoModel.update();

                          snackBarSuccess('Endereço atualizado');

                          // Apenas para atualizar o nome
                          // do usuario la em cima
                          setState(() {});
                        },
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        );
      },
    );

    return Layout.render(topContext, container);
  }

  /// Carrega os dados de endereço, pode acontecer do endereco
  /// ainda nao existir no banco de dados, se isso acontecer
  /// vamos criar um registro vazio
  Future<QuerySnapshot> _loadEndereco() async {
    var endereco = await Firestore.instance
        .collection('endereco')
        .where('uid', isEqualTo: _userController.user.uid)
        .getDocuments();

    if (endereco.documents.isEmpty) {
      // Nao existe ainda registro de endereco deste usuario
      // vamos criar um registro vazio
      await EnderecoModel(uid: _userController.user.uid).insert();

      // Busca novamente
      endereco = await Firestore.instance
          .collection('endereco')
          .where('uid', isEqualTo: _userController.user.uid)
          .getDocuments();
    }

    return endereco;
  }
}
