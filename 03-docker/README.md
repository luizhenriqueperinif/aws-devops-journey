# Projeto 03: Docker de verdade

**Objetivo:** sair do "copio o Dockerfile e rezo" para **entender** imagem, camada, container,
volume, rede e compose. Tudo **local**, sem custo de AWS.

**Tempo estimado:** 2 semanas (4 sessões práticas)
**Custo:** R$ 0 (roda na sua máquina)
**Ambiente:** WSL2 + Ubuntu (Linux de verdade dentro do Windows)

## Por que esse projeto existe

O Projeto 05 sobe uma **API em container** no ECS Fargate, e o 06 automatiza o build e o
deploy dela. A API que você escrever aqui é **a mesma** que vai pra AWS lá na frente.

```
Projeto 03 (local)          Projeto 05 (AWS)            Projeto 06 (CI/CD)
Dockerfile + compose  ──▶   ECR + ECS Fargate + ALB ──▶ GitHub Actions faz o build
```

---

## Parte A: Ambiente (sessão 1)

### A1. WSL2 + Ubuntu
- [ ] Instalar o WSL2 com Ubuntu (`wsl --install` no PowerShell **como administrador**)
- [ ] Reiniciar o PC e criar o usuário Linux (nome e senha **só seus**, não precisa ser igual ao do Windows)
- [ ] Atualizar os pacotes: `sudo apt update && sudo apt upgrade -y`
- [ ] Instalar a extensão **WSL** no VS Code e abrir uma pasta do Ubuntu com `code .`

### A2. Docker
- [x] Docker Desktop já instalado (v29.8.2), que usa o WSL2 por baixo
- [ ] Ligar a **integração com o Ubuntu**: Docker Desktop → Settings → Resources → WSL integration
- [ ] `docker run hello-world` **de dentro do Ubuntu** 🎉
- [ ] Rodar o `docker` sem `sudo` (grupo `docker`) e entender **por que** isso é poderoso (e perigoso)

### A3. O repositório dentro do Linux
- [ ] Configurar o Git no Ubuntu (`user.name`, `user.email`)
- [ ] Autenticar no GitHub a partir do Ubuntu
- [ ] Clonar o repositório em `~/projetos/` (**não** em `/mnt/c/...`, porque fica lento)

---

## Parte B: Containers na mão (sessão 1-2)

- [ ] Subir um `nginx` e acessar no navegador: `-d`, `-p 8080:80`, `--name`
- [ ] Os comandos do dia a dia: `ps`, `ps -a`, `logs`, `exec -it`, `stop`, `start`, `rm`
- [ ] Servir o site do Projeto 02 com **bind mount** (`-v`), editar o HTML e ver mudar na hora
- [ ] Criar um arquivo **dentro** do container, apagar o container e ver o arquivo sumir.
      Anotar no diário: **por que o container é descartável?**

---

## Parte C: Sua primeira imagem (sessão 2)

Pasta: `03-docker/site/`
- [ ] Escrever um `Dockerfile` que empacota o site (base `nginx:alpine`)
- [ ] `docker build -t meu-site:1.0 .` e rodar a imagem
- [ ] Ver as **camadas** com `docker history meu-site:1.0`
- [ ] Experimento de **cache**: mudar só o HTML, rebuildar e ver quais passos dizem `CACHED`
- [ ] Criar um `.dockerignore` e explicar pra que serve

---

## Parte D: Uma API de verdade (sessão 3)

Pasta: `03-docker/api/`. **Você escreve a API** (Node/Express, que você já domina):
- [ ] Rota `GET /health` → `{ "status": "ok" }` (o ECS e o ALB vão usar isso no Projeto 05)
- [ ] Uma rota que lê/grava algo no banco (ex.: `GET/POST /notas`)
- [ ] Configuração por **variáveis de ambiente** (porta, URL do banco), nada fixo no código
- [ ] `Dockerfile` simples → anotar o **tamanho** da imagem (`docker images`)
- [ ] `Dockerfile` **multi-stage** → comparar o tamanho. Quanto diminuiu?
- [ ] Rodar como **usuário não-root** dentro do container

---

## Parte E: Volumes, redes e Compose (sessão 4)

- [ ] Subir um **PostgreSQL** com **volume nomeado**, apagar o container e provar que os dados ficaram
- [ ] Criar uma **rede** própria e fazer a API achar o banco **pelo nome** (DNS do Docker)
- [ ] Escrever um `compose.yaml` com `api` + `db`
- [ ] `healthcheck` no banco + `depends_on` com `condition: service_healthy`
- [ ] `docker compose up -d`, `logs -f`, `down` e `down -v` (qual a diferença?)

---

## Cuidados
- [ ] **Nunca** colocar senha no `Dockerfile` ou na imagem. Use variável de ambiente e um
      `.env` (o `.gitignore` já bloqueia `.env`)
- [ ] Limpar de vez em quando: `docker system df` e `docker system prune`

## Diário de bordo

> O que deu certo, o que deu errado, o que te confundiu.

## Perguntas para fixar (responda sem consultar)
1. Qual a diferença entre **imagem** e **container**?
2. Por que a ordem das linhas no Dockerfile muda o tempo de build?
3. O que acontece com os dados de um container quando ele é apagado? Como evitar perder dados?
4. Qual a vantagem do multi-stage build?
5. Por que a API achou o banco pelo nome `db` em vez de um IP?
6. Container é uma máquina virtual? Explique a diferença.

## Bônus (opcional)
- Escanear a imagem atrás de vulnerabilidades (`docker scout` ou `trivy`)
- Fixar a imagem base por **digest** (`nginx@sha256:...`) em vez de tag. Por que isso é mais seguro?
