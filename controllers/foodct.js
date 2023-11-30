import { FoodModel } from '../models/food.js'
import { validateFood, validatePartialFood } from '../schemas/foods.js'

export class foodController {
    static async getAll(req, res) {
        const { type } = req.query

        const foods = await FoodModel.getAll({ type })
        res.json(foods)
    }

    static async getById(req, res) {
        const { id } = req.params
        const food = await FoodModel.getById({ id })
        if (food) return res.json(food)
        res.status(404).json({ message: 'Food not found' })
    }

    static async create(req, res) {
        const result = validateFood(req.body)

        if (!result.success) {
            return res.status(400).json({ error: JSON.parse(result.error.message) })
        }

        const newFood = await FoodModel.create({ input: result.data })

        res.status(201).json(newFood)
    }

    static async delete(req, res) {
        const { id } = req.params

        const result = await FoodModel.delete({ id })

        if (result === false) {
            return res.status(404).json({ message: 'food not found' })
        }

        return res.json({ message: 'Food deleted successfully' })
    }

    static async update(req, res) {
        const result = validatePartialFood(req.body)
        const { id } = req.params

        const updatedFood = await FoodModel.update({ id, input: result.data })

        if (!result.success) {
            return res.status(400).json({ error: JSON.parse(result.error.message) })
        }

        if (!updatedFood) {
            // Pelicula no encontrada durante la actualización

            return res.status(404).json({ message: 'Food not found' })
        }

        return res.json(updatedFood)
    }
}
