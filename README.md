## Sobre
<p>Este sistema é um programa que fiz com Dart e Flutter para sistemas operacionais Windows.</p>

<p>Estou implementando, neste sistema, ferramentas úteis que facilitarão meu dia a dia de programador.</p>

<p>Este sistema foi feito por mim, mas qualquer pessoa é livre para reutilizar e/ou modificar.</p>

<br/>

## Instruções
<p>Para ver o resultado em um ambiente de desenvolvimento siga as instruções:</p>

<p>Baixe o arquivo zip do Flutter, flutter_windows_3.35.1-stable.zip, pelo site do Flutter:<br/>
https://docs.flutter.dev/install/archive</p>

<p>Utilize o comando abaixo pelo Windows PowerShell<br/>
(o PATH tem que ser o caminho para o arquivo zip baixado)<br/>
(o DESTINATION tem que ser onde você quer que seja criada a pasta flutter):<br/>
Expand-Archive -Path 'PATH' -Destination 'DESTINATION'</p>

<p>Crie uma variável de ambiente com o caminho da pasta bin da pasta flutter.</p>

<p>Feche todas as janelas de terminal que estiverem abertas.</p>

<p>Para verificar se o Flutter foi instalado com sucesso, abra uma janela de terminal e utilize os comandos:<br/>
flutter --version<br/>
dart --version</p>

<p>Para criar o executável do Flutter para Windows, utilize o comando abaixo dentro do diretório ferramentas_do_programador:<br/>
flutter build windows --release<br/>
Caso funcione, deverá aparecer no terminal:<br/>
Built build\windows\x64\runner\Release\ferramentas_do_programador.exe</p>

<p>Para ver o resultado (usar o programa) em ambiente de desenvolvimento, utilize o comando abaixo dentro do diretório ferramentas_do_programador:<br/>
flutter run<br/>
Quando aparecer "Please choose one (or 'q' to quit):"<br/>
Digite 1 para escolher Windows.<br/>
Caso funcione, a janela do programa Ferramentas do Programador vai abrir e deverá aparecer no terminal:<br/>
Built build\windows\x64\runner\Debug\ferramentas_do_programador.exe</p>

<br/>
