function validarSessao() {
    var email = sessionStorage.EMAIL_USUARIO;
    var nome = sessionStorage.NOME_USUARIO;
    var seguradoraNome = sessionStorage.NOME_SEGURADORA;
    

    if (email != null && nome != null) {
        h1_nome.innerHTML = `Olá, ${nome}!`;
        span_nome.innerHTML = nome[0].toUpperCase();
        h4_nome.innerHTML =  nome;
        span_empresa.innerHTML = seguradoraNome;
    } else {
        window.location = "../login.html";
    }
}
function validarSessaoSuporte() {
    var email = sessionStorage.EMAIL_USUARIO;
    var nome = sessionStorage.NOME_USUARIO;

    if (email != null && nome != null) {
        span_nome.innerHTML = nome[0].toUpperCase();
        h4_nome.innerHTML =  nome;
    } else {
        window.location = "../login.html";
    }
}

function limparSessao() {
    sessionStorage.clear();
    window.location = "../login.html";
}