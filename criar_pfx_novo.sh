#!/bin/bash
# criar_pfx_novo.sh

echo "📋 CRIANDO NOVO PFX A PARTIR DO CERTIFICADO ATUAL"
echo "=========================================="

# 1. Extrair o certificado e chave atuais do servidor
echo "📥 Baixando certificado e chave do servidor..."
ssh se-hvl-sbisa02 "sudo cat /etc/apache2/certs/wildcardaghu.crt" > /tmp/wildcardaghu.crt
ssh se-hvl-sbisa02 "sudo cat /etc/apache2/certs/wildcardaghu.key" > /tmp/wildcardaghu.key

# 2. Verificar se os arquivos foram baixados
if [ ! -s /tmp/wildcardaghu.crt ] || [ ! -s /tmp/wildcardaghu.key ]; then
    echo "❌ Falha ao baixar os arquivos do servidor"
    exit 1
fi

echo "✅ Certificado e chave baixados com sucesso"

# 3. Criar novo PFX com senha Ebserh@123
echo "🔐 Criando novo PFX com senha: Ebserh@123"
openssl pkcs12 -export -out roles/certificados/files/homolog-aghu.ebserh.gov.br.pfx \
  -inkey /tmp/wildcardaghu.key \
  -in /tmp/wildcardaghu.crt \
  -passout pass:Ebserh@123 \
  -name "aghu-cert"

if [ $? -eq 0 ]; then
    echo "✅ PFX criado com sucesso!"
    echo "📁 Local: roles/certificados/files/homolog-aghu.ebserh.gov.br.pfx"
    
    # 4. Testar o novo PFX
    echo ""
    echo "🧪 Testando o novo PFX..."
    openssl pkcs12 -in roles/certificados/files/homolog-aghu.ebserh.gov.br.pfx -info -noout -passin pass:Ebserh@123
    if [ $? -eq 0 ]; then
        echo "✅ Teste passou! O PFX está funcionando."
        echo ""
        echo "📝 Atualize o arquivo roles/certificados/defaults/main.yml com:"
        echo "   pfx_password: \"Ebserh@123\""
    else
        echo "❌ Teste falhou! O PFX pode estar corrompido."
    fi
else
    echo "❌ Falha ao criar o PFX"
    exit 1
fi

# 5. Limpar arquivos temporários
rm -f /tmp/wildcardaghu.crt /tmp/wildcardaghu.key

echo ""
echo "=========================================="
echo "✅ Processo concluído!"
