### Kubernetes + Django

Levatando uma aplicação Django usando o Kubernetes

![Kuberntes + Django]
(http://ap.imagensbrasil.org/images/kuberntesdjango.png)

## Instalação
1 - Inicie o banco de dados, o comando abaixo fará todo o processo de descompactação do Banco para a pasta correta 
    `make boostrap`

2 - Inicie o Kubernetes, o comando abaixo fará download das imagens do Kubernetes caso você já não tenha em sua máquina e as iniciára
    `make kubernetes-run`

3 - Faça download do kubectl, o comando abaixo fará download de executavel responsavél pela comunicação com a API do Kubernetes
    `wget "http://storage.googleapis.com/kubernetes-release/release/v1.2.0/bin/linux/amd64/kubectl"` 

    Caso você queira usar o Kubernetes de forma global basta mover este binário para a pasta de executaveis do seu sitema
    `mv kubectl /usr/bin`

    Após baixar o kubectl você será capaz de executar o comando `kubecl get pods` sem problemas
    e obter uma resposta como `k8s-master-127.0.0.1   3/3       Running   0          7m`

4 - Inserir os paths dos arquivos de configuração da aplicação, acesse os arquivos mysql-rc.yml, nginx-rc.yml e subtitua o comentário `#path do projeto (pwd)` pelo full path do seu sistema operacional até aquele projeto, você pode fazer isso pegando o output do comando `pwd` rodado de dentro da pasta do projeto

5 - Iniciando aplicação, o comando abaixo iniciará os componentes da sua aplicação pelo Kubernetes (nginx, mysql, redis)
    `make run`

6 - Testar, acessando o browser no endereço `http://10.0.0.40/` você deverá ver uma mensagem de "Hello, world! Django + Kubernetes