# Projeto 01: Setup seguro da conta AWS

**Objetivo:** ter uma conta AWS própria, protegida e sem risco de cobrança surpresa,
pronta para ser usada pelo terminal.

## Checklist

### 1. Criar a conta
- [x] Criar em https://aws.amazon.com/free
- [x] Usar um e-mail dedicado (dica Gmail: `seuemail+aws@gmail.com`, que cai na mesma caixa)
- [x] Escolher o **plano gratuito (Free plan)** quando aparecer a opção
- [x] Vai pedir cartão de crédito (pode ser virtual, do Nubank/Inter etc.)

**Por quê o Free plan?** Contas novas ganham créditos e, no plano gratuito, a AWS
não cobra nada até você fazer upgrade manualmente. É a rede de proteção ideal pra estudar.

### 2. Proteger o usuário root
- [x] Ativar **MFA** no root (app autenticador: Google Authenticator, Authy etc.)
- [x] **Não** criar access keys para o root

**Por quê?** O root pode fazer *tudo*, inclusive fechar a conta. Se vazar, já era.
Depois deste projeto, o root só é usado em emergências.

### 3. Alertas de custo
- [x] Billing → Budgets → criar **Zero spend budget** (te avisa no 1º centavo)
- [x] Criar um **Monthly cost budget** de US$ 5 com alerta em 80%

**Por quê?** Em DevOps você vai criar e destruir recursos o tempo todo. Um dia você
vai esquecer algum ligado. O alerta é o que te salva.

### 4. Criar seu usuário do dia a dia (IAM Identity Center)
- [x] Região `us-east-1` → IAM Identity Center → Enable
- [x] Criar um usuário pra você
- [x] Criar um permission set `AdministratorAccess`
- [x] Atribuir o usuário + permission set à sua conta
- [x] Ativar MFA nesse usuário também
- [x] Salvar a **AWS access portal URL** (algo como `https://d-xxxxxxxxxx.awsapps.com/start`)

**Por quê não um IAM User com access key?** Access keys são credenciais permanentes,
que vazam em repositório do GitHub com uma facilidade absurda. O Identity Center usa
credenciais **temporárias**, que é a prática recomendada pela AWS e o que o mercado usa.

### 5. AWS CLI
- [x] Instalar AWS CLI v2 (Windows: instalador MSI · Pop!_OS: instalador oficial zip)
- [x] `aws --version`
- [x] `aws configure sso` (usar a URL do portal, região `us-east-1`, dar o nome de perfil `estudos`)
- [x] `aws sts get-caller-identity --profile estudos` ← se retornar seu Account ID, deu certo 🎉

### 6. Fechamento
- [x] Escrever abaixo o que aprendeu e o que deu errado

## Aprendi como criar a conta na AWS, como criar uma url "minha", como criar um usuario e dar permissões a ele e ver em qual usuário estou conectado na CLI. Devo dizer que é um mundo novo e que causa confusão as vezes kkkk, mas nada que uma boa prática e constancia não resolvam.

> Escreva aqui com as suas palavras. Ex.: "Tive erro X no `aws configure sso` porque..."

## Perguntas para fixar (responda sem consultar)
1. Qual a diferença entre o usuário root e o usuário do Identity Center?
R: O root é o admin que tem acesso a literalmente tudo, o usuario do identity center foi o que criamos, no caso hoje criamos um que tem acesso a muita coisa, mas da pra criar outro com menos acessos também.
2. Por que credenciais temporárias são mais seguras que access keys?
Por que elas mudam constantemente e ficam em um local mais seguro também. 
3. O que acontece se eu deixar um recurso ligado e esquecer?
R: Irá ficar gastando até desligar, e como configuramos avisos irá nos avisar quando usar a primeira vez e quando chegar nos 85% dos $5,00, é só ter o hábito de dar o terraform destroy.
