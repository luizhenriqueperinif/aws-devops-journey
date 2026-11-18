# Projeto 02: Site estático com S3 + CloudFront

**Objetivo:** colocar um site no ar, com HTTPS e servido por CDN, primeiro **pelo console**
(pra entender cada peça) e depois **recriar tudo com Terraform** (Infraestrutura como Código).

**Tempo estimado:** 2 semanas (4 sessões práticas)
**Custo:** centavos (S3) + CloudFront dentro da cota gratuita. Coberto pelos créditos.

## Arquitetura

```
Visitante ──HTTPS──▶ CloudFront (CDN) ──OAC──▶ Bucket S3 (PRIVADO)
                     d123abc.cloudfront.net      index.html, error.html
```

**Por que não deixar o bucket público?** O jeito antigo era ligar o "Static website
hosting" do S3 e liberar o bucket pra internet. Funciona, mas: sem HTTPS, sem cache e com
o bucket exposto. O jeito moderno é o bucket **privado**, e só o CloudFront consegue ler
dele, via **OAC (Origin Access Control)**. Isso cai na prova da SAA.

---

## Parte A: Pelo console (sessões 1 e 2)

### A1. O site
- [x] Criar a pasta `02-site-estatico/site/`
- [x] Criar um `index.html` simples, feito por você (sugestão: uma página "Sobre mim" com sua jornada AWS)
- [x] Criar um `error.html` (página de erro 404)

### A2. Bucket S3
- [x] Criar um bucket em `us-east-1` com nome único (ex.: `site-estudos-<algo-seu>`)
- [x] **Block all public access: LIGADO** (deixe o padrão)
- [x] Enviar os arquivos **pela CLI**:
  ```powershell
  aws s3 sync .\site s3://NOME-DO-BUCKET --profile estudos
  aws s3 ls s3://NOME-DO-BUCKET --profile estudos
  ```
- [x] Tentar abrir a URL do objeto no navegador: deve dar **Access Denied** (isso é bom!)

### A3. Distribuição CloudFront
- [x] Criar distribuição com origem = seu bucket S3
- [x] Origin access: **Origin access control settings (recommended)** e criar um OAC
- [x] Viewer protocol policy: **Redirect HTTP to HTTPS**
- [x] Default root object: `index.html`
- [x] Se o console perguntar sobre **plano de preço** do CloudFront, me chame antes de escolher
- [x] Copiar a **bucket policy** que o CloudFront sugere e colar em S3 → bucket → Permissions
- [x] Aguardar o deploy (alguns minutos) e abrir `https://dXXXX.cloudfront.net` 🎉

### A4. Cache na prática
- [x] Alterar o `index.html`, rodar o `aws s3 sync` de novo e recarregar o site: **mudou?**
- [x] Criar uma **invalidação** e testar de novo:
  ```powershell
  aws cloudfront create-invalidation --distribution-id ID --paths "/*" --profile estudos
  ```
- [x] Anotar no diário por que não mudou na primeira vez

### A5. Destruir tudo
- [ ] CloudFront: **Disable** a distribuição, esperar, depois **Delete**
- [ ] S3: **Empty** o bucket, depois **Delete**

> Por que destruir? Porque na Parte B você vai recriar tudo **com código**, e vai sentir na pele
> a diferença entre 30 cliques e um comando.

---

## Parte B: Com Terraform (sessões 3 e 4)

### B1. Preparação
- [ ] Instalar: `winget install Hashicorp.Terraform`
- [ ] Testar: `terraform -version`
- [ ] Entender os conceitos (eu explico na sessão): **provider**, **resource**, **variable**,
      **output**, **state**, e o ciclo `init → plan → apply → destroy`

### B2. Escrever o código (você escreve, eu reviso)
Estrutura sugerida em `02-site-estatico/terraform/`:

| Arquivo | O que vai nele |
|---|---|
| `versions.tf` | versão do Terraform e do provider AWS |
| `providers.tf` | provider `aws` com região `us-east-1` e perfil `estudos` |
| `variables.tf` | nome do bucket etc. |
| `main.tf` | os recursos |
| `outputs.tf` | a URL do CloudFront |

Recursos que você vai precisar (pesquise cada um na documentação do provider AWS):
- [ ] `aws_s3_bucket`
- [ ] `aws_s3_bucket_public_access_block`
- [ ] `aws_cloudfront_origin_access_control`
- [ ] `aws_cloudfront_distribution`
- [ ] `aws_s3_bucket_policy` (+ `data "aws_iam_policy_document"`)

### B3. Rodar
- [ ] `terraform init`
- [ ] `terraform fmt` e `terraform validate`
- [ ] `terraform plan`: **ler** o que vai ser criado antes de aplicar
- [ ] `terraform apply`
- [ ] Subir o site com `aws s3 sync` e testar a URL do output
- [ ] Rodar `terraform plan` de novo: deve dizer **No changes** (por quê?)
- [ ] `terraform destroy` ao final da sessão

### B4. Cuidado com o Git
- [ ] Rodar `git status` antes de commitar: **nenhum** `.tfstate` ou `.terraform/` pode aparecer
      (o `.gitignore` já protege, mas confira)

---

## Diário de bordo

> O que deu certo, o que deu errado, o que te confundiu.

## Perguntas para fixar (responda sem consultar)
1. Por que o bucket ficou privado se o site é público?
2. O que é uma CDN e qual a vantagem de usar o CloudFront na frente do S3?
3. Por que o site não atualizou na hora quando você mudou o `index.html`?
4. O que é o arquivo `terraform.tfstate` e por que ele não pode ir pro GitHub?
5. O que o `terraform plan` faz que o `apply` não faz?

## Bônus (opcional)
- Domínio próprio com Route 53 + certificado HTTPS do ACM (**custa**: domínio ~US$ 13/ano + US$ 0,50/mês da hosted zone)
