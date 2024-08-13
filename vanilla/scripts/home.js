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
        console.log(usuario);
        console.log(colaboradores);
        console.log(oss);
    }
}

function msg(mensagem, destaque) {
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
            <h3>OS ${os.id}</h3>
            <p>Descrição: ${os.descricao}</p>
            <p>Colaborador: ${colaboradores.find(c => c.matricula == os.colaborador).nome}</p>
            <p>Executor: ${os.executor?colaboradores.find(c => c.matricula == os.executor).nome:'Não designado'}</p>
            <p>Abertura: <input type="datetime-local" value="${os.abertura.split(".")[0]}"></p>
        `;
        container.appendChild(div);
    });
}

function sair() {
    window.localStorage.clear();
    window.location.href = './login.html';
}