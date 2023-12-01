import { randomUUID } from 'node:crypto'
import { readJSON } from '../../utils.js'

const foods = readJSON('./food/food.json')

export class FoodModel {
    static async getAll({ type }) {
        if (type) {
            return foods.filter((food) => food.type.some((f) => f.toLowerCase() === type.toLowerCase()))
        }
        return foods
    }

    static async getById({ id }) {
        const food = foods.find((food) => food.id === id)
        return food
    }

    static async create({ input }) {
        const newFood = {
            id: randomUUID(),
            ...input
        }
        foods.push(newFood)
        return newFood
    }

    static async delete({ id }) {
        const foodIndex = foods.findIndex((food) => food.id === id)
        if (foodIndex === -1) return false

        foods.splice(foodIndex, 1)
        return true
    }

    static async update({ id, input }) {
        const foodIndex = foods.findIndex((food) => food.id === id)
        if (foodIndex === -1) return false

        foods[foodIndex] = {
            ...foods[foodIndex],
            ...input
        }

        return foods[foodIndex]
    }
}
