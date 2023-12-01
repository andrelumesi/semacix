4 Exemplos de uso

4. Dockerfile. 

Vamos utilizar o container oficial de Python em sua versão 3. Neste Dockerfile especificamos também que um comando RUN deve ser executado, para executar o pip para instalar o Flask, além de copiar o arquivo app.py para dentro do container.

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

