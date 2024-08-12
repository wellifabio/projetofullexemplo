export function LogoMarca() {
    return <div><h1 className="a">S</h1><h1 className="b">ervi</h1><h1 className="c">Facil</h1></div>
}

export function Botao(props) {
    return <button onClick={props.onClick}>{props.children}</button>
}