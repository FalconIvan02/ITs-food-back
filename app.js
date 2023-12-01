import express, { json } from 'express'
import { foodRouter } from './routes/foodrt.js'
import cors from 'cors'

const app = express()

app.disable('x-powered-by') // Deshabilitar el headear X-Powered-By: Express

app.use(json())
app.use(cors())

const PORT = process.env.PORT ?? 3000

// Handle CORS for all routes
app.options('*', (req, res) => {
    res.header('Access-Control-Allow-Origin', '*')
    res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, PATCH, DELETE')
    res.send()
})

app.get('/', (req, res) => {
    res.json({ message: 'Bienvenido a ITS food' })
})

app.use('/foods', foodRouter)

app.listen(PORT, () => {
    console.log(`Server listening on port http://localhost:${PORT}`)
})
