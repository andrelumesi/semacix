4 Exemplos de uso

4.1 Postgres
saythanks

Vamos criar um container que possui um banco de dados Postgres e faça a disponibilização desse para uso.

docker run --name postgresbd -e POSTGRES_PASSWORD=123@abc -p 5432:5432 -d postgres

4.2 Postgres + PostGIS

O Postgres possui uma extensão para trabalhar dados geoespaciais, com o Docker a utilização deste é muito simples. Através de uma imagem disponibilizada por um usuário do Dockerhub, todas as configurações deste serviço já são feitas. Vejamos como utiliza-lo.

docker run --name postgis -p 25432:5432 -d -t kartoza/postgis

4.3 pgAdmin

docker run -p 8080:80 \
        -e "PGADMIN_DEFAULT_EMAIL=email@email.com" \
        -e "PGADMIN_DEFAULT_PASSWORD=1234." \
        -d dpage/pgadmin4:latest

4.4 Aplicação
Nesta subseção, vamos inserir uma aplicação Python e Flask dentro de um container. Para isto, inicialmente façamos a criação do arquivo app.py, neste o conteúdo abaixo é inserido.

from flask import *
from markupsafe import escape


app = Flask(__name__)

@app.route('/')
def ola_no_container():
    nome = request.args.get("nome")
    return f"Olá, {escape(nome)}! Estou dentro de um container!"

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
É possível perceber na listagem de código acima que esta aplicação básicamente inicia um servidor através do Flask e este recebe requisições HTTP que podem conter um parâmetro nome na requisição, e o conteúdo dessa parâmetro passado pelo usuário é exibido no retorno do servidor.

Bem, agora façamos a criação de um Dockerfile. Vamos utilizar o container oficial de Python em sua versão 3. Neste Dockerfile especificamos também que um comando RUN deve ser executado, para executar o pip para instalar o Flask, além de copiar o arquivo app.py para dentro do container.

Por fim é especificado que o ENTRYPOINT, ou seja, o comando principal do container será o python e ele recebe como parâmetro o nome do arquivo que ele executa (app.py).

FROM python:3

# O container, no momento da execução, 'escuta' a porta 5000
EXPOSE 5000

COPY app.py ./

RUN pip install Flask

# Argumentos para o entrypoint
CMD [ "./app.py" ]

ENTRYPOINT [ "python" ]
Agora execute o docker build para criar a imagem.

# Build
docker build -t "flaskapp:0.1" .
Com a imagem criada, vamos iniciar o container.

# Execução
docker run -d -p 5000:5000 flaskapp:0.1
Agora sim! Vá até seu navegador e acesse o endereço 127.0.0.1:5000

Você pode editar a URL de requisição e inserir seu nome, por exemplo: http://127.0.0.1:5000?nome=Julia

