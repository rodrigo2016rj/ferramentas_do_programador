import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:intl/date_symbol_data_local.dart";

class CalcularPeriodos extends StatefulWidget{
  CalcularPeriodos({
    super.key,
    required this.largura_do_menu_lateral,
    required this.largura_minima_para_mostrar_menus_laterais
  });

  final largura_do_menu_lateral;
  final largura_minima_para_mostrar_menus_laterais;

  var dia_da_data_inicial = null;
  var mes_da_data_inicial = null;
  var ano_da_data_inicial = null;
  var data_inicial = null;
  var dia_da_semana_da_data_inicial = null;
  var quantidade_de_dias = null;
  var dia_da_data_final = null;
  var mes_da_data_final = null;
  var ano_da_data_final = null;
  var data_final = null;
  var dia_da_semana_da_data_final = null;

  @override
  State<CalcularPeriodos> createState() => EstadoDoCalcularPeriodos();
}

class EstadoDoCalcularPeriodos extends State<CalcularPeriodos>{
  var controlador_do_campo_de_texto_dia_da_data_inicial = TextEditingController();
  var controlador_do_campo_de_texto_mes_da_data_inicial = TextEditingController();
  var controlador_do_campo_de_texto_ano_da_data_inicial = TextEditingController();
  var controlador_do_campo_de_texto_quantidade_de_dias = TextEditingController();
  var controlador_do_campo_de_texto_dia_da_data_final = TextEditingController();
  var controlador_do_campo_de_texto_mes_da_data_final = TextEditingController();
  var controlador_do_campo_de_texto_ano_da_data_final = TextEditingController();

  calcular_periodo(campo, valor){
    var dia_da_data_inicial = widget.dia_da_data_inicial;
    var mes_da_data_inicial = widget.mes_da_data_inicial;
    var ano_da_data_inicial = widget.ano_da_data_inicial;
    var data_inicial = widget.data_inicial;
    var dia_da_semana_da_data_inicial = widget.dia_da_semana_da_data_inicial;
    var quantidade_de_dias = widget.quantidade_de_dias;
    var dia_da_data_final = widget.dia_da_data_final;
    var mes_da_data_final = widget.mes_da_data_final;
    var ano_da_data_final = widget.ano_da_data_final;
    var data_final = widget.data_final;
    var dia_da_semana_da_data_final = widget.dia_da_semana_da_data_final;
    var modificou = null;

    switch(campo){
      case "dia_da_data_inicial":
        dia_da_data_inicial = int.tryParse(valor);
        if(dia_da_data_inicial != null){
          if(mes_da_data_inicial == null || ano_da_data_inicial == null){
            if(dia_da_data_inicial < 1 || dia_da_data_inicial > 31){
              return false;
            }
          }else{
            dynamic data_para_validar = ano_da_data_inicial.toString().padLeft(4, "0");
            data_para_validar += "-" + mes_da_data_inicial.toString().padLeft(2, "0");
            data_para_validar += "-" + dia_da_data_inicial.toString().padLeft(2, "0");
            data_para_validar = DateTime.tryParse(data_para_validar);
            if(data_para_validar == null || data_para_validar.month != mes_da_data_inicial || data_para_validar.year != ano_da_data_inicial){
              return false;
            }
          }
        }
        modificou = "data_inicial";
      break;
      case "mes_da_data_inicial":
        mes_da_data_inicial = int.tryParse(valor);
        if(mes_da_data_inicial != null && (mes_da_data_inicial < 1 || mes_da_data_inicial > 12)){
          return false;
        }
        modificou = "data_inicial";
      break;
      case "ano_da_data_inicial":
        ano_da_data_inicial = int.tryParse(valor);
        if(ano_da_data_inicial != null && ano_da_data_inicial < 1){
          return false;
        }
        modificou = "data_inicial";
      break;
      case "quantidade_de_dias":
        quantidade_de_dias = int.tryParse(valor);
        if(quantidade_de_dias != null && quantidade_de_dias < 1){
          return false;
        }
        modificou = "quantidade_de_dias";
      break;
      case "dia_da_data_final":
        dia_da_data_final = int.tryParse(valor);
        if(dia_da_data_final != null){
          if(mes_da_data_final == null || ano_da_data_final == null){
            if(dia_da_data_final < 1 || dia_da_data_final > 31){
              return false;
            }
          }else{
            dynamic data_para_validar = ano_da_data_final.toString().padLeft(4, "0");
            data_para_validar += "-" + mes_da_data_final.toString().padLeft(2, "0");
            data_para_validar += "-" + dia_da_data_final.toString().padLeft(2, "0");
            data_para_validar = DateTime.tryParse(data_para_validar);
            if(data_para_validar == null || data_para_validar.month != mes_da_data_final || data_para_validar.year != ano_da_data_final){
              return false;
            }
          }
        }
        modificou = "data_final";
      break;
      case "mes_da_data_final":
        mes_da_data_final = int.tryParse(valor);
        if(mes_da_data_final != null && (mes_da_data_final < 1 || mes_da_data_final > 12)){
          return false;
        }
        modificou = "data_final";
      break;
      case "ano_da_data_final":
        ano_da_data_final = int.tryParse(valor);
        if(ano_da_data_final != null && ano_da_data_final < 1){
          return false;
        }
        modificou = "data_final";
      break;
      default:
        return false;
      break;
    }

    initializeDateFormatting("pt_BR", null);

    switch(modificou){
      case "data_inicial":
        try{
          data_inicial = DateTime.utc(ano_da_data_inicial, mes_da_data_inicial, dia_da_data_inicial);
          dia_da_semana_da_data_inicial = DateFormat("EEEE", "pt_BR").format(data_inicial);
          quantidade_de_dias = null;
          dia_da_data_final = null;
          mes_da_data_final = null;
          ano_da_data_final = null;
          dia_da_semana_da_data_final = null;
        }catch(excecao){
          data_inicial = null;
        }
      break;
      case "quantidade_de_dias":
        if(data_inicial != null && quantidade_de_dias != null){
          data_final = data_inicial.add(Duration(days: quantidade_de_dias - 1));
          dia_da_semana_da_data_final = DateFormat("EEEE", "pt_BR").format(data_final);
          dia_da_data_final = data_final.day;
          mes_da_data_final = data_final.month;
          ano_da_data_final = data_final.year;
        }
      break;
      case "data_final":
        try{
          data_final = DateTime.utc(ano_da_data_final, mes_da_data_final, dia_da_data_final);
          dia_da_semana_da_data_final = DateFormat("EEEE", "pt_BR").format(data_final);
          if(data_inicial != null){
            quantidade_de_dias = null;
            if(data_final.isAfter(data_inicial) || data_final.isAtSameMomentAs(data_inicial)){
              quantidade_de_dias = data_final.difference(data_inicial).inDays + 1;
            }
          }
        }catch(excecao){
          data_final = null;
        }
      break;
    }

    setState((){
      widget.dia_da_data_inicial = dia_da_data_inicial;
      widget.mes_da_data_inicial = mes_da_data_inicial;
      widget.ano_da_data_inicial = ano_da_data_inicial;
      widget.data_inicial = data_inicial;
      widget.dia_da_semana_da_data_inicial = dia_da_semana_da_data_inicial;
      widget.quantidade_de_dias = quantidade_de_dias;
      widget.dia_da_data_final = dia_da_data_final;
      widget.mes_da_data_final = mes_da_data_final;
      widget.ano_da_data_final = ano_da_data_final;
      widget.data_final = data_final;
      widget.dia_da_semana_da_data_final = dia_da_semana_da_data_final;
    });

    return true;
  }

  @override
  Widget build(BuildContext context){
    var controlador_da_barra_de_rolagem_horizontal = ScrollController();
    var controlador_da_barra_de_rolagem_vertical = ScrollController();

    controlador_do_campo_de_texto_dia_da_data_inicial.text = (widget.dia_da_data_inicial ?? "").toString();
    controlador_do_campo_de_texto_mes_da_data_inicial.text = (widget.mes_da_data_inicial ?? "").toString();
    controlador_do_campo_de_texto_ano_da_data_inicial.text = (widget.ano_da_data_inicial ?? "").toString();
    controlador_do_campo_de_texto_quantidade_de_dias.text = (widget.quantidade_de_dias ?? "").toString();
    controlador_do_campo_de_texto_dia_da_data_final.text = (widget.dia_da_data_final ?? "").toString();
    controlador_do_campo_de_texto_mes_da_data_final.text = (widget.mes_da_data_final ?? "").toString();
    controlador_do_campo_de_texto_ano_da_data_final.text = (widget.ano_da_data_final ?? "").toString();

    var dia_da_semana_da_data_inicial_na_frase = widget.dia_da_semana_da_data_inicial ?? "";
    if(dia_da_semana_da_data_inicial_na_frase != ""){
      dia_da_semana_da_data_inicial_na_frase = " (" + dia_da_semana_da_data_inicial_na_frase + ")";
    }
    var dia_da_semana_da_data_final_na_frase = widget.dia_da_semana_da_data_final ?? "";
    if(dia_da_semana_da_data_final_na_frase != ""){
      dia_da_semana_da_data_final_na_frase = " (" + dia_da_semana_da_data_final_na_frase + ")";
    }

    return Container(
      padding: EdgeInsets.only(top: 12, right: 4, bottom: 16, left: 20),
      child: Scrollbar(
        controller: controlador_da_barra_de_rolagem_horizontal,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: controlador_da_barra_de_rolagem_horizontal,
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            controller: controlador_da_barra_de_rolagem_vertical,
            child: Padding(
              padding: EdgeInsets.only(top: 0, right: 16, bottom: 0, left: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          "Dia     Mês    Ano",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20
                          ),
                          textAlign: TextAlign.left
                        ),
                        SizedBox(
                          height: 4
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50,
                              height: 36,
                              child: TextField(
                                controller: controlador_do_campo_de_texto_dia_da_data_inicial,
                                maxLines: null,
                                expands: true,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.only(top: 9, right: 0, bottom: 0, left: 4)
                                ),
                                onChanged: (texto){
                                  calcular_periodo("dia_da_data_inicial", texto);
                                }
                              )
                            ),
                            SizedBox(
                              width: 10
                            ),
                            SizedBox(
                              width: 50,
                              height: 36,
                              child: TextField(
                                controller: controlador_do_campo_de_texto_mes_da_data_inicial,
                                maxLines: null,
                                expands: true,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.only(top: 9, right: 0, bottom: 0, left: 4)
                                ),
                                onChanged: (texto){
                                  calcular_periodo("mes_da_data_inicial", texto);
                                }
                              )
                            ),
                            SizedBox(
                              width: 10
                            ),
                            SizedBox(
                              width: 100,
                              height: 36,
                              child: TextField(
                                controller: controlador_do_campo_de_texto_ano_da_data_inicial,
                                maxLines: null,
                                expands: true,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.only(top: 9, right: 0, bottom: 0, left: 4)
                                ),
                                onChanged: (texto){
                                  calcular_periodo("ano_da_data_inicial", texto);
                                }
                              )
                            ),
                            SizedBox(
                              width: 10
                            ),
                            SelectableText(
                              "Primeiro dia" + dia_da_semana_da_data_inicial_na_frase,
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 20
                              ),
                              textAlign: TextAlign.left
                            )
                          ]
                        ),
                        SizedBox(
                          height: 32
                        ),
                        SelectableText(
                          "Quantidade",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20
                          ),
                          textAlign: TextAlign.left
                        ),
                        SizedBox(
                          height: 4
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 220,
                              height: 36,
                              child: TextField(
                                controller: controlador_do_campo_de_texto_quantidade_de_dias,
                                maxLines: null,
                                expands: true,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.only(top: 9, right: 0, bottom: 0, left: 4)
                                ),
                                onChanged: (texto){
                                  calcular_periodo("quantidade_de_dias", texto);
                                }
                              )
                            ),
                            SizedBox(
                              width: 10
                            ),
                            SelectableText(
                              "Dias",
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 20
                              ),
                              textAlign: TextAlign.left
                            )
                          ]
                        ),
                        SizedBox(
                          height: 32
                        ),
                        SelectableText(
                          "Dia     Mês    Ano",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20
                          ),
                          textAlign: TextAlign.left
                        ),
                        SizedBox(
                          height: 4
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50,
                              height: 36,
                              child: TextField(
                                controller: controlador_do_campo_de_texto_dia_da_data_final,
                                maxLines: null,
                                expands: true,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.only(top: 9, right: 0, bottom: 0, left: 4)
                                ),
                                onChanged: (texto){
                                  calcular_periodo("dia_da_data_final", texto);
                                }
                              )
                            ),
                            SizedBox(
                              width: 10
                            ),
                            SizedBox(
                              width: 50,
                              height: 36,
                              child: TextField(
                                controller: controlador_do_campo_de_texto_mes_da_data_final,
                                maxLines: null,
                                expands: true,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.only(top: 9, right: 0, bottom: 0, left: 4)
                                ),
                                onChanged: (texto){
                                  calcular_periodo("mes_da_data_final", texto);
                                }
                              )
                            ),
                            SizedBox(
                              width: 10
                            ),
                            SizedBox(
                              width: 100,
                              height: 36,
                              child: TextField(
                                controller: controlador_do_campo_de_texto_ano_da_data_final,
                                maxLines: null,
                                expands: true,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.only(top: 9, right: 0, bottom: 0, left: 4)
                                ),
                                onChanged: (texto){
                                  calcular_periodo("ano_da_data_final", texto);
                                }
                              )
                            ),
                            SizedBox(
                              width: 10
                            ),
                            SelectableText(
                              "Último dia" + dia_da_semana_da_data_final_na_frase,
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 20
                              ),
                              textAlign: TextAlign.left
                            )
                          ]
                        )
                      ]
                    )
                  )
                ]
              )
            )
          )
        )
      )
    );
  }
}
