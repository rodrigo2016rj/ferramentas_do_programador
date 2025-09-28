import "dart:io";
import "dart:math";
import "package:flutter/material.dart";
import "package:file_picker/file_picker.dart";

class SepararArquivos extends StatefulWidget{
  SepararArquivos({
    super.key,
    required this.largura_do_menu_lateral,
    required this.largura_minima_para_mostrar_menus_laterais
  });

  final largura_do_menu_lateral;
  final largura_minima_para_mostrar_menus_laterais;

  var controlador_da_area_de_texto = TextEditingController();
  var diretorio_de_referencia = "";
  var diretorio_de_destino = "";
  var status_da_operacao = "";
  var texto_do_resultado = "";
  List<Widget> informacoes_do_resultado = [];

  @override
  State<SepararArquivos> createState() => EstadoDoSepararArquivos();
}

class EstadoDoSepararArquivos extends State<SepararArquivos>{
  selecionar_diretorio(proposito) async {
    var diretorio_selecionado = await FilePicker.platform.getDirectoryPath();

    switch(proposito){
      case "referencia":
        setState((){
          widget.diretorio_de_referencia = diretorio_selecionado ?? "";
        });
      break;
      case "destino":
        setState((){
          widget.diretorio_de_destino = diretorio_selecionado ?? "";
        });
      break;
    }
  }

  copiar_arquivos_criando_diretorios(diretorio_de_referencia, diretorio_de_destino, caminhos_dos_arquivos) async {
    setState((){
      widget.status_da_operacao = "Aguarde...";
      widget.texto_do_resultado = "";
      widget.informacoes_do_resultado = [];
    });

    var informacoes = [];

    caminhos_dos_arquivos = caminhos_dos_arquivos.replaceAll("\r\n", "\n");
    caminhos_dos_arquivos = caminhos_dos_arquivos.replaceAll("\r", "\n");
    caminhos_dos_arquivos = caminhos_dos_arquivos.replaceAll("/", "\\");
    var lista_de_caminhos = caminhos_dos_arquivos.split("\n");

    for(var i = 0; i < lista_de_caminhos.length; i++){
      var caminho = lista_de_caminhos[i];

      var informacao = {};
      informacao["mensagem"] = "Tentando copiar \"$caminho\".";
      informacao["tipo"] = "acao";
      informacao["cor"] = Color(0xFF000000);
      informacoes.add(informacao);

      var objeto_arquivo = File(caminho);
      if(!await objeto_arquivo.exists()){
        var informacao = {};
        informacao["mensagem"] = "O arquivo não foi copiado, caminho inválido.";
        informacao["tipo"] = "conclusao";
        informacao["cor"] = Color(0xFF900000);
        informacoes.add(informacao);
        continue;
      }

      if(caminho.indexOf(diretorio_de_referencia) == -1){
        var informacao = {};
        informacao["mensagem"] = "O arquivo não foi copiado, o diretório de referência não foi encontrado no caminho do arquivo.";
        informacao["tipo"] = "conclusao";
        informacao["cor"] = Color(0xFF900000);
        informacoes.add(informacao);
        continue;
      }
      var caminho_relativo_do_arquivo = caminho.replaceFirst(diretorio_de_referencia, "");

      var caminho_relativo_do_diretorio = "";
      var nome_do_arquivo = caminho_relativo_do_arquivo;
      var posicao = caminho_relativo_do_arquivo.lastIndexOf("\\");
      if(posicao != -1){
        caminho_relativo_do_diretorio = caminho_relativo_do_arquivo.substring(0, posicao);
        nome_do_arquivo = caminho_relativo_do_arquivo.substring(posicao + 1);
      }

      var caminho_do_diretorio_a_ser_criado = "$diretorio_de_destino$caminho_relativo_do_diretorio";
      var caminho_do_destino_novo_arquivo = "$caminho_do_diretorio_a_ser_criado\\$nome_do_arquivo";

      var objeto_diretorio = Directory(caminho_do_diretorio_a_ser_criado);
      if(!await objeto_diretorio.exists()){
        await objeto_diretorio.create(recursive: true);
      }

      var objeto_novo_arquivo = File(caminho_do_destino_novo_arquivo);
      if(await objeto_novo_arquivo.exists()){
        var informacao = {};
        informacao["mensagem"] = "O arquivo não foi copiado, já existe um arquivo de mesmo nome em \"$caminho_do_destino_novo_arquivo\".";
        informacao["tipo"] = "conclusao";
        informacao["cor"] = Color(0xFF900000);
        informacoes.add(informacao);
        continue;
      }

      try{
        objeto_novo_arquivo = await objeto_arquivo.copy(caminho_do_destino_novo_arquivo);
        var informacao = {};
        informacao["mensagem"] = "Copiado com sucesso para \"$caminho_do_destino_novo_arquivo\".";
        informacao["tipo"] = "conclusao";
        informacao["cor"] = Color(0xFF007400);
        informacoes.add(informacao);
      }catch(excecao){
        var informacao = {};
        informacao["mensagem"] = "O arquivo não foi copiado. Ocorreu a seguinte exceção: $excecao";
        informacao["tipo"] = "conclusao";
        informacao["cor"] = Color(0xFF900000);
        informacoes.add(informacao);
        continue;
      }
    }

    var texto_do_resultado = "";
    List<Widget> informacoes_do_resultado = [];
    var lado_a_lado = Row(
      children: [
        SelectableText(
          "Resultado:",
          style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 22
          ),
          textAlign: TextAlign.left
        ),
        SizedBox(
          width: 6
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: salvar_resultado,
            child: Icon(
              Icons.save,
              size: 30.0,
              color: Color(0xFF208420)
            )
          )
        )
      ]
    );
    informacoes_do_resultado.add(lado_a_lado);
    var espaco_vertical = SizedBox(
      height: 12
    );
    informacoes_do_resultado.add(espaco_vertical);
    for(var informacao in informacoes){
      texto_do_resultado += informacao["mensagem"];
      texto_do_resultado += "\r\n";

      var texto_selecionavel = SelectableText(
        informacao["mensagem"],
        style: TextStyle(
          color: informacao["cor"],
          fontSize: 20
        ),
        textAlign: TextAlign.left
      );
      informacoes_do_resultado.add(texto_selecionavel);

      var espaco_vertical = null;
      switch(informacao["tipo"]){
        case "acao":
          espaco_vertical = SizedBox(
            height: 2
          );
        break;
        case "conclusao":
          espaco_vertical = SizedBox(
            height: 16
          );
          texto_do_resultado += "\r\n";
        break;
      }
      informacoes_do_resultado.add(espaco_vertical);
    }
    informacoes_do_resultado.removeLast();

    setState((){
      widget.status_da_operacao = "Concluído.";
      widget.texto_do_resultado = texto_do_resultado;
      widget.informacoes_do_resultado = informacoes_do_resultado;
    });
  }

  salvar_resultado() async {
    var diretorio_selecionado = await FilePicker.platform.getDirectoryPath();
    if(diretorio_selecionado == null){
      //Se cancelar a escolha do local, salvará na Área de Trabalho.
      diretorio_selecionado = (Platform.environment["USERPROFILE"] ?? "") + "\\Desktop";

      //Outra opção é simplesmente cancelar a operação usando return.
      //return;
    }
    var arquivo = File("$diretorio_selecionado/Resultado.txt");
    arquivo.writeAsString(widget.texto_do_resultado);
  }

  @override
  Widget build(BuildContext context){
    var controlador_da_barra_de_rolagem_horizontal = ScrollController();
    var controlador_da_barra_de_rolagem_vertical = ScrollController();
    var largura_da_area_de_texto = MediaQuery.of(context).size.width - widget.largura_do_menu_lateral * 2 - 40;
    if(MediaQuery.of(context).size.width < widget.largura_minima_para_mostrar_menus_laterais){
      largura_da_area_de_texto = MediaQuery.of(context).size.width - 40;
    }

    var borda_do_botao = WidgetStateProperty.resolveWith<BorderSide>(
      (Set<WidgetState> states){
        return BorderSide(
          color: Color(0xFF444490),
          width: 1.5,
          style: BorderStyle.solid
        );
      }
    );

    var espacamento_interno_do_botao = WidgetStateProperty.resolveWith<EdgeInsetsGeometry>(
      (Set<WidgetState> states){
        return EdgeInsets.only(top: 15, right: 8, bottom: 16, left: 8);
      }
    );

    var cor_de_fundo_do_botao = WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states){
        if(states.contains(WidgetState.hovered)){
          return Color(0xFF444490);
        }
        return Color(0xFFFFFFFF);
      }
    );

    var cor_do_texto_do_botao = WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states){
        if(states.contains(WidgetState.hovered)){
          return Color(0xFFFFFFFF);
        }
        return Color(0xFF444490);
      }
    );

    var borda_do_botao_de_confirmacao = WidgetStateProperty.resolveWith<BorderSide>(
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

    var espacamento_interno_do_botao_de_confirmacao = WidgetStateProperty.resolveWith<EdgeInsetsGeometry>(
      (Set<WidgetState> states){
        return EdgeInsets.only(top: 15, right: 8, bottom: 16, left: 8);
      }
    );

    var cor_de_fundo_do_botao_de_confirmacao = WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states){
        if(states.contains(WidgetState.hovered)){
          return Color(0xFF287028);
        }
        return Color(0xFF509050);
      }
    );

    var cor_do_texto_do_botao_de_confirmacao = WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states){
        return Color(0xFFFFFFFF);
      }
    );

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
                    "Digite os caminhos dos arquivos separando por quebra de linha.",
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
                          side: borda_do_botao,
                          padding: espacamento_interno_do_botao,
                          backgroundColor: cor_de_fundo_do_botao,
                          foregroundColor: cor_do_texto_do_botao,
                          alignment: Alignment.center
                        ),
                        onPressed: (){
                          selecionar_diretorio("referencia");
                        },
                        child: Text(
                          "Selecionar Diretório de Referência",
                          style: TextStyle(
                            fontSize: 16
                          )
                        )
                      ),
                      SizedBox(
                        width: 6
                      ),
                      SelectableText(
                        widget.diretorio_de_referencia,
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
                      TextButton(
                        style: ButtonStyle(
                          side: borda_do_botao,
                          padding: espacamento_interno_do_botao,
                          backgroundColor: cor_de_fundo_do_botao,
                          foregroundColor: cor_do_texto_do_botao,
                          alignment: Alignment.center
                        ),
                        onPressed: (){
                          selecionar_diretorio("destino");
                        },
                        child: Text(
                          "Selecionar Diretório de Destino",
                          style: TextStyle(
                            fontSize: 16
                          )
                        )
                      ),
                      SizedBox(
                        width: 6
                      ),
                      SelectableText(
                        widget.diretorio_de_destino,
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
                      TextButton(
                        style: ButtonStyle(
                          side: borda_do_botao_de_confirmacao,
                          padding: espacamento_interno_do_botao_de_confirmacao,
                          backgroundColor: cor_de_fundo_do_botao_de_confirmacao,
                          foregroundColor: cor_do_texto_do_botao_de_confirmacao,
                          alignment: Alignment.center
                        ),
                        onPressed: (){
                          copiar_arquivos_criando_diretorios(
                            widget.diretorio_de_referencia,
                            widget.diretorio_de_destino,
                            widget.controlador_da_area_de_texto.text
                          );
                        },
                        child: Text(
                          "Separar Arquivos",
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.informacoes_do_resultado
                  ),
                  SizedBox(
                    height: 8 //Porque pode haver uma barra de rolagem horizontal.
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
