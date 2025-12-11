import 'package:app_eyewear/view/layout.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  static String tag = 'perfil-page';

  @override
  Widget build(BuildContext context) {
    var container = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Editar perfil',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Layout.light()),
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
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nome',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Layout.secondaryDark()),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    helperText: '* Este campo não pode ser modificado',
                    helperStyle: TextStyle(color: Colors.blueGrey[200]),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Layout.secondaryDark()),
                    ),
                  ),
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 40),

                Text(
                  'Endereco de entrega',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 16),
                ),

                SizedBox(height: 10),


                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'CEP',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Layout.secondaryDark()),
                    ),
                  ),
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
                            borderSide:
                                BorderSide(color: Layout.secondaryDark()),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Número',
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Layout.secondaryDark()),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Complemento',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Layout.secondaryDark()),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Bairro',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Layout.secondaryDark()),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Cidade',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Layout.secondaryDark()),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Estado',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Layout.secondaryDark()),
                    ),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),

        // ---------- BOTÃO SALVAR ----------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
              onPressed: () {},
              child: Text(
                'Salvar',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Layout.light()),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );

    return Layout.render(context, container);
  }
}