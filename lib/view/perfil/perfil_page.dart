import 'package:app_eyewear/controller/users/user_controller.dart';
import 'package:app_eyewear/function/sums_dates/function.dart';
import 'package:app_eyewear/model/endereco_model.dart';
import 'package:app_eyewear/view/home/home_page.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

UserController? _userController;

class PerfilPage extends StatefulWidget {
  final EnderecoModel? _enderecoModel;
  final String? snackbarMessage;

  PerfilPage({this.snackbarMessage, EnderecoModel? enderecoModel, super.key})
    : _enderecoModel = enderecoModel; // atr

  static String tag = 'perfil-page';

  @override
  State<PerfilPage> createState() => _PerfilPageState();
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
  EnderecoModel? _enderecoModel;
  // UserController? userController;

  @override
  void initState() {
    super.initState();
    if (widget.snackbarMessage != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        snackBarWarning(widget.snackbarMessage!);
      });
    }
    _enderecoModel = widget._enderecoModel;
  }

  @override
  void dispose() {
    _cep.dispose();
    _rua.dispose();
    _numero.dispose();
    _complemento.dispose();
    _bairro.dispose();
    _cidade.dispose();
    _estado.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext topContext) {
    _userController = Provider.of<UserController>(topContext);
    var container = FutureBuilder(
      future: loadEndereco(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Center(child: CircularProgressIndicator());
        // }

        if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar dados'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Nenhum endereço encontrado'));
        }

        // Aqui sim é seguro acessar snapshot.data!
        if (_nome.text.isEmpty) {
          _nome.text = _userController!.user!.displayName!;
        }

        if (_enderecoModel == null) {
          _enderecoModel = EnderecoModel.fromDocument(
            snapshot.data!.docs.first,
          );
          _cep.text = _enderecoModel!.cep;
          _rua.text = _enderecoModel!.rua;
          _numero.text = _enderecoModel!.numero;
          _complemento.text = _enderecoModel!.complemento;
          _bairro.text = _enderecoModel!.bairro;
          _cidade.text = _enderecoModel!.cidade;
          _estado.text = _enderecoModel!.estado;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Editar perfil',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Layout.light()),
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
                              color: Layout.secondaryDark(),
                            ),
                          ),
                        ),
                        controller: _nome,
                        validator: (value) {
                          return (value!.length) < 3
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
                              color: Layout.secondaryDark(),
                            ),
                          ),
                        ),
                        initialValue: _userController!.user!.email,
                        enabled: false,

                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 40),

                      Text(
                        'Endereco de entrega',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(fontSize: 16),
                      ),

                      SizedBox(height: 10),

                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'CEP',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Layout.secondaryDark(),
                            ),
                          ),
                        ),
                        controller: _cep,
                        validator: (value) {
                          return (value!.isEmpty) ? 'Campo obrigatório' : null;
                        },
                        onChanged: (value) async {
                          if (value.length == 9) {
                            try {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );

                              var resp = await Dio().get<Map<String, dynamic>>(
                                'https://viacep.com.br/ws/${value}/json/',
                              );

                              if (!resp.data!.containsKey('erro')) {
                                _rua.text = resp.data!['logradouro'];
                                _bairro.text = resp.data!['bairro'];
                                _cidade.text = resp.data!['localidade'];
                                _estado.text = resp.data!['uf'];
                              }
                            } catch (e) {}
                            Navigator.of(context).pop();
                            setState(() {});

                            // força o rebuild para o botão reaparecer
                          }
                        },
                      ),
                      SizedBox(height: 20),

                      // ---------- LINHA RUA + NÚMERO ----------
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Rua',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Layout.secondaryDark(),
                                  ),
                                ),
                              ),
                              controller: _rua,
                              validator: (value) {
                                return (value!.isEmpty)
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
                                    color: Layout.secondaryDark(),
                                  ),
                                ),
                              ),
                              controller: _numero,
                              validator: (value) {
                                return (value!.isEmpty)
                                    ? 'Campo obrigatório'
                                    : null;
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Complemento',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Layout.secondaryDark(),
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
                              color: Layout.secondaryDark(),
                            ),
                          ),
                        ),
                        controller: _bairro,
                        validator: (value) {
                          return (value!.isEmpty) ? 'Campo obrigatório' : null;
                        },
                      ),
                      SizedBox(height: 20),

                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Cidade',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Layout.secondaryDark(),
                            ),
                          ),
                        ),
                        controller: _cidade,
                        validator: (value) {
                          return (value!.isEmpty) ? 'Campo obrigatório' : null;
                        },
                      ),
                      SizedBox(height: 20),

                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Estado',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Layout.secondaryDark(),
                            ),
                          ),
                        ),
                        controller: _estado,
                        validator: (value) {
                          return (value!.isEmpty) ? 'Campo obrigatório' : null;
                        },
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            // ---------- BOTÃO SALVAR ----------
            (MediaQuery.of(topContext).viewInsets.bottom == 0)
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Layout.primary(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          'Salvar',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: Layout.light()),
                        ),
                        onPressed: () async {
                          if (!_form.currentState!.validate()) {
                            return;
                          }
                          final user = _userController!.user!;

                          if (_nome.text != user.displayName) {
                            await user.updateDisplayName(_nome.text);
                            await _userController!.setUser(user);
                            // await user.reload();
                          }

                          _enderecoModel!.cep = _cep.text;
                          _enderecoModel!.rua = _rua.text;
                          _enderecoModel!.numero = _numero.text;
                          _enderecoModel!.complemento = _complemento.text;
                          _enderecoModel!.bairro = _bairro.text;
                          _enderecoModel!.cidade = _cidade.text;
                          _enderecoModel!.estado = _estado.text;
                          await _enderecoModel!.update();

                          snackBarSucess('Endereço atualizado com sucesso');

                          setState(() {});
                          await Future.delayed(const Duration(seconds: 2));
                          _userController!.setUser(
                            FirebaseAuth.instance.currentUser!,
                          );
                          Navigator.of(context).pushNamed(HomePage.tag);
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

  Future<QuerySnapshot<Object?>> loadEndereco() async {
    var endereco = await FirebaseFirestore.instance
        .collection('endereco')
        .where('uid', isEqualTo: _userController!.user!.uid)
        .get();
    if (endereco.docs.isEmpty) {
      await EnderecoModel(uid: _userController!.user!.uid).insert();

      endereco = await FirebaseFirestore.instance
          .collection('endereco')
          .where('uid', isEqualTo: _userController!.user!.uid)
          .get();
    }
    return endereco;
  }
}
