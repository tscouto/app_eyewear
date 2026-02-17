
# App Eyewear 👓

## 📌 Sobre o Projeto
O **App Eyewear** é uma aplicação desenvolvida com foco em gerenciamento e visualização de produtos óticos (óculos e acessórios). 
O sistema permite organização de itens, cadastro, manipulação de dados e estrutura preparada para backend web.

O projeto foi desenvolvido com Django, seguindo boas práticas de organização, separação de responsabilidades e estrutura modular.

Repositório oficial:
https://github.com/tscouto/app_eyewear

---

## 🚀 Tecnologias Utilizadas

- Python 3.x
- Django
- SQLite3 (banco padrão do Django)
- HTML5
- CSS3
- JavaScript (quando necessário)
- Django ORM

---

## 📚 Principais Bibliotecas

- django
- asgiref
- sqlparse
- tzdata (Windows)

As dependências podem variar de acordo com o ambiente virtual.

---

## ⚙️ Funcionalidades do Sistema

- Cadastro de produtos
- Listagem de itens
- Organização de dados
- Estrutura preparada para expansão (API ou frontend separado)
- Utilização de ORM para manipulação do banco de dados

---

## 🛠️ Instalação e Configuração

### 1️⃣ Clonar o repositório

```bash
git clone https://github.com/tscouto/app_eyewear
cd app_eyewear
```

### 2️⃣ Criar e ativar ambiente virtual

Windows:

```bash
python -m venv venv
venv\Scripts\activate
```

Linux/Mac:

```bash
python3 -m venv venv
source venv/bin/activate
```

### 3️⃣ Instalar dependências

```bash
pip install django
```

Ou, caso exista:

```bash
pip install -r requirements.txt
```

### 4️⃣ Aplicar migrações

```bash
python manage.py migrate
```

### 5️⃣ Criar superusuário (opcional)

```bash
python manage.py createsuperuser
```

### 6️⃣ Rodar o servidor

```bash
python manage.py runserver
```

Acessar no navegador:

```
http://127.0.0.1:8000/
```

---

## 🗂️ Estrutura do Projeto (Resumo)

- manage.py → Gerenciador principal do Django
- settings.py → Configurações do projeto
- models.py → Estrutura do banco de dados
- views.py → Regras de negócio
- templates/ → Interface HTML
- static/ → Arquivos CSS/JS

---

## 📦 Banco de Dados

Por padrão, o projeto utiliza SQLite (banco embarcado do Django).
Para produção, recomenda-se utilizar PostgreSQL ou MySQL.

---

## 🧠 Observações Técnicas

O projeto é estruturado como aplicação backend tradicional utilizando Django Templates.
Pode ser facilmente adaptado para arquitetura moderna utilizando Django REST Framework + React, Vue ou outro frontend separado.

---

## 📄 Licença

Projeto para fins educacionais e de aprendizado.
