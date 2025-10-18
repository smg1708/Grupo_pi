// importa os bibliotecas necessários
const serialport = require('serialport'); // responsavel pela conexão como arduino
const express = require('express');//responsavel pela criação do servidor web da API
const mysql = require('mysql2'); // responsavel pela conexao com o abnco

// constantes para configurações
const SERIAL_BAUD_RATE = 9600;

// Caso a porta que definimos para a API (3300)  estive sendo utilziada por outro processo, vai aparecer 'EADDRINUSE' no terminal
const SERVIDOR_PORTA = 3300;

// habilita ou desabilita a inserção de dados no banco de dados
// caso estiver desabilitado, os dados são apenas exibidos no console, sem inserção no banco.
const HABILITAR_OPERACAO_INSERIR = true;

// função para comunicação serial
const serial = async (
    //valoresSensorAnalogico,
    valoresSensorDigital,
) => {
    // conexão com o banco de dados MySQL ( configurações necessárias para a conexão)
    let poolBancoDados = mysql.createPool(
        {
            host: 'localhost',
            user: 'aluno',
            password: 'Sptech#2024',
            database: 'vagasIQ',
            port: 3307
        }
    ).promise();

    // lista as portas seriais disponíveis e procura pelo Arduino
    const portas = await serialport.SerialPort.list();
    const portaArduino = portas.find((porta) => porta.vendorId == 2341 && porta.productId == 43);
    if (!portaArduino) {
        throw new Error('O arduino não foi encontrado em nenhuma porta serial'); // caso não 
    }

    // configura a porta serial com o baud rate especificado
    const arduino = new serialport.SerialPort(
        {
            path: portaArduino.path,
            baudRate: SERIAL_BAUD_RATE
        }
    );

    // evento quando a porta serial é aberta
    arduino.on('open', () => {
        console.log(`A leitura do arduino foi iniciada na porta ${portaArduino.path} utilizando Baud Rate de ${SERIAL_BAUD_RATE}`);
    });

    // processa os dados recebidos do Arduino

    // o '\r\n' Indicar que cada leitura termina com uma quebra de linha.
    arduino.pipe(new serialport.ReadlineParser({ delimiter: '\r\n' })).on('data', async (data) => {
        console.log(data);
        const valores = data.split(';');// delimita os valores tratados com a ;
        const sensorDigital = parseInt(valores[0]); // transforma os valores recebidos em int
        // const sensorAnalogico = parseFloat(valores[1]);

        // armazena os valores dos sensores nos arrays correspondentes
        //valoresSensorAnalogico.push(sensorAnalogico);
        valoresSensorDigital.push(sensorDigital);

        // insere os dados no banco de dados (se habilitado)
        if (HABILITAR_OPERACAO_INSERIR) {

            // este insert irá inserir os dados na tabela "medida"
            await poolBancoDados.execute(
                'INSERT INTO sensor (situacao) VALUES (?);',
                [sensorDigital]
            );
            console.log("valores inseridos no banco: " + sensorDigital);

        }

    });

    // evento para lidar com erros na comunicação serial
    arduino.on('error', (mensagem) => {
        console.error(`Erro no arduino (Mensagem: ${mensagem}`)
    });
}

// função para criar e configurar o servidor web
const servidor = (
    //valoresSensorAnalogico,
    valoresSensorDigital
) => {
    const app = express();

    // configurações de requisição e resposta, esse app.use(..) permite que o navegador acesse a API de diferentes origens (CORS), que é tipo de autorização para o acesso da API pelos outros sites, no nosso caso para o index poder acessá-lo
    app.use((request, response, next) => {
        //Aqui você está dizendo ao navegador: "qualquer site pode acessar minha API
        response.header('Access-Control-Allow-Origin', '*');
        // aqui você define quais cabeçalhos a requisão pode enviar
        response.header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept');
        next();
    });

    // inicia o servidor na porta especificada
    app.listen(SERVIDOR_PORTA, () => {
        console.log(`API executada com sucesso na porta ${SERVIDOR_PORTA}`);
    });

    // define os endpoints da API para cada tipo de sensor
    //app.get('/sensores/analogico', (_, response) => {
    //    return response.json(valoresSensorAnalogico);
    //});
    app.get('/sensores/digital', (_, response) => {
        return response.json(valoresSensorDigital);
    });
}

// função principal assíncrona para iniciar a comunicação serial e o servidor web
(async () => {
    // arrays para armazenar os valores dos sensores
    //const valoresSensorAnalogico = [];
    const valoresSensorDigital = [];


    // as funções SERIAL e SERVIDOR indicam a integração do hardware físico e o software com a API

    // inicia a comunicação serial
    await serial(
        //valoresSensorAnalogico,
        valoresSensorDigital
    );

    // inicia o servidor web
    servidor(
        //valoresSensorAnalogico,
        valoresSensorDigital
    );
})();