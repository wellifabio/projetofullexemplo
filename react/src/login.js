import { LogoMarca, Botao } from './componentes.js'

export function Header() {
    return <header>
        <LogoMarca />
        <nav>
            <Botao onClick={() => AbreCadastro()}>Cadastre-se</Botao>
        </nav>
    </header>;
}

export function Main() {
    return <main>
        <Login/>
    </main>;
}

export function Footer() {
    return <footer>
        <h2>By Prof. Wellington</h2>
    </footer>;
}

function Login() {
    return <form>
        <input type="number" id="matricula" name="matricula" placeholder="Matrícula" required />
        <label for="matricula">Digite sua Matrícula</label>
        <input type="password" id="pin" name="pin" placeholder="PIN" required />
        <label for="pin">Digite seu PIN</label>
        <button type="submit">Login</button>
    </form>;
}

function Cadastro() {
    return <form>
        <input type="number" id="matricula" name="matricula" placeholder="Matrícula" required />
        <label for="matricula">Digite sua Matrícula</label>
        <input type="number" id="nome" name="nome" placeholder="Nome" required />
        <label for="nome">Digite seu nome completo</label>        
        <input type="password" id="pin" name="pin" placeholder="PIN" required />
        <label for="pin">Digite seu PIN</label>
        <input type="password" id="pin2" name="pin2" placeholder="PIN" required />
        <label for="pin2">Confirme seu PIN</label>
        <button type="submit">Login</button>
    </form>;
}