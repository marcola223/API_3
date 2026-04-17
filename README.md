-----

# 📚 Library API

Uma API RESTful construída com Node.js, Express e SQLite que permite aos usuários gerenciar sua coleção pessoal de livros com autenticação e segurança.

Check it out here: [https://library-api-marcos.onrender.com/books](https://www.google.com/search?q=https://library-api-marcos.onrender.com/books)

-----

## 🚀 Features

  - Registro de usuários e login (Autenticação JWT)
  - Criptografia de senhas com bcrypt
  - CRUD completo de livros
  - Banco de dados SQLite (Better-SQLite3)
  - Rotas protegidas por middleware
  - Filtragem, ordenação e paginação de dados
  - Dados relacionais usando JOIN (usuários ↔ livros)
  - Testes automatizados com Jest e Supertest

-----

## 🛠️ Technologies

  - Node.js
  - Express.js
  - SQLite
  - JSON Web Token (JWT)
  - bcrypt
  - Jest
  - Supertest

-----

## 📦 Installation

```bash
git clone <your-repo-url>
cd library-api
npm install
```

-----

## ⚙️ Environment Variables

Crie um arquivo `.env` na raiz do projeto:

```env
PORT=3000
TOKEN_SECRET=sua_chave_secreta_aqui
```

-----

## ▶️ Running the Project

```bash
node app.js
```

Server will run on:

```
http://localhost:3000
```

-----

## 🧪 Running Tests

```bash
npm test
```

-----

## 🌱 Seeding the Database

Para criar pelo menos 20 registros de livros clássicos:

```bash
node seed.js
```

-----

## 🔐 Authentication

Esta API utiliza autenticação via JWT.
Após o login, inclua o token nos headers das requisições protegidas:

```
Authorization: Bearer <seu_token>
```

-----

## 📌 API Routes

### 👤 Auth

#### Register

**POST** `/register`

```json
{
  "username": "user",
  "password": "123456"
}
```

#### Login

**POST** `/login`

```json
{
  "username": "user",
  "password": "123456"
}
```

-----

### 📖 Books (Protected)

#### Create Book

**POST** `/books`

```json
{
  "title": "O Senhor dos Anéis",
  "genre": "Fantasia",
  "year": 1954
}
```

#### Get Books (with filters)

**GET** `/books?page=1&limit=5&sort=title&order=ASC&genre=Fantasia`

#### Update Book

**PUT** `/books/:id`

```json
{
  "title": "1984 - Edição Revisada"
}
```

#### Delete Book

**DELETE** `/books/:id`

#### Get Books with Users (JOIN)

**GET** `/books-details`

-----

## 📊 Query Parameters

| Parameter | Description               |
| --------- | ------------------------- |
| page      | Número da página          |
| limit     | Itens por página          |
| sort      | Campo para ordenar (id, title, year) |
| order     | ASC ou DESC               |
| genre     | Filtrar por gênero        |

-----

## 📬 Postman Collection

Importe o arquivo `.json` fornecido no Postman para testar todas as rotas rapidamente.

-----

## 🚀 Deployment

Esta API pode ser hospedada em:

  - Render
  - Railway

Certifique-se de configurar as variáveis de ambiente na plataforma de deploy.

-----

## ✅ Status Codes

  - 200 → Success
  - 201 → Created
  - 400 → Bad Request
  - 401 → Unauthorized
  - 403 → Forbidden
  - 404 → Not Found
  - 500 → Server Error

-----

## 📁 Project Structure

```
project/
├── app.js
├── database.js
├── seed.js
├── app.test.js
├── package.json
└── .env
```

-----

## 👨‍💻 Author

Marcos

-----

## 📄 License

Este projeto é para fins educacionais e de portfólio.
