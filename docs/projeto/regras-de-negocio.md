# Regras de negócio, requisitos funcionais e não funcionais

## Resumo
O sistema ServiFacil é uma aplicação **web** e **mobile** para gerenciamento de ordens de serviço, onde o usuário pode cadastrar, editar, excluir, visualizar,adicionar comentários e concluir a execução de ordens de serviço. O sistema possui a funcionalidade de autenticação, onde o usuário pode se cadastrar e fazer login.<br>O sistema possui duas interfaces diferentes, onde o usuário pode ser um **colaborador** ou um **executor**. O colaborador pode cadastrar, editar, excluir e visualizar as ordens de serviço, enquanto o executor pode visualizar as ordens de serviço, adicionar comentários e marcar como concluída, além de visualizar o histórico de ordens de serviço concluídas e um dashboard com gráficos de desempenho<br>Esta solução pode ser aplicada em pequenas empresas de prestação de serviços, como assistência técnica, manutenção de equipamentos, instalação de sistemas, entre outros.<br>Pode ser aplicada a indústrias para gerir a manutenção de máquinas e equipamentos, a empresas de instalação de sistemas de segurança, a empresas de instalação de sistemas de energia solar, entre outros.<br>Este projeto foi desenvolvido como exemplo para o componente de **Projetos** do curso **Técnico em Desenvolvimento de Sistemas** da escola **SENAI de Jaguariúna**.

## Regras de negócio
As regras de negócio do sistema ServiFacil foram obtidas com base em pesquisas de mercado realizadas através da internet, observação direta da atuação dos colaboradores da manutenção da escola, entrevista com professores e funcionários.
Estão elencadas a seguir de forma ordenada a partir da sigla RN (Regra de Negócio) seguida da ordem do requisito, conforme exemplo a seguir: [RN001]

- [RN001] - Para a utilização do sistema o funcionário, também chamado de colaborador, pois pode ser terceiro a empresa, precisa fazer um cadastro, tendo como identificador sua matrícula e um PIN (Senha numérica simples) além dos campos nome completo, cargo e setor.

- [RN002] - Ao realizar seu cadastro se o colaborador preencher o cargo como "Manutenção" ele será considerado um executor, caso contrário será considerado um colaborador.

- [RN003] - O executor pode visualizar as ordens de serviço, adicionar comentários e marcar como concluída, além de visualizar o histórico de ordens de serviço concluídas e um dashboard com gráficos de desempenho.

- [RN004] - O colaborador pode cadastrar, editar, excluir e visualizar as suas próprias ordens de serviço.

- [RN005] - Enquanto a ordem de serviço estiver em aberto, o colaborador pode editar, excluir e adicionar comentários. somente o executor pode marcar como concluída.

- [RN006] - Caso a ordem de serviço seja marcada como concluída, o colaborador não poderá mais editar, excluir ou adicionar comentários, somente visualizar no seu histórico, com cor diferente das ordens em aberto.

- [RN007] - Tanto o colaborador quanto o executor podem abrir novas ordens de serviço, que serão consideradas em aberto.

- [RN008] - O sistema na versão Web ao gerar novas ordens de serviço, deve posicionar a latitude e longitude do local da escola, para que o executor possa visualizar no mapa.

- [RN009] - O sistema na versão Mobile deve utilizar a geolocalização do dispositivo para posicionar a latitude e longitude do local da ocorrência, para que o executor possa visualizar no mapa.

- [RN010] - O sistema utilizará um SGBD free, como o MySQL, MariaDB e será dividido em API, Front-End e Mobile.

- [RN011] - O sistema Web deve ser responsivo, funcionando em dispositivos móveis e desktop.

- [RN012] - A API Back-End deve ser desenvolvida em NodeJS, utilizando o ORM Prisma para o banco de dados e autenticação JWT.

- [RN013] - O Front-End Web deve ser desenvolvido com HTML, CSS e JavaScript Vanilla ou React, consumindo a API Back-End.

- [RN014] - O sistema Mobile deve ser desenvolvido em Flutter, consumindo a API Back-End, em duas versões, uma para o colaborador e outra para o executor.

- [RN015] - A versão mobile do colaborador deve permitir cadastro, login e apenas abrir novas ordens de serviço e visualizar o histórico.

- [RN016] - A versão mobile do executor deve permitir cadastro, login, visualizar as ordens de serviço abertas e sua localização no mapa, adicionar comentários e marcar como concluída, além de visualizar o histórico de ordens de serviço concluídas.

- [RN017] - O sistema deve ser desenvolvido em português, com documentação clara e objetiva também em português seguindo as normas da ABNT.

