<h1 align="center"> Atv 1 - AWS/LINUX </h1> 

# Índice 

* [Objetivos AWS](#objetivos-aws)
* [Objetivos Linux](#objetivos-linux)
* [Documentação](#-documenta%C3%A7%C3%A3o-)
* [Parte I - Console AWS](#parte-i---console-aws)
* [Criação de key pairs](#criação-de-key-pairs)
* [Lançamento de instâncias](#lançamento-de-instâncias)
* [Gerando Elastic IP](#gerando-elastic-ip)
* [Criando o EFS](#criando-o-efs)
* [Parte II - Sistema Linux](#parte-ii---sistema-linux)
* [Configurando NFS](#configurando-nfs)
  
# Objetivos AWS
- Gerar uma chave pública para acesso ao ambiente;
- Criar 1 instância EC2 com o sistema operacional Amazon Linux 2 (Família t3.small, 16 GB SSD);
- Gerar 1 elastic IP e anexar à instância EC2;
- Liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80/TCP, 443/TCP).

# Objetivos Linux
- Configurar o NFS entregue;
- Criar um diretorio dentro do filesystem do NFS com seu nome;
- Subir um apache no servidor - o apache deve estar online e rodando;
- Criar um script que valide se o serviço esta online e envie o resultado da validação para o seu diretorio no nfs;
- O script deve conter - Data HORA + nome do serviço + Status + mensagem personalizada de ONLINE ou offline;
- O script deve gerar 2 arquivos de saida: 1 para o serviço online e 1 para o serviço OFFLINE;
- Preparar a execução automatizada do script a cada 5 minutos;
- Fazer o versionamento da atividade;
- Fazer a documentação explicando o processo de instalação do Linux.

#
<h1 align="center"> DOCUMENTAÇÃO </h1>

# Parte I - Console AWS

## Criação de key pairs
- Acessar o serviço de EC2 e no menu lateral em Network & Security entrar em Key Pairs.
- Na parte superior direita acessar "Create key pair".
- Na paginá aberta da Create key pair você escolhera o nome da chave, o tipo e formato, sendo respectivamente, AtvLinux, RSA, .pem e salvar o arquivo .pem.
- Ao clicar em Create no fim da paginá você salvará no computador o arquivo .pem gerado para usa-lo posteriormente no acesso via ssh.

## Lançamento de instâncias
- No serviço EC2 acessar no menu lateral "Instances".
- Na parte superior direita acessar "Launch instances".
- Na página de Launch an instance você fornecera nomes e tags se necessario, qual a imagem de OS a ser montada, no caso será a Amazon Linux 2, qual o tipo da instância, família t3.small, selecionará a Key pair criada posteriormente, editara as configurações de rede e selecionará a configuração de storage, 1x 16 GiB SSD gp3.
- Nas configurações de rede deverá clica rem editar ativar o public IP e adicionar regras do grupo de segurança liberando as portas:
    Tipo | Protocolo | Intervalo de portas | Origem | Descrição
    ---|---|---|---|---
    SSH | TCP | 22 | MEU IP | SSH
    TCP personalizado | TCP | 80 | 0.0.0.0/0 | HTTP
    TCP personalizado | TCP | 443 | 0.0.0.0/0 | HTTPS
    TCP personalizado | TCP | 111 | 0.0.0.0/0 | RPC
    UDP personalizado | UDP | 111 | 0.0.0.0/0 | RPC
    TCP personalizado | TCP | 2049 | 0.0.0.0/0 | NFS
    UDP personalizado | UDP | 2049 | 0.0.0.0/0 | NFS
- Lançar a instância em "Launch instances" e aguardar os processos de verificações.

## Gerando Elastic IP
- No serviço EC2 acessar no menu lateral em Network & Security "Elastic IPs".
- Na parte superior direita acessar "Allocate Elastic IP asdress".
- Dentro da pagina devera selecionar deixe no padrão ou de mude o Network Border Group de acordo com a região de trabalho da instância e finalize em "Allocate".
- Com Elastic Ip criado, selecione ele e vá em actions no canto superior direito e selecione a opção "Associate Elast IP address".
- Nessa página deverá selecionar a instância a qual será associado, seu ip privado se necessario e clicar em "Associate".

## Criando o EFS
- Para ter acesso ao NFS precisamos do EFS da AWS, no console AWS pesquise por EFS.
- Vá ate "Create file system" para começar a criar um sistema de arquivos EFS.
- Escolha o nome que deseja para a EFS e a VPC da sua instância.
- Selecione a EFS criada e vá em "View details" > Network > Manage e no menu "Mount Targets" selecione o security group da sua instância que deverá estar com a porta 	NFS liberada e salve.
- Selecione a EFS Clique em "Attach" e copie o código do NFS client.

#
# Parte II - Sistema Linux

## Configurando NFS
