import "dart:math";
import "package:flutter/material.dart";
import "package:ferramentas_do_programador/separar_arquivos.dart";
import "package:ferramentas_do_programador/converter_cores.dart";
import "package:ferramentas_do_programador/calcular_periodos.dart";

main(){
  runApp(FerramentasDoProgramador());
}

class FerramentasDoProgramador extends StatefulWidget{
  FerramentasDoProgramador({
    super.key
  });

  var nome_do_sistema = "Ferramentas do Programador";
  var altura_do_cabecalho = 66;
  var altura_do_rodape = 66;
  var largura_do_menu_lateral = 150; //Este sistema possui 2 menus laterais
  var largura_minima_para_mostrar_menus_laterais = 550; //Deve ser no mínimo o dobro da largura_do_menu_lateral
  dynamic pagina_do_sistema = SepararArquivos(
    largura_do_menu_lateral: 150,
    largura_minima_para_mostrar_menus_laterais: 550
  );

  @override
  State<FerramentasDoProgramador> createState() => EstadoDoFerramentasDoProgramador();
}

class EstadoDoFerramentasDoProgramador extends State<FerramentasDoProgramador>{
  mudar_pagina_do_sistema(pagina_escolhida){
    dynamic pagina_do_sistema = SepararArquivos(
      largura_do_menu_lateral: widget.largura_do_menu_lateral,
      largura_minima_para_mostrar_menus_laterais: widget.largura_minima_para_mostrar_menus_laterais
    );

    switch(pagina_escolhida){
      case "Separar Arquivos":
        pagina_do_sistema = SepararArquivos(
          largura_do_menu_lateral: widget.largura_do_menu_lateral,
          largura_minima_para_mostrar_menus_laterais: widget.largura_minima_para_mostrar_menus_laterais
        );
      break;
      case "Converter Cores":
        pagina_do_sistema = ConverterCores(
          largura_do_menu_lateral: widget.largura_do_menu_lateral,
          largura_minima_para_mostrar_menus_laterais: widget.largura_minima_para_mostrar_menus_laterais
        );
      break;
      case "Calcular Períodos":
        pagina_do_sistema = CalcularPeriodos(
          largura_do_menu_lateral: widget.largura_do_menu_lateral,
          largura_minima_para_mostrar_menus_laterais: widget.largura_minima_para_mostrar_menus_laterais
        );
      break;
    }

    setState((){
      widget.pagina_do_sistema = pagina_do_sistema;
    });
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: widget.nome_do_sistema,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(RoundedRectangleBorder()),
            padding: WidgetStateProperty.all(EdgeInsets.zero),
            minimumSize: WidgetStateProperty.all(Size.zero),
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            splashFactory: NoSplash.splashFactory
          )
        )
      ),
      home: Scaffold(
        body: Center(
          child: Container(
            child: Column(
              children: [
                Cabecalho(
                  titulo: widget.nome_do_sistema,
                  altura_do_cabecalho: widget.altura_do_cabecalho,
                  altura_do_rodape: widget.altura_do_rodape
                ),
                Row(
                  children: [
                    MenuDaLateralEsquerda(
                      altura_do_cabecalho: widget.altura_do_cabecalho,
                      altura_do_rodape: widget.altura_do_rodape,
                      largura_do_menu_lateral: widget.largura_do_menu_lateral,
                      largura_minima_para_mostrar_menus_laterais: widget.largura_minima_para_mostrar_menus_laterais,
                      pagina_do_sistema: widget.pagina_do_sistema,
                      mudar_pagina_do_sistema: mudar_pagina_do_sistema
                    ),
                    PaginaDoSistema(
                      altura_do_cabecalho: widget.altura_do_cabecalho,
                      altura_do_rodape: widget.altura_do_rodape,
                      largura_do_menu_lateral: widget.largura_do_menu_lateral,
                      largura_minima_para_mostrar_menus_laterais: widget.largura_minima_para_mostrar_menus_laterais,
                      pagina_do_sistema: widget.pagina_do_sistema
                    ),
                    MenuDaLateralDireita(
                      altura_do_cabecalho: widget.altura_do_cabecalho,
                      altura_do_rodape: widget.altura_do_rodape,
                      largura_do_menu_lateral: widget.largura_do_menu_lateral,
                      largura_minima_para_mostrar_menus_laterais: widget.largura_minima_para_mostrar_menus_laterais,
                      pagina_do_sistema: widget.pagina_do_sistema,
                      mudar_pagina_do_sistema: mudar_pagina_do_sistema
                    )
                  ]
                ),
                Rodape(
                  altura_do_cabecalho: widget.altura_do_cabecalho,
                  altura_do_rodape: widget.altura_do_rodape
                )
              ]
            )
          )
        )
      )
    );
  }
}

class Cabecalho extends StatefulWidget{
  Cabecalho({
    super.key,
    required this.titulo,
    required this.altura_do_cabecalho,
    required this.altura_do_rodape
  });

  final titulo;
  final altura_do_cabecalho;
  final altura_do_rodape;

  @override
  State<Cabecalho> createState() => EstadoDoCabecalho();
}

class EstadoDoCabecalho extends State<Cabecalho> {
  @override
  Widget build(BuildContext context){
    var largura = MediaQuery.of(context).size.width;

    var altura = widget.altura_do_cabecalho;
    if(MediaQuery.of(context).size.height < widget.altura_do_cabecalho + widget.altura_do_rodape){
      altura = 0;
    }

    return Container(
      padding: EdgeInsets.only(top: 14, right: 10, bottom: 16, left: 10),
      width: largura.toDouble(),
      height: altura.toDouble(),
      color: Color(0xFF509050),
      child: SelectableText(
        widget.titulo,
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 25
        ),
        textAlign: TextAlign.center
      )
    );
  }
}

class MenuDaLateralEsquerda extends StatefulWidget{
  MenuDaLateralEsquerda({
    super.key,
    required this.altura_do_cabecalho,
    required this.altura_do_rodape,
    required this.largura_do_menu_lateral,
    required this.largura_minima_para_mostrar_menus_laterais,
    required this.pagina_do_sistema,
    required this.mudar_pagina_do_sistema
  });

  final altura_do_cabecalho;
  final altura_do_rodape;
  final largura_do_menu_lateral;
  final largura_minima_para_mostrar_menus_laterais;
  final pagina_do_sistema;
  final mudar_pagina_do_sistema;

  @override
  State<MenuDaLateralEsquerda> createState() => EstadoDoMenuDaLateralEsquerda();
}

class EstadoDoMenuDaLateralEsquerda extends State<MenuDaLateralEsquerda>{
  @override
  Widget build(BuildContext context){
    var largura = MediaQuery.of(context).size.width >= widget.largura_minima_para_mostrar_menus_laterais ? widget.largura_do_menu_lateral : 0;
    var altura = max(MediaQuery.of(context).size.height - widget.altura_do_cabecalho - widget.altura_do_rodape, 0);

    var controlador_da_barra_de_rolagem = ScrollController();

    var espacamento_interno_do_botao = WidgetStateProperty.resolveWith<EdgeInsetsGeometry>(
      (Set<WidgetState> states){
        return EdgeInsets.only(top: 15, right: 10, bottom: 16, left: 10);
      },
    );

    var tamanho_do_botao = WidgetStateProperty.resolveWith<Size>(
      (Set<WidgetState> states){
        return Size(widget.largura_do_menu_lateral.toDouble() + 10, 0);
      },
    );

    var cor_de_fundo_do_botao = WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states){
        if(states.contains(WidgetState.hovered)){
          return Color(0xFFA4D0A4);
        }
        return Color(0xFF509050);
      }
    );

    var cor_especial_de_fundo_do_botao = WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states){
        if(states.contains(WidgetState.hovered)){
          return Color(0xFFF2F2FD);
        }
        return Color(0xFFFFFFFF);
      }
    );

    var cor_do_texto_do_botao = WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states){
        if(states.contains(WidgetState.hovered)){
          return Color(0xFF004800);
        }
        return Color(0xFFFFFFFF);
      }
    );

    var cor_especial_do_texto_do_botao = WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states){
        return Color(0xFF121268);
      }
    );

    return Container(
      width: largura.toDouble(),
      height: altura.toDouble(),
      color: Color(0xFF509050),
      child: Scrollbar(
        controller: controlador_da_barra_de_rolagem,
        child: SingleChildScrollView(
          controller: controlador_da_barra_de_rolagem,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                style: ButtonStyle(
                  padding: espacamento_interno_do_botao,
                  minimumSize: tamanho_do_botao,
                  backgroundColor: widget.pagina_do_sistema is SepararArquivos ? cor_especial_de_fundo_do_botao : cor_de_fundo_do_botao,
                  foregroundColor: widget.pagina_do_sistema is SepararArquivos ? cor_especial_do_texto_do_botao : cor_do_texto_do_botao,
                  alignment: Alignment.centerLeft
                ),
                onPressed: (){
                  widget.mudar_pagina_do_sistema("Separar Arquivos");
                },
                child: Text(
                  "Separar Arquivos",
                  style: TextStyle(
                    fontSize: 16
                  )
                )
              ),
              TextButton(
                style: ButtonStyle(
                  padding: espacamento_interno_do_botao,
                  minimumSize: tamanho_do_botao,
                  backgroundColor: widget.pagina_do_sistema is ConverterCores ? cor_especial_de_fundo_do_botao : cor_de_fundo_do_botao,
                  foregroundColor: widget.pagina_do_sistema is ConverterCores ? cor_especial_do_texto_do_botao : cor_do_texto_do_botao,
                  alignment: Alignment.centerLeft
                ),
                onPressed: (){
                  widget.mudar_pagina_do_sistema("Converter Cores");
                },
                child: Text(
                  "Converter Cores",
                  style: TextStyle(
                    fontSize: 16
                  )
                )
              ),
              TextButton(
                style: ButtonStyle(
                  padding: espacamento_interno_do_botao,
                  minimumSize: tamanho_do_botao,
                  backgroundColor: widget.pagina_do_sistema is CalcularPeriodos ? cor_especial_de_fundo_do_botao : cor_de_fundo_do_botao,
                  foregroundColor: widget.pagina_do_sistema is CalcularPeriodos ? cor_especial_do_texto_do_botao : cor_do_texto_do_botao,
                  alignment: Alignment.centerLeft
                ),
                onPressed: (){
                  widget.mudar_pagina_do_sistema("Calcular Períodos");
                },
                child: Text(
                  "Calcular Períodos",
                  style: TextStyle(
                    fontSize: 16
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}

class PaginaDoSistema extends StatefulWidget{
  PaginaDoSistema({
    super.key,
    required this.altura_do_cabecalho,
    required this.altura_do_rodape,
    required this.largura_do_menu_lateral,
    required this.largura_minima_para_mostrar_menus_laterais,
    required this.pagina_do_sistema
  });

  final altura_do_cabecalho;
  final altura_do_rodape;
  final largura_do_menu_lateral;
  final largura_minima_para_mostrar_menus_laterais;
  final pagina_do_sistema;

  @override
  State<PaginaDoSistema> createState() => EstadoDaPaginaDoSistema();
}

class EstadoDaPaginaDoSistema extends State<PaginaDoSistema>{
  @override
  Widget build(BuildContext context){
    var largura = MediaQuery.of(context).size.width - widget.largura_do_menu_lateral * 2;
    if(MediaQuery.of(context).size.width < widget.largura_minima_para_mostrar_menus_laterais){
      largura = MediaQuery.of(context).size.width;
    }

    var altura = max(MediaQuery.of(context).size.height - widget.altura_do_cabecalho - widget.altura_do_rodape, 0);

    return Container(
      width: largura.toDouble(),
      height: altura.toDouble(),
      color: Color(0xFFFFFFFF),
      child: widget.pagina_do_sistema
    );
  }
}

class MenuDaLateralDireita extends StatefulWidget{
  MenuDaLateralDireita({
    super.key,
    required this.altura_do_cabecalho,
    required this.altura_do_rodape,
    required this.largura_do_menu_lateral,
    required this.largura_minima_para_mostrar_menus_laterais,
    required this.pagina_do_sistema,
    required this.mudar_pagina_do_sistema
  });

  final altura_do_cabecalho;
  final altura_do_rodape;
  final largura_do_menu_lateral;
  final largura_minima_para_mostrar_menus_laterais;
  final pagina_do_sistema;
  final mudar_pagina_do_sistema;

  @override
  State<MenuDaLateralDireita> createState() => EstadoDoMenuDaLateralDireita();
}

class EstadoDoMenuDaLateralDireita extends State<MenuDaLateralDireita>{
  @override
  Widget build(BuildContext context){
    var largura = MediaQuery.of(context).size.width >= widget.largura_minima_para_mostrar_menus_laterais ? widget.largura_do_menu_lateral : 0;
    var altura = max(MediaQuery.of(context).size.height - widget.altura_do_cabecalho - widget.altura_do_rodape, 0);

    var controlador_da_barra_de_rolagem = ScrollController();

    var espacamento_interno_do_botao = WidgetStateProperty.resolveWith<EdgeInsetsGeometry>(
      (Set<WidgetState> states){
        return EdgeInsets.only(top: 15, right: 10, bottom: 16, left: 10);
      },
    );

    var tamanho_do_botao = WidgetStateProperty.resolveWith<Size>(
      (Set<WidgetState> states){
        return Size(widget.largura_do_menu_lateral.toDouble() + 10, 0);
      },
    );

    var cor_de_fundo_do_botao = WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states){
        if(states.contains(WidgetState.hovered)){
          return Color(0xFFA4D0A4);
        }
        return Color(0xFF509050);
      }
    );

    var cor_especial_de_fundo_do_botao = WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states){
        if(states.contains(WidgetState.hovered)){
          return Color(0xFFF2F2FD);
        }
        return Color(0xFFFFFFFF);
      }
    );

    var cor_do_texto_do_botao = WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states){
        if(states.contains(WidgetState.hovered)){
          return Color(0xFF004800);
        }
        return Color(0xFFFFFFFF);
      }
    );

    var cor_especial_do_texto_do_botao = WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states){
        return Color(0xFF121268);
      }
    );

    return Container(
      width: largura.toDouble(),
      height: altura.toDouble(),
      color: Color(0xFF509050),
      child: Scrollbar(
        controller: controlador_da_barra_de_rolagem,
        child: SingleChildScrollView(
          controller: controlador_da_barra_de_rolagem,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: []
          )
        )
      )
    );
  }
}

class Rodape extends StatefulWidget{
  Rodape({
    super.key,
    required this.altura_do_cabecalho,
    required this.altura_do_rodape
  });

  final altura_do_cabecalho;
  final altura_do_rodape;

  @override
  State<Rodape> createState() => EstadoDoRodape();
}

class EstadoDoRodape extends State<Rodape>{
  @override
  Widget build(BuildContext context){
    var largura = MediaQuery.of(context).size.width;

    var altura = widget.altura_do_rodape;
    if(MediaQuery.of(context).size.height < widget.altura_do_cabecalho + widget.altura_do_rodape){
      altura = 0;
    }

    return Container(
      padding: EdgeInsets.only(top: 15, right: 10, bottom: 15, left: 10),
      width: largura.toDouble(),
      height: altura.toDouble(),
      color: Color(0xFF509050),
      child: SelectableText(
        "Este sistema foi feito por Rodrigo Diniz da Silva",
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 25
        ),
        textAlign: TextAlign.center
      )
    );
  }
}
