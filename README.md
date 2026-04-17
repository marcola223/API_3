📚 Library API
Uma API RESTful robusta construída com Node.js, Express e SQLite que permite aos usuários gerenciar sua coleção pessoal de livros com total segurança e organização.

🚀 Live Demo: https://library-api-seu-link.onrender.com/books

🚀 Funcionalidades
Segurança: Registro de usuários e login com autenticação JWT.

Privacidade: Criptografia de senhas com bcrypt.

Gestão Completa (CRUD): Controle total sobre sua biblioteca de livros.

Performance: Banco de dados SQLite rápido e eficiente.

Filtros Avançados: Busca por gênero, ordenação customizada e paginação.

Dados Relacionais: Uso de JOIN para conectar livros aos seus respectivos autores/usuários.

Qualidade Garantida: Testes automatizados com Jest e Supertest.



🛠️ Tecnologias
Node.js & Express.js

Better-SQLite3 (Performance SQL)

JSON Web Token (JWT)

Bcrypt (Segurança de dados)

Jest & Supertest (TDD/Testes)



🌱 Populando o Banco (Seed)
Para gerar automaticamente os 20 livros clássicos para testes e visualização:
node seed.js


🧪 Rodando os Testes
Mantenha a qualidade do código sempre em dia:
npm test


🔐 Autenticação
Esta API utiliza JWT. Após fazer o login, você receberá um token. Lembre-se de incluí-lo no Header de todas as rotas protegidas:
Authorization: Bearer <seu_token>


📌 Rotas da API
👤 Autenticação (Auth)
POST /register - Criar nova conta de usuário.

POST /login - Autenticar usuário e obter token de acesso.

📖 Livros (Protegido)
POST /books - Cadastrar um novo livro na coleção.

GET /books - Listar livros (Suporta filtros: page, limit, genre, sort, order).

PUT /books/:id - Atualizar informações de um livro existente.

DELETE /books/:id - Remover um livro da coleção.

GET /books-details - Listar livros com informações detalhadas de quem os cadastrou (JOIN).


📊 Parâmetros de Busca (Query Params)
page: Número da página (ex: 1)

limit: Itens por página (ex: 5)

sort: Campo para ordenar (ex: title, year)

order: Ordem da lista (ASC ou DESC)

genre: Filtrar por gênero específico (ex: Fantasia)



✅ Status Codes
200 → Sucesso

201 → Criado com sucesso

400 → Requisição inválida

401 → Não autorizado (Token ausente ou inválido)

404 → Recurso não encontrado

500 → Erro interno no servidor



👨‍💻 Autor
Marcos

📄 Licença
Este projeto foi desenvolvido para fins educacionais e de portfólio pessoal.
