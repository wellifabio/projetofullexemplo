const uri = "http://localhost:3000"
const usuario = JSON.parse(window.localStorage.getItem('usuario'));
const container = document.querySelector('.container');
const m = document.querySelector('.msg');
const oss = [];
const colaboradores = [];

const api = axios.create({
    baseURL: uri
});

async function iniciar() {
    if (!usuario) {
        window.location.href = './login.html';
    } else {
        m.innerHTML = `Olá, ${usuario.nome}`;
        await preencherColaboradores();
        await preencherOss();
        await exibirOss();
        console.table(usuario.oss);
        console.table(colaboradores);
    }
}

async function msg(mensagem, destaque) {
    m.innerHTML = mensagem;
    if (destaque == undefined) {
        await setTimeout(() => {
            m.innerHTML = `Olá, ${usuario.nome}`;
        }, 3000);
    } else {
        m.style.color = 'darkred';
        await setTimeout(() => {
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
    await api.get(`/os/${usuario.matricula}`, options)
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
                <div class="linha">Encerrada em: ${new Date(os.encerramento).toLocaleString('pt-BR')}</div>
                <div class="linhaBotao"><button onclick="janelaOs(${os.id})">Detalhes</button></div>
            `;
        }
        container.appendChild(div);
    });
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