const usuario = JSON.parse(window.localStorage.getItem('usuario'));
var bt1Status = true;
function iniciar() {
    if (usuario) {
        window.location.href = 'home.html';
    }
    document.getElementById('cadastro').classList.add('oculto');
    document.getElementById('matricula').focus();
}

function alternarCadastroLogin() {
    document.getElementById('cadastro').classList.toggle('oculto');
    document.getElementById('login').classList.toggle('oculto');
    if (bt1Status) {
        document.getElementById('matriculac').focus();
        document.getElementById('bt1').innerHTML = 'Login';
        bt1Status = false;
    }else{
        document.getElementById('matricula').focus();
        document.getElementById('bt1').innerHTML = 'Cadastre-se';
        bt1Status = true;
    }
}