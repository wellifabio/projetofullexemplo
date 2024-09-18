const uri = "http://localhost:3000"
const usuario = JSON.parse(window.localStorage.getItem('usuario'));
const container = document.querySelector('.container');
const m = document.querySelector('.msg');
const oss = [];
const colaboradores = [];
const executores = [];

const api = axios.create({
    baseURL: uri
});

//Iniciar tela da página Home
async function iniciar() {
    if (!usuario) {
        window.location.href = './login.html';
    } else {
        if (usuario.setor == 'Manutenção')
            document.getElementById('bt1').classList.remove('oculto');
        m.innerHTML = `Olá, ${usuario.nome}`;
        await preencherColaboradores();
        await preencherOss();
        await exibirOss();
        console.table(usuario.oss);
        console.table(colaboradores);
    }
}

//Iniciar tela da página Produção
async function iniciarProducao() {
    if (!usuario) {
        window.location.href = './login.html';
    } else {
        m.innerHTML = `Olá, ${usuario.nome}`;
        await preencherColaboradores();
        await preencherOssProducao();
        await exibirOss();
    }
}

//Iniciar tela da página Dashboard
async function iniciarDashboard() {
    if (!usuario) {
        window.location.href = './login.html';
    } else {
        m.innerHTML = `Olá, ${usuario.nome}`;
        await preencherColaboradores();
        executores.push(...colaboradores.filter(c => c.setor == "Manutenção"));
        await preencherOssFechadas();
        await exibirTabela();
        await exibirGraficoColaborador();
        await exibirGraficoOSs();
        preencherSelectExecutores();
        await exibirCartoes();
    }
}

//Função para exebir mensagens do sistema no rodapé da página
//UX - Mensagens via Toast ou Alert são muito agressivas, o usuário pode preferir mensagens discretas no rodapé
async function msg(mensagem, destaque) {
    m.innerHTML = mensagem;
    if (destaque == undefined) {
        setTimeout(() => {
            m.innerHTML = `Olá, ${usuario.nome}`;
        }, 3000);
    } else {
        m.style.color = 'darkred';
        setTimeout(() => {
            m.innerHTML = `Olá, ${usuario.nome}`;
            m.style.color = '';
        }, 3000);
    }
}

//Função para preencher a lista de colaboradores
async function preencherColaboradores() {
    const options = {
        headers: {
            Authorization: usuario.token
        }
    };
    await api.get('/colaborador', options)
        .then(res => {
            colaboradores.push(...res.data);
        })
        .catch(err => {
            if (err.response.data.name = 'TokenExpiredError')
                sair();
            else
                msg(err.response.data.name);
        });
}

//Função para preencher a lista de ordens de serviço na tela Home
async function preencherOss() {
    const options = {
        headers: {
            Authorization: usuario.token
        }
    };
    //Rota de acordo com o setor do usuário se for Manutenção exibe todas as ordens de serviço abertas senão exibe somente as ordens de serviço do colaborador
    const rota = usuario.setor == 'Manutenção' ? `/os/abertas` : `/os/colaborador/${usuario.matricula}`;
    await api.get(rota, options)
        .then(res => {
            oss.push(...res.data);
        })
        .catch(err => {
            if (err.response.data.name = 'TokenExpiredError')
                sair();
            else
                msg(err.response.data.name);
        });
}

//Função para preencher a lista de ordens de serviço em produção
async function preencherOssProducao() {
    oss.splice(0, oss.length);
    const options = {
        headers: {
            Authorization: usuario.token
        }
    };
    await api.get(`/os/executor/${usuario.matricula}`, options)
        .then(res => {
            oss.push(...res.data);
        })
        .catch(err => {
            if (err.response.data.name = 'TokenExpiredError')
                sair();
            else
                msg(err.response.data.name);
        });
}

//Função para preencher a lista de ordens de serviço fechadas no Dashboard
async function preencherOssFechadas() {
    oss.splice(0, oss.length);
    const options = {
        headers: {
            Authorization: usuario.token
        }
    };
    await api.get(`/os/fechadas`, options)
        .then(res => {
            oss.push(...res.data);
        })
        .catch(err => {
            if (err.response.data.name = 'TokenExpiredError')
                sair();
            else
                msg(err.response.data.name);
        });
}

//Função para preencher o select (filtro) de executores no Dashboard
function preencherSelectExecutores() {
    const select = document.getElementById('executores');
    executores.forEach(e => {
        const option = document.createElement('option');
        option.value = e.matricula;
        option.innerHTML = e.nome;
        select.appendChild(option);
    });
}

//Função para filtrar as ordens de serviço por data na tela Produção
async function filtrarDataProducao(e) {
    await preencherOssProducao();
    const filtradas = [];
    oss.forEach(os => {
        if (new Date(os.encerramento) > new Date(e.value)) {
            filtradas.push(os);
        }
    });
    oss.splice(0, oss.length);
    oss.push(...filtradas);
    await exibirOss();
}

//Função para filtrar as ordens de serviço por data no Dashboard
async function filtrarDataDashboard(e) {
    await preencherOssFechadas();
    const filtradas = [];
    oss.forEach(os => {
        if (new Date(os.encerramento) > new Date(e.value)) {
            filtradas.push(os);
        }
    });
    oss.splice(0, oss.length);
    oss.push(...filtradas);
    await exibirGraficoColaborador();
    await exibirGraficoOSs();
    await exibirTabela();
    await exibirCartoes();
}

//Função para filtrar as ordens de serviço por Executor no Dashboard
async function filtrarExecutorDashboard(e) {
    await preencherOssFechadas();
    const filtradas = [];
    oss.forEach(os => {
        if (os.executor == e.value) {
            filtradas.push(os);
        }
    });
    oss.splice(0, oss.length);
    oss.push(...filtradas);
    await exibirGraficoColaborador();
    await exibirGraficoOSs();
    await exibirTabela();
    await exibirCartoes();
}

//Função para exibir as ordens de serviço na tela Home
async function exibirOss() {
    container.innerHTML = '';
    oss.forEach(os => {
        const div = document.createElement('div');
        div.className = 'os';
        div.innerHTML = `
            <div class="linha"><h3>Ordem de serviço Id:</h3><h3>${os.id}</h3></div>
            <div class="linha"><h4>${os.descricao}</h4></div>
            <div class="linha"><p>Colaborador:</p><p>${colaboradores.find(c => c.matricula == os.colaborador).nome}</p></div>
            <div class="linha">
                <p>Executor:</p><p>${os.executor ? colaboradores.find(c => c.matricula == os.executor).nome : 'Não designado'}</p></div>            
            <div class="linha"><p>Aberto em:</p><p>${new Date(os.abertura).toLocaleString('pt-BR')}</p></div>
        `;
        if (os.encerramento == null) {
            if (usuario.setor == 'Manutenção') {
                if (os.executor !== null) {
                    div.classList.add('designada');
                    if (os.executor == usuario.matricula) {
                        div.innerHTML += `
                        <div class="linhaBotao"><button onclick="janelaComentario(${os.id},'encerrar')">Encerrar</button><button onclick="janelaOs(${os.id})">Detalhes</button></div>
                    `;
                    } else {
                        div.innerHTML += `
                        <div class="linhaBotao"><button onclick="janelaComentario(${os.id},'atribuir')">Atribuir a mim</button><button onclick="janelaOs(${os.id})">Detalhes</button></div>
                    `;
                    }
                } else {
                    div.classList.add('nao-designada');
                    div.innerHTML += `
                    <div class="linhaBotao"><button onclick="janelaComentario(${os.id},'atribuir')">Atribuir a mim</button><button onclick="janelaOs(${os.id})">Detalhes</button></div>
                `;
                }
            } else {
                if (os.executor !== null) div.classList.add('designada');
                else div.classList.add('nao-designada');
                div.innerHTML += `<div class="linhaBotao"><button onclick="janelaOs(${os.id})">Detalhes</button></div>`;
            }
        } else {
            div.classList.add('encerrada');
            div.innerHTML += `
                <div class="linha"><p>Encerrada em:</p><p>${new Date(os.encerramento).toLocaleString('pt-BR')}</p></div>
                <div class="linhaBotao"><button onclick="janelaOs(${os.id})">Detalhes</button></div>
            `;
        }
        container.appendChild(div);
    });
}

//Função para exibir as ordens de serviço no Dashboard
async function exibirTabela() {
    const div = document.querySelector('.dash-tabela');
    div.innerHTML = '';
    const table = document.createElement('table');
    const thead = document.createElement('thead');
    const tbody = document.createElement('tbody');
    thead.innerHTML = `
            <tr>
                <th>Id</th>
                <th>Colaborador</th>
                <th>Executor</th>
                <th>Abertura</th>
                <th>Encerramento</th>
            </tr>
    `;
    oss.forEach(os => {
        tbody.innerHTML += `
            <tr>
                <td data-label="Id">${os.id}</td>
                <td data-label="Colaborador">${colaboradores.find(c => c.matricula == os.colaborador).nome}</td>
                <td data-label="Executor">${os.executor ? colaboradores.find(c => c.matricula == os.executor).nome : 'Não designado'}</td>
                <td data-label="Abertura">${new Date(os.abertura).toLocaleDateString('pt-BR')}</td>
                <td data-label="Encerramento">${os.encerramento ? new Date(os.encerramento).toLocaleDateString('pt-BR') : 'Não encerrada'}</td>
            </tr>
        `;
    });
    table.appendChild(thead);
    table.appendChild(tbody);
    div.appendChild(table);
}

//Função para exibir o gráfico de ordens de serviço por colaborador no Dashboard
async function exibirGraficoColaborador() {
    const div = document.querySelector('.pie-graph');
    div.innerHTML = '';
    const h2 = document.createElement('h2');
    h2.innerHTML = 'OSs executadas por colaborador';
    div.appendChild(h2);
    const canvas = document.createElement('canvas');
    const ctx = canvas.getContext('2d');

    //Dados
    const executadas = [];
    executores.forEach(e => {
        executadas.push(oss.filter(o => o.executor == e.matricula).length);
    });

    //Gráfico
    const dados = {
        labels: executores.map(c => c.nome),
        datasets: [{
            label: 'Executadas',
            data: executadas,
            backgroundColor: ['#000000', '#233c4c', '#32698f', '#1a9f8e', "#ffffff"],
        }]
    };
    Chart.defaults.plugins.legend.display = true;
    const config = {
        type: 'pie',
        data: dados,
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    };
    new Chart(ctx, config);
    div.appendChild(canvas);
}

//Função para exibir o gráfico de ordens de serviço por período no Dashboard
async function exibirGraficoOSs() {
    const div = document.querySelector('.bar-graph');
    div.innerHTML = '';
    const h2 = document.createElement('h2');
    h2.innerHTML = 'OSs executadas por período';
    div.appendChild(h2);
    const canvas = document.createElement('canvas');
    const ctx = canvas.getContext('2d');

    //Agrupar as executadas nos ultimos 7 dias
    const dias = [];
    for (let i = 0; i < 7; i++) {
        const data = new Date();
        data.setDate(data.getDate() - i);
        dias.push({ encerramento: data.toLocaleDateString('pt-BR') });
    }
    const executadas = [];
    dias.forEach(d => {
        executadas.push(oss.filter(o => new Date(o.encerramento).toLocaleDateString('pt-BR') == d.encerramento).length);
    });
    //Gráfico
    const dados = {
        labels: dias.map(c => c.encerramento),
        datasets: [{
            label: 'Executadas',
            data: executadas,
            backgroundColor: '#1a9f8e',
        }]
    };
    Chart.defaults.plugins.legend.display = true;
    const config = {
        type: 'bar',
        data: dados,
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    };
    new Chart(ctx, config);
    div.appendChild(canvas);
}

//Estatísticas, total de OSs encerradas
async function totalOSsEncerradas() {
    const total = oss.filter(o => o.encerramento !== null).length;
    return total;
}

//Estatísticas, tempo médio de execução das OSs
async function tempoMedioExecucao() {
    const total = oss.filter(o => o.encerramento !== null).length;
    let tempo = 0;
    oss.forEach(o => {
        if (o.encerramento !== null) {
            tempo += new Date(new Date(o.encerramento) - new Date(o.abertura)).getDate();
        }
    });
    tempo -= 1;
    return (tempo / total).toFixed(1) + ' dias';
}

//Estado do sistema, Os com maior tempo de execução
async function maiorTempoExecucao() {
    let maior = oss[0];
    oss.forEach(o => {
        if (o.encerramento !== null) {
            if (new Date(o.encerramento) - new Date(o.abertura) > new Date(maior.encerramento) - new Date(maior.abertura)) {
                maior = o;
            }
        }
    });
    return maior;
}

//Estado do sistema, Os com menor tempo de execução
async function menorTempoExecucao() {
    let menor = oss[0];
    oss.forEach(o => {
        if (o.encerramento !== null) {
            if (new Date(o.encerramento) - new Date(o.abertura) < new Date(menor.encerramento) - new Date(menor.abertura)) {
                menor = o;
            }
        }
    });
    return menor;
}

//Exibir Cartões com estatísticas do sistema
async function exibirCartoes() {
    const card1 = document.getElementById('card1');
    card1.innerHTML = `
        <h2>Total de OSs encerradas</h2>
        <h3>${await totalOSsEncerradas()}</h3>
    `;
    const card2 = document.getElementById('card2');
    card2.innerHTML = `
        <h2>Tempo médio de execução</h2>
        <h3>${await tempoMedioExecucao()}</h3>
    `;
    const card3 = document.getElementById('card3');
    const maior = await maiorTempoExecucao();
    card3.innerHTML = `
        <h2>OS com maior tempo de execução</h2>
        <h3>${diferencaTempo(maior.encerramento, maior.abertura)}</h3>
        <h2>Os Id: ${maior.id}</h2>
    `;
    const card4 = document.getElementById('card4');
    const menor = await menorTempoExecucao();
    card4.innerHTML = `
        <h2>OS com menor tempo de execução</h2>
        <h3>${diferencaTempo(menor.encerramento, menor.abertura)}</h3>
        <h2>Os Id: ${menor.id}</h2>
    `;
}

//Função que retorna diferença de tempo
function diferencaTempo(data1, data2) {
    if(new Date(data1).getDate() - new Date(data2).getDate() > 0)
        return `${new Date(data1).getDate() - new Date(data2).getDate()} dias`;
    else if(new Date(data1).getHours() - new Date(data2).getHours() > 0)
        return `${new Date(data1).getHours() - new Date(data2).getHours()} horas`;
    else
        return `${new Date(data1).getMinutes() - new Date(data2).getMinutes()} minutos`;
}

//Função para exibir a janela (modal) de detalhes ordem de serviço
async function janelaOs(id) {
    const os = document.getElementById('os');
    os.classList.remove('oculto');
    os.innerHTML = '';
    const janela = document.createElement('div');
    //Se o id for diferente de undefined exibe os detalhes da ordem de serviço senão exibe o formulário para criar uma nova ordem de serviço
    if (id !== undefined) {
        let index = oss.findIndex(o => o.id == id);
        //Se a ordem de serviço estiver encerrada exibe somente a descrição
        if (oss[index].encerramento !== null) {
            janela.innerHTML = `
                <div class="linha"><h2>Ordem de serviço<h2><h2>${oss[index].id}</h2></div>
                <div class="linha"><textarea id="descricao" disabled>${oss[index].descricao}</textarea></div>
            `;
        } else {
            janela.innerHTML = `
                <div class="linha"><h2>Ordem de serviço<h2><h2>${oss[index].id}</h2></div>
            `;
            //Se a ordem de serviço aberta for do próprio colaborador exibe a descrição e os botões para alterar e excluir
            if (oss[index].colaborador == usuario.matricula) {
                janela.innerHTML += `
                    <div class="linha"><textarea id="descricao" placeholder="Digite a descrição da ordem de serviço">${oss[index].descricao}</textarea></div>
                    <button onclick="alterarOs(${id},descricao)">Alterar</button><button onclick="excluirOs(${id})">Excluir</button>
                `;
            } else {
                //Se a ordem de serviço aberta for de outro colaborador exibe somente a descrição
                janela.innerHTML += `
                    <div class="linha"><textarea id="descricao" disabled>${oss[index].descricao}</textarea></div>
                `;
            }
            //Todos podem comentar as ordens de serviço abertas, executores e colaboradores
            janela.innerHTML += `
                <button onclick="janelaComentario(${id})">Comentar</button>
            `;
        }
        //Exibe os comentários da ordem de serviço
        let tab = await listarComentarios(id);
        janela.innerHTML += `<div class="comentarios">${tab}</div>`;
    } else {
        janela.innerHTML = `
            <div class="linha"><h2>Nova Ordem de Serviço<h2></div>
            <div class="linha"><textarea id="descricao" placeholder="Digite a descrição da ordem de serviço"></textarea></div>
            <button onclick="criarOs(descricao)">Criar</button>
        `;
    }
    janela.innerHTML += `<button onclick="os.classList.add('oculto')">Cancelar</button>`;
    janela.className = 'janela';
    os.appendChild(janela);
}

//Função para exibir a janela (modal) de comentários
function janelaComentario(id, tipo) {
    const comentario = document.getElementById('comentario');
    comentario.classList.remove('oculto');
    comentario.innerHTML = '';
    const janela = document.createElement('div');
    //Se o tipo não for definido exibe o formulário para comentar senão exibe o formulário para atribuir ou encerrar a ordem de serviço
    if (tipo !== undefined) {
        if (tipo == "atribuir") {
            janela.innerHTML = `
            <div class="linha"><h2>Comentário de atribuição<h2></div>
            <div class="linha"><textarea id="texto" placeholder="Digite um comentário de atribuição"></textarea></div>
            <button onclick="comentar(${id}, texto, '${tipo}')">Atribuir</button>
        `;
        } else {
            janela.innerHTML = `
            <div class="linha"><h2>Comentário de encerramento<h2></div>
            <div class="linha"><textarea id="texto" placeholder="Digite um comentário de encerramento"></textarea></div>
            <button onclick="comentar(${id}, texto, '${tipo}')">Encerrar</button>
        `;
        }
    } else {
        janela.innerHTML = `
            <div class="linha"><h2>Comentário<h2></div>
            <div class="linha"><textarea id="texto" placeholder="Digite um comentário"></textarea></div>
            <button onclick="comentar(${id}, texto)">Comentar</button>
        `;
    }
    janela.innerHTML += `<button onclick="comentario.classList.add('oculto')">Cancelar</button>`;
    janela.className = 'janela';
    comentario.appendChild(janela);
}

//Função para listar os comentários da ordem de serviço
async function listarComentarios(id) {
    let tabela = '<table>';
    options = {
        headers: {
            Authorization: usuario.token
        }
    };
    await api.get(`/comentario/${id}`, options)
        .then(res => {
            tabela += `
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Colaborador</th>
                    <th>Comentário</th>
                    <th>Data</th>
                </tr>
            </thead>
            <tbody>`;
            res.data[0].comentarios.forEach(c => {
                tabela += `
                <tr>
                    <td data-label="Id">${c.id}</td>
                    <td data-label="Colaborador">${colaboradores.find(co => co.matricula == c.colaborador).nome}</td>
                    <td>${c.comentario}</td>
                    <td data-label="Data">${new Date(c.data).toLocaleString('pt-BR')}</td>
                </tr>`;
            });
            tabela += `
            </tbody>
            </table>`;
            return tabela;
        })
        .catch(err => {
            if (err.response.data.name = 'TokenExpiredError')
                sair();
            else
                msg(err.response.data.name, true);
        });
    return tabela;
}

//Função para comentar a ordem de serviço enviando os dados para a API
function comentar(id, texto, tipo) {
    if (texto.value == '') {
        msg('Digite um comentário', true);
        return;
    } else {
        const dados = {
            os: id,
            colaborador: usuario.matricula,
            comentario: texto.value
        }
        const options = {
            headers: {
                Authorization: usuario.token
            }
        };
        api.post(`/comentario`, dados, options)
            .then(res => {
                msg("Comentário adicionado com sucesso");
            })
            .then(() => {
                if (tipo !== undefined) {
                    if (tipo == 'atribuir') atribuir(id);
                    else encerrar(id);
                } else {
                    window.location.reload();
                }
            })
            .catch(err => {
                if (err.response.data.name = 'TokenExpiredError')
                    sair();
                else
                    msg(err.response.data.name, true);
            });
    }
}

//Função para criar uma nova ordem de serviço enviando os dados para a API
function criarOs(descricao) {
    if (descricao.value == '') {
        msg('Digite uma descrição', true);
        return;
    } else {
        const dados = {
            descricao: descricao.value,
            colaborador: usuario.matricula
        }
        const options = {
            headers: {
                Authorization: usuario.token
            }
        };
        api.post(`/os`, dados, options)
            .then(res => {
                window.location.reload();
            })
            .catch(err => {
                if (err.response.data.name = 'TokenExpiredError')
                    sair();
                else
                    msg(err.response.data.name, true);
            });
    }
}

//Função para alterar a ordem de serviço enviando os dados para a API
function alterarOs(id, descricao) {
    if (descricao.value == '') {
        msg('Digite uma descrição', true);
        return;
    } else {
        const dados = {
            id: id,
            descricao: descricao.value
        }
        const options = {
            headers: {
                Authorization: usuario.token
            }
        };
        api.patch(`/os`, dados, options)
            .then(res => {
                window.location.reload();
            })
            .catch(err => {
                if (err.response.data.name = 'TokenExpiredError')
                    sair();
                else
                    msg(err.response.data.name, true);
            });
    }
}

//Função para excluir a ordem de serviço enviando os dados para a API
function excluirOs(id) {
    const options = {
        headers: {
            Authorization: usuario.token
        }
    };
    api.delete(`/os/${id}`, options)
        .then(res => {
            window.location.reload();
        })
        .catch(err => {
            if (err.response.data.name = 'TokenExpiredError')
                sair();
            else
                msg(err.response.data.name, true);
        });
}

//Função para atribuir a ordem de serviço enviando os dados para a API
function atribuir(id) {
    const dados = {
        id: id,
        executor: usuario.matricula
    }
    const options = {
        headers: {
            Authorization: usuario.token
        }
    };
    api.patch(`/os`, dados, options)
        .then(res => {
            window.location.reload();
        })
        .catch(err => {
            if (err.response.data.name = 'TokenExpiredError')
                sair();
            else
                msg(err.response.data.name, true);
        });
}

//Função para encerrar a ordem de serviço enviando os dados para a API
function encerrar(id) {
    const dados = {
        id: id,
        encerramento: new Date().toISOString()
    }
    const options = {
        headers: {
            Authorization: usuario.token
        }
    };
    api.patch(`/os`, dados, options)
        .then(res => {
            window.location.reload();
        })
        .catch(err => {
            if (err.response.data.name = 'TokenExpiredError')
                sair();
            else
                msg(err.response.data.name, true);
        });
}

//Função para fazer logout do sistema
function sair() {
    window.localStorage.clear();
    window.location.href = './login.html';
}

//Função para exibir o menu sandwish
//UI - Menu sandwish é uma boa opção para dispositivos móveis
function sandwish() {
    const menu = document.getElementById('menu1');
    if (menu.style.display == 'flex') {
        menu.style.display = 'none';
    } else {
        menu.style.display = 'flex';
    }
}