#!/bin/bash

PFX="roles/certificados/files/homolog-aghu.ebserh.gov.br.pfx"

# Verificar se o arquivo existe
if [ ! -f "$PFX" ]; then
    echo "❌ Arquivo não encontrado: $PFX"
    exit 1
fi

echo "📁 Arquivo PFX: $PFX"
echo "=========================================="

# Lista de senhas para testar
SENHAS=(
    ""                          # Sem senha
    "Ebserh@123"               # A que está dando erro
    "ebserh@123"
    "Ebserh@2024"
    "Ebserh2024"
    "aghu@2024"
    "aghu@2026"
    "aghu.ebserh.gov.br"
    "homolog-aghu"
    "123456"
    "password"
    "admin123"
    "changeit"
    "root123"
    "senha123"
    "hubrasil@2026"
)

for SENHA in "${SENHAS[@]}"; do
    if [ -z "$SENHA" ]; then
        echo -n "🔑 Testando: (vazia) - "
    else
        echo -n "🔑 Testando: '$SENHA' - "
    fi
    
    openssl pkcs12 -in "$PFX" -info -noout -passin pass:"$SENHA" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "✅ SENHA CORRETA!"
        echo "=========================================="
        echo "🎉 A senha é: '$SENHA'"
        echo "=========================================="
        exit 0
    else
        echo "❌ Incorreta"
    fi
done

echo "=========================================="
echo "❌ Nenhuma senha funcionou."
echo "=========================================="
echo "Sugestões:"
echo "1. Entre em contato com a equipe que forneceu o certificado"
echo "2. Verifique se o arquivo PFX está íntegro"
echo "3. Considere criar um novo PFX a partir do certificado atual"
