import 'package:barber_shop_flutter/main.dart';
import 'package:barber_shop_flutter/models/Usuario.dart';
import 'package:barber_shop_flutter/views/utils/MenuDropDownProfissionais.dart';
import 'package:barber_shop_flutter/views/utils/configuracaoMenuDropDown.dart';

import 'package:barber_shop_flutter/views/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Agendar extends StatefulWidget {
  @override
  _AgendarState createState() => _AgendarState();
}

class _AgendarState extends State<Agendar> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  final _formKey = GlobalKey<FormState>();
  String? _itemSelecionadoEstado;
  String? _itemSelecionadoProfissional;
  List<DropdownMenuItem<String>> _listaItensDropCategorias = [];
  List<DropdownMenuItem<String>> _listaItensDropProfissionais = [];

  _carregarItensDropdown() {
    //Categorias
    _listaItensDropCategorias    = Configuracoes.getCategorias();
    _listaItensDropProfissionais = MenuDropDownProfissionais.getCategoriasProfissionais();
  }

  Future<List<Usuario>> _recuperarContatos() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db.collection("usuarios").get();

    List<Usuario> _listaUsuarios = [];
    for (DocumentSnapshot item in querySnapshot.docs) {
      var dados = item.data()!;
      // if (dados["email"] == _emailUsuarioLogado) continue;

      Usuario usuario = Usuario();
      usuario.id = item.id;
      usuario.email = dados["email"];
      usuario.name = dados["name"];
      usuario.photos = dados["photos"];
      usuario.status = dados["status"];
      usuario.descricao = dados["descricao"];
      usuario.phoneNumber = dados["phoneNumber"];

      _listaUsuarios.add(usuario);

      //  print("${listaUsuarios.toString()}");

    }

    return _listaUsuarios;
  }

  @override
  void initState() {
    _carregarItensDropdown();
    _recuperarContatos();
    super.initState();
    //  _teste();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  /* List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }*/

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);

      _abrirDialog();

      print("pressionado: _onDaySelected: $_selectedDay");
    }
  }

  /*agenda
      id
        id_cliente
          id_profissional
              Data: 11/03/2021
              horario: 10:30
  *
  *
  * */

  _formatarData(String data) {
    initializeDateFormatting('pt_BR');
    //Year -> y  month ->  M  Day    -> d
    // Hour -> H  minute -> m  second -> s

    var formatador = DateFormat("dd/MM/y");
    //var formatador = DateFormat.EEEE("pt_BR");
    //var formatador = DateFormat.yMd("pt_BR");

    DateTime dataConvertida = DateTime.parse(data);
    String dataFormatada = formatador.format(dataConvertida);

    return dataFormatada;
  }

  /* _teste() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentSnapshot snapshot = await db
        .collection("agendamento").doc("JMAcY13lYFqrzmjZ8VO7").collection("idCliente").doc("001").collection("idProfissional").doc("001")
      */ /*  .where("valorServico", isLessThan: "R\$ 80,00")
        .orderBy("valorServico", descending: false)*/ /*
        .get();

        var dados = snapshot.data();
 */ /*
    for (DocumentSnapshot item in snapshot) {
      var dados = snapshot.data!();*/ /*

      print("Agendamento: ${dados!["data"]} e hora: ${dados!["horario"]}");
      //print("Filtro nome: ${dados!["serviceName"]} valor : ${dados!["valorServico"]}");
   // }
  }*/

  _abrirDialog() {
    showDialog(

        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                                "Agendar: ${_formatarData(_selectedDay.toString())}",
                                style: TextStyle(color: Colors.black)),
                          ),
                          Expanded(
                            flex: 1,
                            child: DropdownButtonFormField(
                              value: _itemSelecionadoEstado,
                              hint: Text("Horário"),
                              onSaved: (estado) {
                                //_anuncio.estado = estado;
                              },
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                              items: _listaItensDropCategorias,
                              /*validator: (valor){
                              return Validador().add(Validar.OBRIGATORIO, msg: "Campo Obrigatório").valido(valor);
                            },*/

                              onChanged: (valor) {
                                setState(() {
                                  _itemSelecionadoEstado = valor.toString();
                                  //   print("valor $valor");
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField(
                  value: _itemSelecionadoProfissional,
                  hint: Text("Escolha um profissional"),
                  onSaved: (estado) {
                    //_anuncio.estado = estado;
                  },
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  items: _listaItensDropProfissionais,
                  /*validator: (valor){
                              return Validador().add(Validar.OBRIGATORIO, msg: "Campo Obrigatório").valido(valor);
                            },*/

                  onChanged: (valor) {
                    setState(() {
                      _itemSelecionadoProfissional = valor.toString();
                      //   print("valor $valor");
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xff867638),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.only(top: 4, bottom: 4),
                    textStyle: TextStyle(
                      color: Colors.white,
                    )),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.watch_later,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 10),
                      child: Text('AGENDAR',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: temaPadrao.primaryColor,
      appBar: AppBar(
        backgroundColor: temaPadrao.accentColor,
        title: Text('Agendar Horário'),
      ),
      body: Column(
        children: [
          
          Card(
            color: temaPadrao.accentColor,
            child: TableCalendar<Event>(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              calendarFormat: _calendarFormat,
              rangeSelectionMode: _rangeSelectionMode,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
              selectedTextStyle : TextStyle(color: Colors.white),
              todayTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

              todayDecoration: BoxDecoration(color: Color(0xff867638), shape: BoxShape.circle),

              markerDecoration: const BoxDecoration( //bolinhas em baixo
                  color: const Color(0xff867638),
                  shape: BoxShape.circle,
                ),

               defaultTextStyle: const TextStyle(color: Colors.white),
               weekendTextStyle: const TextStyle(color: Colors.white),
            //    outsideTextStyle: const TextStyle(color: const Color(0xff867638)),
             //   disabledTextStyle:const TextStyle(color: const Color(0xff867638)),




             // markersColor: Colors.brown[700],

                // Use `CalendarStyle` to customize the UI
                outsideDaysVisible: false,
              ),
              onDaySelected: _onDaySelected,
              //   onRangeSelected: _onRangeSelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;

                print("pressionado: focusedDay $_focusedDay");
              },
            ),
          ),
          
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                          title: Text('texxto ${value[index]}'),
                          onTap: () {
                            //  _abrirDialog('${value[index].toString()}');
                            //print('pressionado: ontap ${value[index]}');
                          }),
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
