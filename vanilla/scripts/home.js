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
            <div class="linha">Aberto em: <input type="datetime-local" value="${os.abertura.split('.')[0]}" style="max-width:195px" disabled/></div>
        `;
        if (os.encerramento == null) {
            if (os.executor !== null) {
                div.classList.add('designada');
                if (os.executor == usuario.matricula) {
                    div.innerHTML += `
                        <div class="linha"><button onclick="janelaComentario(${os.id},'encerrar')">Encerrar</button><button>Detalhes</button></div>
                    `;
                } else {
                    div.innerHTML += `
                        <div class="linha"><button onclick="janelaComentario(${os.id},'atribuir')">Atribuir a mim</button><button>Detalhes</button></div>
                    `;
                }
            } else {
                div.classList.add('nao-designada');
                div.innerHTML += `
                    <div class="linha"><button onclick="janelaComentario(${os.id},'atribuir')">Atribuir a mim</button><button>Detalhes</button></div>
                `;
            }
        } else {
            div.classList.add('encerrada');
            div.innerHTML += `
                <div class="linha">Encerrada em: <input type="datetime-local" value="${os.encerramento.split('.')[0]}" style="max-width:195px" disabled/></div>
                <div class="linha"><button>Detalhes</button></div>
            `;
        }
        container.appendChild(div);
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

function janelaComentario(id, tipo) {
    const comentario = document.getElementById('comentario');
    comentario.innerHTML = '';
    comentario.classList.remove('oculto');
    const janela = document.createElement('div');
    if (tipo == "atribuir") {
        janela.innerHTML = `
            <div class="linha"><h2>Comentário de atribuição<h2></div>
            <div class="linha"><textarea id="texto" placeholder="Digite um comentário de atribuição"></textarea></div>
        `;
    } else {
        janela.innerHTML = `
            <div class="linha"><h2>Comentário de encerramento<h2></div>
            <div class="linha"><textarea id="texto" placeholder="Digite um comentário de encerramento"></textarea></div>
        `;
    }
    janela.innerHTML += `
        <button onclick="filtrar(${id},${tipo})">Atribuir</button><button onclick="comentario.classList.add('oculto')">Cancelar</button>
    `;
    janela.className = 'janela';
    comentario.appendChild(janela);
}

function sair() {
    window.localStorage.clear();
    window.location.href = './login.html';
}