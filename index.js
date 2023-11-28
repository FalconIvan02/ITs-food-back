const express = require('express')

const app = express()

const PORT = process.env.PORT ?? 3000

const foodJSON = require('./food/food.json')

app.use(express.json())

app.listen(PORT, () => {
    console.log(`Server listening on port http://localhost:${PORT}`)
})

app.get('/', (req, res) => {
    res.send('<h1>ITs Food</h1>')
})
app.get('/food', (req, res) => {
    res.json(foodJSON)
})
