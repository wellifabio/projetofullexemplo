function Header() {
    return <header>
        <div><h1 className="a">S</h1><h1 className="b">ervi</h1><h1 className="c">Facil</h1></div>
    </header>;
}

function Main() {
    return <main>
        <h1>Main</h1>
    </main>;
}

function Footer() {
    return <footer>
        <h2>By Prof. Wellington</h2>
    </footer>;
}

export default function App() {
    return <>
        <Header />
        <Main />
        <Footer />
    </>;
}