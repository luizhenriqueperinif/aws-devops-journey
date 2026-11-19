# Jornada AWS DevOps

Repositório de estudos práticos rumo a DevOps na AWS.
Cada pasta numerada é um projeto que constrói em cima do anterior.

**Ponto de partida:** AWS Academy Cloud Foundations (curso concluído, conteúdo do Cloud Practitioner) ✅
**Próxima certificação:** AWS Solutions Architect Associate (SAA): veja a [trilha de estudos](TRILHA-SAA.md)
**Ritmo:** ~6h por semana

## Rotina semanal (6h)

| Sessão | Duração | Foco |
|--------|---------|------|
| 1 | 2h | Projeto prático (mão na massa) |
| 2 | 2h | Projeto prático (terminar / documentar) |
| 3 | 2h | Teoria SAA (curso + questões) |

> Regra de ouro: todo projeto termina com um README explicando **o que** foi feito, **por que** e **o que deu errado**. Isso é portfólio.

## Roadmap

| # | Projeto | O que você aprende | Estimativa | Status |
|---|---------|--------------------|------------|--------|
| 01 | [Setup seguro da conta](01-setup-conta/) | IAM, MFA, billing, AWS CLI | 1 semana | ✅ |
| 02 | [Site estático (S3 + CloudFront)](02-site-estatico/) | S3, CDN, HTTPS e depois o mesmo em Terraform | 2 semanas | ✅ |
| 03 | Docker de verdade | Imagem, camadas, volumes, redes, multi-stage, compose | 2 semanas | 🔄 |
| 04 | VPC do zero em Terraform | Subnets, rotas, NAT, security groups, SSM | 3 semanas | ⏳ |
| 05 | App no ECS Fargate + ALB | ECR, ECS, Load Balancer, deploy de container | 3 semanas | ⏳ |
| 06 | Pipeline CI/CD | GitHub Actions + OIDC, build e deploy automático | 2 semanas | ⏳ |
| 07 | Observabilidade | CloudWatch Logs, métricas, alarmes, SNS | 2 semanas | ⏳ |

Legenda: ✅ feito · 🔄 em andamento · ⏳ pendente

## Cuidados com custo
- Sempre rodar `terraform destroy` (ou apagar recursos) ao final da sessão de estudo
- NAT Gateway, Load Balancer e EKS **cobram por hora**, mesmo sem uso
- Região padrão de estudo: `us-east-1` (mais barata que São Paulo)
