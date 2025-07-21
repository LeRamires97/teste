#!/bin/bash

# Pergunta o caminho do diretório
read -p "Informe o caminho completo do diretório do seu projeto: " project_dir

# Verifica se o diretório existe
if [ ! -d "$project_dir" ]; then
    echo "❌ Diretório não encontrado: $project_dir"
    exit 1
fi

# Entra no diretório
cd "$project_dir" || exit

# Verifica se já é um repositório Git
if [ ! -d ".git" ]; then
    echo "📁 Diretório ainda não é um repositório Git. Inicializando..."
    git init
else
    echo "✅ Já é um repositório Git."
fi

# Pergunta a URL do repositório remoto
read -p "Informe a URL do repositório remoto (HTTPS ou SSH): " repo_url

# Verifica se o remote "origin" já existe
if git remote | grep -q origin; then
    echo "🔁 Remote 'origin' já existe. Substituindo..."
    git remote remove origin
fi

# Adiciona o remoto
git remote add origin "$repo_url"

# Adiciona os arquivos ao commit
git add .

# Pergunta a mensagem de commit
read -p "Digite a mensagem do commit: " commit_msg
git commit -m "$commit_msg"

# Pergunta a branch (padrão: main)
read -p "Digite o nome da branch para o push (default: main): " branch
branch=${branch:-main}

# Faz o push
git push -u origin "$branch"

# Verifica sucesso
if [ $? -eq 0 ]; then
    echo "🚀 Push realizado com sucesso para a branch '$branch'."
else
    echo "❌ Erro ao fazer push. Verifique as mensagens acima."
fi
