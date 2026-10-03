import "dart:io";
import "package:flutter/material.dart";

class MudarVariavelUserPath extends StatefulWidget{
  MudarVariavelUserPath({
    super.key,
    required this.largura_do_menu_lateral,
    required this.largura_minima_para_mostrar_menus_laterais
  });

  final largura_do_menu_lateral;
  final largura_minima_para_mostrar_menus_laterais;

  var controlador_da_area_de_texto = TextEditingController();
  var valor_atual = "";
  var status_da_operacao = "";
  var texto_da_operacao = "";

  @override
  State<MudarVariavelUserPath> createState() => EstadoDoMudarVariavelUserPath();
}

class EstadoDoMudarVariavelUserPath extends State<MudarVariavelUserPath>{
  @override
  void initState(){
    super.initState();
    consultar_valor_atual();
  }

  Future<void> consultar_valor_atual() async {
    try {
      var resultado = await Process.run("reg", [
        "query",
        r"HKCU\Environment",
        "/v",
        "PATH",
      ]);

      var valor_atual = "";

      if(resultado.exitCode == 0){
        var linhas = resultado.stdout.toString().split("\r\n");
        for(var linha in linhas){
          linha = linha.trim();
          if(linha.startsWith("PATH")){
            linha = linha.replaceFirst(RegExp(r"^PATH\s+", caseSensitive: false), "");
            linha = linha.replaceFirst(RegExp(r"^REG_[A-Z_]+\s+", caseSensitive: false), "");
            valor_atual = linha.replaceAll(";", "\r\n");
            break;
          }
        }
        setState((){
          widget.valor_atual = valor_atual;
        });
      }
    }catch(excecao){
      setState((){
        widget.texto_da_operacao = "Erro: $excecao";
      });
    }
  }

  salvar_novo_valor(novo_valor) async {
    setState((){
      widget.status_da_operacao = "Aguarde...";
      widget.texto_da_operacao = "";
    });

    var backup_novo_valor = novo_valor;
    novo_valor = novo_valor.replaceAll("\r\n", ";");
    novo_valor = novo_valor.replaceAll("\r", ";");
    novo_valor = novo_valor.replaceAll("\n", ";");

    try{
      var resultado = await Process.run("reg", [
        "add",
        r"HKCU\Environment",
        "/v",
        "PATH",
        "/t",
        "REG_EXPAND_SZ",
        "/d",
        novo_valor,
        "/f",
      ]);

      if(resultado.exitCode == 0){
        setState((){
          widget.status_da_operacao = "Concluído.";
          widget.texto_da_operacao = r"O novo valor para o Path foi salvo. Para conferir, abra uma nova janela do PowerShell e consulte por meio do comando: (Get-ItemProperty -Path 'HKCU:\Environment').Path -split ';'";
          widget.valor_atual = backup_novo_valor;
        });
      }else{
        setState((){
          widget.status_da_operacao = "Operação falhou.";
          widget.texto_da_operacao = "Erro: ${resultado.stderr}";
        });
      }

    }catch(excecao){
      setState((){
        widget.status_da_operacao = "Operação falhou.";
        widget.texto_da_operacao = "Erro: $excecao";
      });
    }
  }

  @override
  Widget build(BuildContext context){
    var controlador_da_barra_de_rolagem_horizontal = ScrollController();
    var controlador_da_barra_de_rolagem_vertical = ScrollController();
    var largura_da_area_de_texto = MediaQuery.of(context).size.width - widget.largura_do_menu_lateral * 2 - 40;
    if(MediaQuery.of(context).size.width < widget.largura_minima_para_mostrar_menus_laterais){
      largura_da_area_de_texto = MediaQuery.of(context).size.width - 40;
    }

    var borda_do_botao_salvar = WidgetStateProperty.resolveWith<BorderSide>(
      (Set<WidgetState> states){
        if(states.contains(WidgetState.hovered)){
          return BorderSide(
            color: Color(0xFF166816),
            width: 1.5,
            style: BorderStyle.solid
          );
        }
        return BorderSide(
          color: Color(0xFF509050),
          width: 1.5,
          style: BorderStyle.solid
        );
      }
    );

    var espacamento_interno_do_botao_salvar = WidgetStateProperty.resolveWith<EdgeInsetsGeometry>(
      (Set<WidgetState> states){
        return EdgeInsets.only(top: 15, right: 8, bottom: 16, left: 8);
      }
    );

    var cor_de_fundo_do_botao_salvar = WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states){
        if(states.contains(WidgetState.hovered)){
          return Color(0xFF287028);
        }
        return Color(0xFF509050);
      }
    );

    var cor_do_texto_do_botao_salvar = WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states){
        return Color(0xFFFFFFFF);
      }
    );

    widget.controlador_da_area_de_texto.text = widget.valor_atual;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    "Mude a variável de ambiente User Path (separe cada caminho por quebra de linha).",
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 22
                    ),
                    textAlign: TextAlign.left
                  ),
                  SizedBox(
                    height: 12
                  ),
                  SizedBox(
                    width: largura_da_area_de_texto.toDouble(),
                    height: 400,
                    child: TextField(
                      controller: widget.controlador_da_area_de_texto,
                      keyboardType: TextInputType.multiline,
                      minLines: 20,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(top: 8, right: 0, bottom: 8, left: 8),
                        hintText: ""
                      )
                    )
                  ),
                  SizedBox(
                    height: 18
                  ),
                  Row(
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          side: borda_do_botao_salvar,
                          padding: espacamento_interno_do_botao_salvar,
                          backgroundColor: cor_de_fundo_do_botao_salvar,
                          foregroundColor: cor_do_texto_do_botao_salvar,
                          alignment: Alignment.center
                        ),
                        onPressed: (){
                          salvar_novo_valor(
                            widget.controlador_da_area_de_texto.text
                          );
                        },
                        child: Text(
                          "Salvar",
                          style: TextStyle(
                            fontSize: 16
                          )
                        )
                      ),
                      SizedBox(
                        width: 6
                      ),
                      SelectableText(
                        widget.status_da_operacao,
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 18
                        ),
                        textAlign: TextAlign.left
                      )
                    ]
                  ),
                  SizedBox(
                    height: 18
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 780,
                        child: SelectableText(
                          widget.texto_da_operacao,
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 18
                          ),
                          textAlign: TextAlign.left
                        )
                      )
                    ]
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
