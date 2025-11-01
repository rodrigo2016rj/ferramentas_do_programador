import "dart:math";
import "package:flutter/material.dart";

class ConverterCores extends StatefulWidget{
  ConverterCores({
    super.key,
    required this.largura_do_menu_lateral,
    required this.largura_minima_para_mostrar_menus_laterais
  });

  final largura_do_menu_lateral;
  final largura_minima_para_mostrar_menus_laterais;

  var cor_em_rgb = "#000000";
  var cor_em_rgba = "#000000FF";
  var cor_em_metodo_rgb = "rgb(0, 0, 0)";
  var cor_em_metodo_rgba = "rgb(0, 0, 0, 255)";
  var cor_em_classe_argb = "Color(0xFF000000)";
  var ultimo_campo_utilizado = "";
  var vermelho = 0;
  var verde = 0;
  var azul = 0;
  var alfa = 255;
  var cor = Color(0xFF000000);

  @override
  State<ConverterCores> createState() => EstadoDoConverterCores();
}

class EstadoDoConverterCores extends State<ConverterCores>{
  var controlador_do_campo_de_texto_cor_em_rgb = TextEditingController();
  var controlador_do_campo_de_texto_cor_em_rgba = TextEditingController();
  var controlador_do_campo_de_texto_cor_em_metodo_rgb = TextEditingController();
  var controlador_do_campo_de_texto_cor_em_metodo_rgba = TextEditingController();
  var controlador_do_campo_de_texto_cor_em_classe_argb = TextEditingController();

  detectar_parametros(formato, valor){
    var cor_em_rgb = widget.cor_em_rgb;
    var cor_em_rgba = widget.cor_em_rgba;
    var cor_em_metodo_rgb = widget.cor_em_metodo_rgb;
    var cor_em_metodo_rgba = widget.cor_em_metodo_rgba;
    var cor_em_classe_argb = widget.cor_em_classe_argb;
    var ultimo_campo_utilizado = widget.ultimo_campo_utilizado;
    var vermelho = widget.vermelho;
    var verde = widget.verde;
    var azul = widget.azul;
    var alfa = widget.alfa;
    var cor = widget.cor;

    switch(formato){
      case "cor_em_rgb":
        var combinacoes = RegExp(r"#([0-9|a-f|A-F]{2})([0-9|a-f|A-F]{2})([0-9|a-f|A-F]{2})").firstMatch(valor);
        if(combinacoes != null){
          ultimo_campo_utilizado = "cor_em_rgb";
          var primeiro_parametro = combinacoes.group(1) ?? "";
          var segundo_parametro = combinacoes.group(2) ?? "";
          var terceiro_parametro = combinacoes.group(3) ?? "";
          alfa = 255;
          vermelho = int.parse(primeiro_parametro, radix: 16);
          verde = int.parse(segundo_parametro, radix: 16);
          azul = int.parse(terceiro_parametro, radix: 16);
          cor = Color.fromARGB(alfa, vermelho, verde, azul);
        }else{
          return false;
        }
      break;
      case "cor_em_rgba":
        var combinacoes = RegExp(r"#([0-9|a-f|A-F]{2})([0-9|a-f|A-F]{2})([0-9|a-f|A-F]{2})([0-9|a-f|A-F]{2})").firstMatch(valor);
        if(combinacoes != null){
          ultimo_campo_utilizado = "cor_em_rgba";
          var primeiro_parametro = combinacoes.group(1) ?? "";
          var segundo_parametro = combinacoes.group(2) ?? "";
          var terceiro_parametro = combinacoes.group(3) ?? "";
          var quarto_parametro = combinacoes.group(4) ?? "";
          vermelho = int.parse(primeiro_parametro, radix: 16);
          verde = int.parse(segundo_parametro, radix: 16);
          azul = int.parse(terceiro_parametro, radix: 16);
          alfa = int.parse(quarto_parametro, radix: 16);
          cor = Color.fromARGB(alfa, vermelho, verde, azul);
        }else{
          return false;
        }
      break;
      case "cor_em_metodo_rgb":
        var combinacoes = RegExp(r"rgb\(([0-9]{1,3})\,\s([0-9]{1,3})\,\s([0-9]{1,3})\)").firstMatch(valor);
        if(combinacoes != null){
          ultimo_campo_utilizado = "cor_em_metodo_rgb";
          var primeiro_parametro = combinacoes.group(1) ?? "";
          var segundo_parametro = combinacoes.group(2) ?? "";
          var terceiro_parametro = combinacoes.group(3) ?? "";
          alfa = 255;
          vermelho = min(int.parse(primeiro_parametro), 255);
          verde = min(int.parse(segundo_parametro), 255);
          azul = min(int.parse(terceiro_parametro), 255);
          cor = Color.fromARGB(alfa, vermelho, verde, azul);
        }else{
          return false;
        }
      break;
      case "cor_em_metodo_rgba":
        var combinacoes = RegExp(r"rgb\(([0-9]{1,3})\,\s([0-9]{1,3})\,\s([0-9]{1,3})\,\s([0-9]{1,3})\)").firstMatch(valor);
        if(combinacoes != null){
          ultimo_campo_utilizado = "cor_em_metodo_rgba";
          var primeiro_parametro = combinacoes.group(1) ?? "";
          var segundo_parametro = combinacoes.group(2) ?? "";
          var terceiro_parametro = combinacoes.group(3) ?? "";
          var quarto_parametro = combinacoes.group(4) ?? "";
          vermelho = min(int.parse(primeiro_parametro), 255);
          verde = min(int.parse(segundo_parametro), 255);
          azul = min(int.parse(terceiro_parametro), 255);
          alfa = min(int.parse(quarto_parametro), 255);
          cor = Color.fromARGB(alfa, vermelho, verde, azul);
        }else{
          return false;
        }
      break;
      case "cor_em_classe_argb":
        var combinacoes = RegExp(r"Color\(0x([0-9|a-f|A-F]{2})([0-9|a-f|A-F]{2})([0-9|a-f|A-F]{2})([0-9|a-f|A-F]{2})\)").firstMatch(valor);
        if(combinacoes != null){
          ultimo_campo_utilizado = "cor_em_classe_argb";
          var primeiro_parametro = combinacoes.group(1) ?? "";
          var segundo_parametro = combinacoes.group(2) ?? "";
          var terceiro_parametro = combinacoes.group(3) ?? "";
          var quarto_parametro = combinacoes.group(4) ?? "";
          alfa = int.parse(primeiro_parametro, radix: 16);
          vermelho = int.parse(segundo_parametro, radix: 16);
          verde = int.parse(terceiro_parametro, radix: 16);
          azul = int.parse(quarto_parametro, radix: 16);
          cor = Color.fromARGB(alfa, vermelho, verde, azul);
        }else{
          return false;
        }
      break;
      default:
        return false;
      break;
    }

    cor_em_rgb = "#";
    cor_em_rgb += (cor.r * 255.0).toInt().toRadixString(16).toUpperCase().padLeft(2, "0");
    cor_em_rgb += (cor.g * 255.0).toInt().toRadixString(16).toUpperCase().padLeft(2, "0");
    cor_em_rgb += (cor.b * 255.0).toInt().toRadixString(16).toUpperCase().padLeft(2, "0");

    cor_em_rgba = "#";
    cor_em_rgba += (cor.r * 255.0).toInt().toRadixString(16).toUpperCase().padLeft(2, "0");
    cor_em_rgba += (cor.g * 255.0).toInt().toRadixString(16).toUpperCase().padLeft(2, "0");
    cor_em_rgba += (cor.b * 255.0).toInt().toRadixString(16).toUpperCase().padLeft(2, "0");
    cor_em_rgba += (cor.a * 255.0).toInt().toRadixString(16).toUpperCase().padLeft(2, "0");

    cor_em_metodo_rgb = "rgb(";
    cor_em_metodo_rgb += (cor.r * 255.0).toInt().toString() + ", ";
    cor_em_metodo_rgb += (cor.g * 255.0).toInt().toString() + ", ";
    cor_em_metodo_rgb += (cor.b * 255.0).toInt().toString() + ")";

    cor_em_metodo_rgba = "rgb(";
    cor_em_metodo_rgba += (cor.r * 255.0).toInt().toString() + ", ";
    cor_em_metodo_rgba += (cor.g * 255.0).toInt().toString() + ", ";
    cor_em_metodo_rgba += (cor.b * 255.0).toInt().toString() + ", ";
    cor_em_metodo_rgba += (cor.a * 255.0).toInt().toString() + ")";

    cor_em_classe_argb = "Color(0x";
    cor_em_classe_argb += (cor.a * 255.0).toInt().toRadixString(16).toUpperCase().padLeft(2, "0");
    cor_em_classe_argb += (cor.r * 255.0).toInt().toRadixString(16).toUpperCase().padLeft(2, "0");
    cor_em_classe_argb += (cor.g * 255.0).toInt().toRadixString(16).toUpperCase().padLeft(2, "0");
    cor_em_classe_argb += (cor.b * 255.0).toInt().toRadixString(16).toUpperCase().padLeft(2, "0");
    cor_em_classe_argb += ")";

    setState((){
      widget.cor_em_rgb = cor_em_rgb;
      widget.cor_em_rgba = cor_em_rgba;
      widget.cor_em_metodo_rgb = cor_em_metodo_rgb;
      widget.cor_em_metodo_rgba = cor_em_metodo_rgba;
      widget.cor_em_classe_argb = cor_em_classe_argb;
      widget.ultimo_campo_utilizado = ultimo_campo_utilizado;
      widget.vermelho = vermelho;
      widget.verde = verde;
      widget.azul = azul;
      widget.alfa = alfa;
      widget.cor = cor;
    });

    return true;
  }

  @override
  Widget build(BuildContext context){
    var controlador_da_barra_de_rolagem_horizontal = ScrollController();
    var controlador_da_barra_de_rolagem_vertical = ScrollController();
    var largura_do_formulario = 350;
    if(MediaQuery.of(context).size.width < widget.largura_minima_para_mostrar_menus_laterais + 750){
      largura_do_formulario = 300;
    }
    if(MediaQuery.of(context).size.width < widget.largura_minima_para_mostrar_menus_laterais + 700){
      largura_do_formulario = 250;
    }
    var largura_da_visualizacao = MediaQuery.of(context).size.width - widget.largura_do_menu_lateral * 2 - largura_do_formulario - 40;
    if(MediaQuery.of(context).size.width < widget.largura_minima_para_mostrar_menus_laterais){
      largura_da_visualizacao = MediaQuery.of(context).size.width - largura_do_formulario - 40;
    }
    if(largura_da_visualizacao < 250){
      largura_da_visualizacao = 250;
    }

    controlador_do_campo_de_texto_cor_em_rgb.text = widget.cor_em_rgb;
    controlador_do_campo_de_texto_cor_em_rgba.text = widget.cor_em_rgba;
    controlador_do_campo_de_texto_cor_em_metodo_rgb.text = widget.cor_em_metodo_rgb;
    controlador_do_campo_de_texto_cor_em_metodo_rgba.text = widget.cor_em_metodo_rgba;
    controlador_do_campo_de_texto_cor_em_classe_argb.text = widget.cor_em_classe_argb;

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
                    width: largura_do_formulario.toDouble(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          "CSS - Hexadecimal RGB",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20,
                            fontWeight: widget.ultimo_campo_utilizado == "cor_em_rgb" ? FontWeight.bold : FontWeight.normal
                          ),
                          textAlign: TextAlign.left
                        ),
                        SizedBox(
                          height: 4
                        ),
                        SelectableText(
                          widget.cor_em_rgb,
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20,
                            fontWeight: widget.ultimo_campo_utilizado == "cor_em_rgb" ? FontWeight.bold : FontWeight.normal
                          ),
                          textAlign: TextAlign.left
                        ),
                        SizedBox(
                          height: 4
                        ),
                        SizedBox(
                          width: 220,
                          height: 36,
                          child: TextField(
                            controller: controlador_do_campo_de_texto_cor_em_rgb,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.only(top: 9, right: 0, bottom: 0, left: 4)
                            ),
                            onChanged: (texto){
                              detectar_parametros("cor_em_rgb", texto);
                            }
                          )
                        ),
                        SizedBox(
                          height: 32
                        ),
                        SelectableText(
                          "CSS - Hexadecimal RGBA",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20,
                            fontWeight: widget.ultimo_campo_utilizado == "cor_em_rgba" ? FontWeight.bold : FontWeight.normal
                          ),
                          textAlign: TextAlign.left
                        ),
                        SizedBox(
                          height: 4
                        ),
                        SelectableText(
                          widget.cor_em_rgba,
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20,
                            fontWeight: widget.ultimo_campo_utilizado == "cor_em_rgba" ? FontWeight.bold : FontWeight.normal
                          ),
                          textAlign: TextAlign.left
                        ),
                        SizedBox(
                          height: 4
                        ),
                        SizedBox(
                          width: 220,
                          height: 36,
                          child: TextField(
                            controller: controlador_do_campo_de_texto_cor_em_rgba,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.only(top: 9, right: 0, bottom: 0, left: 4)
                            ),
                            onChanged: (texto){
                              detectar_parametros("cor_em_rgba", texto);
                            }
                          )
                        ),
                        SizedBox(
                          height: 32
                        ),
                        SelectableText(
                          "CSS - Método RGB",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20,
                            fontWeight: widget.ultimo_campo_utilizado == "cor_em_metodo_rgb" ? FontWeight.bold : FontWeight.normal
                          ),
                          textAlign: TextAlign.left
                        ),
                        SizedBox(
                          height: 4
                        ),
                        SelectableText(
                          widget.cor_em_metodo_rgb,
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20,
                            fontWeight: widget.ultimo_campo_utilizado == "cor_em_metodo_rgb" ? FontWeight.bold : FontWeight.normal
                          ),
                          textAlign: TextAlign.left
                        ),
                        SizedBox(
                          height: 4
                        ),
                        SizedBox(
                          width: 220,
                          height: 36,
                          child: TextField(
                            controller: controlador_do_campo_de_texto_cor_em_metodo_rgb,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.only(top: 9, right: 0, bottom: 0, left: 4)
                            ),
                            onChanged: (texto){
                              detectar_parametros("cor_em_metodo_rgb", texto);
                            }
                          )
                        ),
                        SizedBox(
                          height: 32
                        ),
                        SelectableText(
                          "CSS - Método RGBA",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20,
                            fontWeight: widget.ultimo_campo_utilizado == "cor_em_metodo_rgba" ? FontWeight.bold : FontWeight.normal
                          ),
                          textAlign: TextAlign.left
                        ),
                        SizedBox(
                          height: 4
                        ),
                        SelectableText(
                          widget.cor_em_metodo_rgba,
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20,
                            fontWeight: widget.ultimo_campo_utilizado == "cor_em_metodo_rgba" ? FontWeight.bold : FontWeight.normal
                          ),
                          textAlign: TextAlign.left
                        ),
                        SizedBox(
                          height: 4
                        ),
                        SizedBox(
                          width: 220,
                          height: 36,
                          child: TextField(
                            controller: controlador_do_campo_de_texto_cor_em_metodo_rgba,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.only(top: 9, right: 0, bottom: 0, left: 4)
                            ),
                            onChanged: (texto){
                              detectar_parametros("cor_em_metodo_rgba", texto);
                            }
                          )
                        ),
                        SizedBox(
                          height: 32
                        ),
                        SelectableText(
                          "Flutter - Classe Color ARGB",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20,
                            fontWeight: widget.ultimo_campo_utilizado == "cor_em_classe_argb" ? FontWeight.bold : FontWeight.normal
                          ),
                          textAlign: TextAlign.left
                        ),
                        SizedBox(
                          height: 4
                        ),
                        SelectableText(
                          widget.cor_em_classe_argb,
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20,
                            fontWeight: widget.ultimo_campo_utilizado == "cor_em_classe_argb" ? FontWeight.bold : FontWeight.normal
                          ),
                          textAlign: TextAlign.left
                        ),
                        SizedBox(
                          height: 4
                        ),
                        SizedBox(
                          width: 220,
                          height: 36,
                          child: TextField(
                            controller: controlador_do_campo_de_texto_cor_em_classe_argb,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.only(top: 9, right: 0, bottom: 0, left: 4)
                            ),
                            onChanged: (texto){
                              detectar_parametros("cor_em_classe_argb", texto);
                            }
                          )
                        )
                      ]
                    )
                  ),
                  Container(
                    width: largura_da_visualizacao.toDouble(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          "Visualização:",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20
                          ),
                          textAlign: TextAlign.center
                        ),
                        SizedBox(
                          height: 4
                        ),
                        Container(
                          width: largura_da_visualizacao.toDouble(),
                          height: 620,
                          color: widget.cor
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
