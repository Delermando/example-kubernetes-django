# Kubernetes + Django

![Kuberntes + Django]
(http://ap.imagensbrasil.org/images/kuberntesdjango.png)

## Instalação
#### **1 - Iniciando o banco de dados**  
O comando abaixo fará todo o processo de descompactação do Banco para a pasta correta  
    `make boostrap`

#### **2 - Inicie o Kubernetes**  
O comando abaixo fará download das imagens do Kubernetes caso você já não as tenha em sua máquina e as iniciara  
    `make kubernetes-run`

#### **3 - kubectl**  
O **kubectl** é um binário que disponibiliza um interface CLI para comunicação com a API do Kubernetes, execute o seguinte comando para testarmos o funcionamento dele:  ou
`kubecl get pods`  

Caso o Kubernetes esteja funcionando perfeitamente o comando acima deverá retorna o seguinte output:  
`k8s-master-127.0.0.1   3/3       Running   0          7m`

Caso você queira usar o **kubectl** de forma global basta mover este binário para a pasta /usr/bin  
    `mv kubectl /usr/bin`

#### **4 - Insetir paths do projeto**  
Modifique os paths dos arquivos **mysql-rc.yml** e **nginx-rc.yml**, substitua o comentário 
`#path do projeto (pwd)` pelo **full path** do seu sistema operacional até a pasta deste projeto  
`pwd`  
`/home/dsantos/Projects/Development/example-kubernetes-django`

#### **5 - Iniciando aplicação**  
O comando abaixo iniciará os componentes da aplicação (nginx, mysql, redis) usando o Kubernetes  
`make run`  

#### **6 - Hello World**  
Acesse o browser no endereço  
`http://10.0.0.40/`  

Deve ser exibida a seguinte mensagem  
"**Hello, world! Django + Kubernetes**"
