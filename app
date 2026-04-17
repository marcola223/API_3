require("dotenv").config();

const express = require("express");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const db = require("./database"); // Certifique-se que o seu database.js cria as tabelas 'books' e 'users'

const app = express();
app.use(express.json());

const PORT = process.env.PORT || 3000;
const SECRET = process.env.TOKEN_SECRET || "sua_chave_secreta";

// --- Middleware de Autenticação ---
const authenticate = (req, res, next) => {
  const authHeader = req.headers["authorization"];

  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return res.status(401).json({ error: "Token missing" });
  }

  const token = authHeader.split(" ")[1];

  jwt.verify(token, SECRET, (err, user) => {
    if (err) return res.status(403).json({ error: "Invalid token" });
    req.user = user;
    next();
  });
};

// --- Rotas de Autenticação ---
app.post("/register", async (req, res) => {
  const { username, password } = req.body;
  if (!username || !password) return res.status(400).json({ error: "Missing fields" });

  const hash = await bcrypt.hash(password, 10);
  try {
    db.prepare("INSERT INTO users (username, password) VALUES (?, ?)").run(username, hash);
    res.status(201).json({ message: "User created" });
  } catch {
    res.status(400).json({ error: "User already exists" });
  }
});

app.post("/login", async (req, res) => {
  const { username, password } = req.body;
  const user = db.prepare("SELECT * FROM users WHERE username = ?").get(username);

  if (!user) return res.status(404).json({ error: "User not found" });
  const valid = await bcrypt.compare(password, user.password);
  if (!valid) return res.status(401).json({ error: "Invalid password" });

  const token = jwt.sign({ id: user.id }, SECRET, { expiresIn: "1h" });
  res.json({ token });
});

// --- CRUD de Livros (Books) ---

// CREATE
app.post("/books", authenticate, (req, res) => {
  const { title, genre, year } = req.body;
  if (!title || !genre) return res.status(400).json({ error: "Title and Genre are required" });

  db.prepare("INSERT INTO books (title, genre, year, user_id) VALUES (?, ?, ?, ?)").run(
    title,
    genre,
    year || null,
    req.user.id
  );

  res.status(201).json({ message: "Book created" });
});

// READ (Com Filtros, Ordenação e Paginação)
app.get("/books", (req, res) => {
  const { page = 1, limit = 5, genre, sort = "id", order = "asc" } = req.query;
  const offset = (page - 1) * limit;

  // Proteção básica contra SQL Injection manual na ordenação
  const validOrders = ["asc", "desc"];
  const finalOrder = validOrders.includes(order.toLowerCase()) ? order : "asc";

  let query = "SELECT * FROM books";
  let params = [];

  if (genre) {
    query += " WHERE genre = ?";
    params.push(genre);
  }

  query += ` ORDER BY ${sort} ${finalOrder} LIMIT ? OFFSET ?`;
  params.push(Number(limit), Number(offset));

  const books = db.prepare(query).all(...params);

  res.json({
    page: Number(page),
    limit: Number(limit),
    count: books.length,
    data: books,
  });
});

// UPDATE
app.put("/books/:id", authenticate, (req, res) => {
  const { title, genre, year } = req.body;
  const { id } = req.params;

  const result = db
    .prepare("UPDATE books SET title = ?, genre = ?, year = ? WHERE id = ?")
    .run(title, genre, year, id);

  if (result.changes === 0) return res.status(404).json({ error: "Book not found" });
  res.json({ message: "Book updated" });
});

// DELETE
app.delete("/books/:id", authenticate, (req, res) => {
  const { id } = req.params;
  const result = db.prepare("DELETE FROM books WHERE id = ?").run(id);

  if (result.changes === 0) return res.status(404).json({ error: "Book not found" });
  res.json({ message: "Book deleted" });
});

// READ WITH JOIN (Livros com nome do usuário que cadastrou)
app.get("/books-details", authenticate, (req, res) => {
  const data = db.prepare(`
    SELECT books.id, books.title, books.genre, users.username as created_by
    FROM books
    JOIN users ON books.user_id = users.id
  `).all();

  res.json(data);
});

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
