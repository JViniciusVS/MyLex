const express = require('express');
const axios = require('axios');
const router = express.Router();
router.post('/chat', async (req, res) => {
    try {
        const response = await axios.post('https://api-gemini-1ck0.onrender.com/chat', req.body);
        res.send(response.data); 
    } catch (error) {
        console.error('Erro ao conectar com o chatbot:', error);
        res.status(500).send({ error: 'Erro ao conectar com o chatbot' });
    }
});
module.exports = router;