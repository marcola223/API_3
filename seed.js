const db = require("./database");
const books = [
    ["O Senhor dos Anéis", "Fantasia", 1954],
    ["1984", "Distopia", 1949],
    ["O Pequeno Príncipe", "Fábula", 1943],
    ["Dom Casmurro", "Clássico", 1899],
    ["O Hobbit", "Fantasia", 1937],
    ["A Guerra dos Tronos", "Fantasia", 1996],
    ["Orgulho e Preconceito", "Romance", 1813],
    ["Crime e Castigo", "Psicológico", 1866],
    ["Cem Anos de Solidão", "Realismo Mágico", 1967],
    ["O Alquimista", "Drama", 1988],
    ["O Iluminado", "Terror", 1977],
    ["Duna", "Ficção Científica", 1965],
    ["Ensaio sobre a Cegueira", "Ficção", 1995],
    ["Grande Sertão: Veredas", "Clássico", 1956],
    ["O Nome da Rosa", "Mistério", 1980],
    ["A Metamorfose", "Ficção", 1915],
    ["Moby Dick", "Aventura", 1851],
    ["Drácula", "Terror", 1897],
    ["Sherlock Holmes: Um Estudo em Vermelho", "Mistério", 1887],
    ["Frankenstein", "Terror", 1818]
];

const insertMany = db.transaction((data) => {
    for (const book of data) {
  
        insert.run(book[0], book[1], book[2], 1);
    }
});

try {
    console.log("Iniciando Seed de livros...");
    insertMany(books);
    console.log(" Seed concluído com sucesso: 20 livros inseridos.");
} catch (error) {
    console.error(" Erro ao popular o banco:", error.message);
}
