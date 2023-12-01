import mysql from 'mysql2/promise'

const config = {
    host: 'localhost',
    user: 'root',
    password: 'admin',
    database: 'products'
}

const connection = await mysql.createConnection(config)

export class FoodModel {
    static async getAll({ type }) {
        const [foods] = await connection.query(
            'SELECT title, name, price, image, description, BIN_TO_UUID(id) as id from products;'
        )

        return foods
    }

    static async getById({ id }) {
        const [foods] = await connection.query(
            'select name, title, price, image, description, BIN_TO_UUID(id) as id from products WHERE id = UUID_TO_BIN(?);',
            [id]
        )
        if (foods.length === 0) return null

        return foods[0]
    }

    static async create({ input }) {
        console.log('Input Object:', input)
        const { type: typeInput, name, title, price, image, description } = input

        const [uuidResult] = await connection.query('SELECT UUID() uuid;')
        const [{ uuid }] = uuidResult

        try {
            await connection.query(
                `INSERT INTO products (id, name, title, price, image, description) VALUES (UUID_TO_BIN("${uuid}"), ?, ?, ?, ?, ?)`,
                [name, title, price, image, description]
            )
        } catch (error) {
            console.log(error)
        }
        const [foods] = await connection.query(
            'SELECT name, title, price, image, description, BIN_TO_UUID(id) id FROM products WHERE id = UUID_TO_BIN(?);',
            uuid
        )
        return foods[0]
    }

    static async delete({ id }) {}

    static async update({ id, input }) {}
}
