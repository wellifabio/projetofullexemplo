const uri = "http://localhost:3000"
const usuario = JSON.parse(window.localStorage.getItem('usuario'));
const login = document.getElementById('login');
const cadastro = document.getElementById('cadastro');
const bt1 = document.getElementById('bt1');

var bt1Status = true;

// Configuração do Axios
const api = axios.create({
    baseURL: uri
});

// Função para exibir mensagens no rodapé da página
//UX - User Experience, exibir menságens de erro ou sucesso por Alert é muito agressivo
//por isso optei por exibir as mensagens no rodapé da página
function msg(mensagem, destaque) {
    const m = document.querySelector('.msg');
    m.innerHTML = mensagem;
    if (destaque == undefined) {
        setTimeout(() => {
            m.innerHTML = "Mensagem do sistema";
        }, 3000);
    } else {
        m.style.color = 'darkred';
        setTimeout(() => {
            m.innerHTML = 'Mensagens do sistema';
            m.style.color = '';
        }, 3000);
    }
}

// Função para verificar se o usuário está logado
function iniciar() {
    if (usuario) {
        window.location.href = 'home.html';
    }
    cadastro.classList.add('oculto');
    login.matricula.focus();
}

// Função para alternar entre as telas de cadastro e login
function alternarCadastroLogin() {
    cadastro.classList.toggle('oculto');
    login.classList.toggle('oculto');
    if (bt1Status) {
        cadastro.matricula.focus();
        bt1.innerHTML = 'Login';
        bt1Status = false;
    } else {
        login.focus();
        bt1.innerHTML = 'Cadastre-se';
        bt1Status = true;
    }
}

//Enviar dados para a API e realizar o cadastro
cadastro.addEventListener('submit', function (e) {
    e.preventDefault();
    if (cadastro.pin.value === cadastro.pin2.value) {
        const matricula = cadastro.matricula.value;
        const nome = cadastro.nome.value;
        const cargo = cadastro.cargo.value;
        const setor = cadastro.setor.value;
        const pin = cadastro.pin.value;
        const usuario = { matricula, nome, cargo, setor, pin };
        const options = {
            headers: { 'Content-Type': 'application/json' },
        };
        api.post('/colaborador', usuario, options)
            .then(res => {
                alternarCadastroLogin();
                msg('Cadastro realizado com sucesso');
            })
            .catch(err => {
                msg('Erro ao cadastrar: ' + err.message, true);
            });
    } else {
        msg('Digite o mesmo PIN nos dois campos', true);
    }
});

//Enviar dados para a API e realizar o login
login.addEventListener('submit', function (e) {
    e.preventDefault();
    const matricula = login.matricula.value;
    const pin = login.pin.value;
    const dados = { matricula, pin };
    const options = {
        headers: { 'Content-Type': 'application/json' },
    };
    api.post('/login', dados, options)
        .then(res => {
            const usuario = res.data;
            window.localStorage.setItem('usuario', JSON.stringify(usuario));
            window.location.href = './home.html';
        })
        .catch(err => {
            if(err.code === 'ERR_NETWORK') {
                alert('Servidor não está respondendo', true);
                return;
            }
            msg('Matrícula ou PIN inválidos', true);
        });
});