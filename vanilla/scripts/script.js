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
        await preencherSelectExecutores();
    }
}

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

async function preencherOss() {
    const options = {
        headers: {
            Authorization: usuario.token
        }
    };
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

function preencherSelectExecutores() {
    const select = document.getElementById('executores');
    executores.forEach(e => {
        const option = document.createElement('option');
        option.value = e.matricula;
        option.innerHTML = e.nome;
        select.appendChild(option);
    });
}

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
    await exibirTabela();
    await exibirGraficoColaborador();
    await exibirGraficoOSs();
}

async function filtrarExecutorDashboard(e){
    await preencherOssFechadas();
    const filtradas = [];
    oss.forEach(os => {
        if (os.executor == e.value) {
            filtradas.push(os);
        }
    });
    oss.splice(0, oss.length);
    oss.push(...filtradas);
    await exibirTabela();
    await exibirGraficoColaborador();
    await exibirGraficoOSs();
}

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

async function exibirGraficoOSs() {
    const div = document.querySelector('.bar-graph');
    div.innerHTML = '';
    const h2 = document.createElement('h2');
    h2.innerHTML = 'OSs executadas por período';
    div.appendChild(h2);
    const canvas = document.createElement('canvas');
    const ctx = canvas.getContext('2d');

    //Dados
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

async function janelaOs(id) {
    const os = document.getElementById('os');
    os.classList.remove('oculto');
    os.innerHTML = '';
    const janela = document.createElement('div');
    if (id !== undefined) {
        let index = oss.findIndex(o => o.id == id);
        if (oss[index].encerramento !== null) {
            janela.innerHTML = `
                <div class="linha"><h2>Ordem de serviço<h2><h2>${oss[index].id}</h2></div>
                <div class="linha"><textarea id="descricao" disabled>${oss[index].descricao}</textarea></div>
            `;
        } else {
            janela.innerHTML = `
                <div class="linha"><h2>Ordem de serviço<h2><h2>${oss[index].id}</h2></div>
            `;
            if (oss[index].colaborador == usuario.matricula) {
                janela.innerHTML += `
                    <div class="linha"><textarea id="descricao" placeholder="Digite a descrição da ordem de serviço">${oss[index].descricao}</textarea></div>
                    <button onclick="alterarOs(${id},descricao)">Alterar</button><button onclick="excluirOs(${id})">Excluir</button>
                `;
            } else {
                janela.innerHTML += `
                    <div class="linha"><textarea id="descricao" disabled>${oss[index].descricao}</textarea></div>
                `;
            }
            janela.innerHTML += `
                <button onclick="janelaComentario(${id})">Comentar</button>
            `;
        }
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

function janelaComentario(id, tipo) {
    const comentario = document.getElementById('comentario');
    comentario.classList.remove('oculto');
    comentario.innerHTML = '';
    const janela = document.createElement('div');
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

function sair() {
    window.localStorage.clear();
    window.location.href = './login.html';
}

function sandwish() {
    const menu = document.getElementById('menu1');
    if (menu.style.display == 'flex') {
        menu.style.display = 'none';
    } else {
        menu.style.display = 'flex';
    }
}