import express, { json } from 'express'
import { foodRouter } from './routes/foodrt.js'

const app = express()

app.disable('x-powered-by') // Deshabilitar el headear X-Powered-By: Express

app.use(json())

const PORT = process.env.PORT ?? 3000

app.get('/', (req, res) => {
    res.json({ message: 'Bienvenido a ITS food' })
})

app.use('/foods', foodRouter)

app.listen(PORT, () => {
    console.log(`Server listening on port http://localhost:${PORT}`)
})
