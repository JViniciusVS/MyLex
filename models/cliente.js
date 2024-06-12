const mongoose = require('mongoose');

const clienteSchema = new mongoose.Schema({
  nomeCompleto: String,
  email: String,
  senha: String,
  cpf: String
});

clienteSchema.index({
  "$**": "text",
});

module.exports = mongoose.model('Cliente', clienteSchema);