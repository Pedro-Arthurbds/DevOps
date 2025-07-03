# Etapa 1: Definir a imagem base
# Usamos uma imagem Alpine para manter o tamanho final pequeno.
FROM python:3.11-alpine

# Etapa 2: Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências
# Copiar o requirements.txt primeiro aproveita o cache de camadas do Docker.
# A instalação das dependências só será executada novamente se este arquivo mudar.
COPY requirements.txt .

# Etapa 4: Instalar as dependências
# O --no-cache-dir garante que não haverá cache do pip, reduzindo o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o restante do código da aplicação para o diretório de trabalho
COPY . .

# Etapa 6: Expor a porta em que a aplicação será executada
EXPOSE 8000

# Etapa 7: Comando para iniciar a aplicação com Uvicorn
# Usamos --host 0.0.0.0 para tornar a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
