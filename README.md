# Projeto ServiFacil - Gerenciamento de OSs (Ordens de Serviço)
O sistema ServiFacil é uma aplicação **web** e **mobile** para gerenciamento de ordens de serviço, onde o usuário pode cadastrar, editar, excluir, visualizar,adicionar comentários e concluir a execução de ordens de serviço. O sistema possui a funcionalidade de autenticação, onde o usuário pode se cadastrar e fazer login.<br>O sistema possui duas interfaces diferentes, onde o usuário pode ser um **colaborador** ou um **executor**. O colaborador pode cadastrar, editar, excluir e visualizar as ordens de serviço, enquanto o executor pode visualizar as ordens de serviço, adicionar comentários e marcar como concluída, além de visualizar o histórico de ordens de serviço concluídas e um dashboard com gráficos de desempenho<br>Esta solução pode ser aplicada em pequenas empresas de prestação de serviços, como assistência técnica, manutenção de equipamentos, instalação de sistemas, entre outros.<br>Pode ser aplicada a indústrias para gerir a manutenção de máquinas e equipamentos, a empresas de instalação de sistemas de segurança, a empresas de instalação de sistemas de energia solar, entre outros.<br>Este projeto foi desenvolvido como exemplo para o componente de **Projetos** do curso **Técnico em Desenvolvimento de Sistemas** da escola **SENAI de Jaguariúna**.

## Tecnologias

|<img src="./docs/design/icone.png" width="50px">|Tecnologia|Tarefa|
|:-:|-|-|
|[<img src="https://w7.pngwing.com/pngs/717/111/png-transparent-mysql-round-logo-tech-companies-thumbnail.png" style="width:50px;">](https://www.apachefriends.org/pt_br/index.html)|XAMPP|BD MySQL MariaDB
|[<img src="https://static-00.iconduck.com/assets.00/node-js-icon-454x512-nztofx17.png" style="width:50px;">](https://nodejs.org/en)|**NodeJS**|API Back-End|
|[<img src="https://i.pinimg.com/originals/39/b2/e4/39b2e4ad77c23a2c11e5950a7dfa2aec.png" style="width:50px;">](https://www.prisma.io/)|Prisma|ORM BD MySQL|
|[<img src="https://static-00.iconduck.com/assets.00/apps-insomnia-icon-512x512-dse2p0fm.png" width="50px">](https://insomnia.rest/download)|Insomnia|Testes Unitários e de integração|
| [<img src="https://jwt.io/img/pic_logo.svg" width="50px">](https://jwt.io/)|JWT|Autenticação|
|[<img src="https://logowik.com/content/uploads/images/visual-studio-code7642.jpg" style="width:50px;">](https://code.visualstudio.com/)|**VsCode**|IDE Back, Front|
|[<img src="https://cdn-icons-png.flaticon.com/512/919/919827.png" style="width:50px">](https://developer.mozilla.org/pt-BR/docs/Web/HTML)[<img src="https://cdn-icons-png.flaticon.com/512/919/919826.png" style="width:50px">](https://developer.mozilla.org/pt-BR/docs/Web/CSS)[<img src="https://cdn5.vectorstock.com/i/1000x1000/27/74/vanilla-javascript-language-vector-31602774.jpg" style="width:50px">](https://developer.mozilla.org/pt-BR/docs/Web/JavaScript)|HTML, CSS, JS **Vanilla**|Front-End|
|[<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSg1MndL-Xp1JcnqaB0YOqTp6zDjrwYyGKsPA&s" style="width:50px">](https://react.dev/)|**React**|Front End|
|[<img src="https://axios-http.com/assets/logo.svg" style="width:100px">](https://axios-http.com/ptbr/docs/intro)|Axios|Front End consumir API|
|[<img src="https://cdn.prod.website-files.com/5ee12d8d7f840543bde883de/5ef3a1148ac97166a06253c1_flutter-logo-white-inset.svg" style="width:50px">](https://flutter.dev/)|**Flutter**|Framework Mobile com linguagem Dart|
|[<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJU_1vS1TGPCrGIrnly55uflMlC6tTNxkdjA&s" style="width:50px">](https://developer.android.com/studio?hl=pt-br)|**Android Studio**|IDE Mobile para utilizar Emulador|

## Passos para a Execução da API
- 1 Clonar este repositório
- 2 Abrir com o **VsCode**
- 3 Na pasta ./api criar um arquivo **.env** contendo: 
```js
DATABASE_URL="mysql://root@localhost:3306/oss?schema=public&timezone=UTC"
KEY="base64:q3
```
- 4 Abrir XAMPP  e clicar em Start nos serviços **Mysql** e **Apache**.
- 5 Instalar as dependências e o banco de dados, no **VsCode**, abra um terminal **CTRL + '** e digite os seguintes comandos:
```bash
cd api 
npm i
npx prisma migrate dev --name init
```
- 6 Preencher o banco de dados com dados de teste, copiando os dados do arquivo **./docs/dados.sql** e colando no **phpMyAdmin** ou terminal MySQL.
```bash
mysql -u root
```
- 7 Exercutar a API
```bash
npx nodemon
```
- 8 Para testar com Insomnia, importar o arquivo **./docs/testes/Insomnia.json**.

## Execução do Front-End - Vanilla
- 1 Acessar a pasta ./vanilla e executar o arquivo **index.html** com **live server** (Extensão do VsCode) ou **Open with Live Server**.
## Execução do Front-End - React
- 1 Abrir a pasta ./react com VsCode
- 2 Abrir um **terminal** cmd ou bash e executar os comandos a seguir:
```bash
cd react
npm i
npm start
```
- **Obs**: Versão com React em desenvolvimento, poucas funcionalidades implementadas.

## Versão Mobile em flutter
- 1 Instalar o **Flutter** e o **Android Studio** com o **Emulador** ([Tutorial](https://github.com/wellifabio/cursoflutter/tree/main/aula01)).
- 2 Abrir o Android Studio, criar e abrir um **Emulador** de celular.
- 3 Escolha uma das versões do app na pasta flutter (**serv_facil_colaborador** ou **serv_facil_executor**) e abra com o Vscode.
- 4 Abra um terminal bash ou cmd e digite:
```bash
flutter pub get
```
- 5 Selecione um emulador.
![Imagem-Exemplo](./flutter/readme-images/exemplo.png)
- 6 Na aba de debug do vscode, clique em Run and Debug
- 7 No arquivo constant.dart dentro de /lib, edite o ip para corresponder ao do seu computador.
![Imagem-Exemplo](./flutter/readme-images/exemplo-constant.png)

## Wireframe e Protótipo
![Wireframe](./docs/design/wireframe2.png)
![Protótipo](./docs/design/prototipo.png)
![Protótipo Web](./docs/design/prototipo-web.png)
- [Arquivo Figma](./docs/design/ServiFacil.fig)
- [Weireframe WEB em PDF](./docs/design/ServiFacil-WEB.pdf)
