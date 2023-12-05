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
        let query =
            'SELECT ' +
            '   p.title, p.price, p.image, p.description, ' +
            '   t.name as type_name, ' +
            '   BIN_TO_UUID(p.id) as id ' +
            'FROM ' +
            '   products p ' +
            'JOIN ' +
            '   products_type pt ON p.id = pt.products_id ' +
            'JOIN ' +
            '   type t ON pt.type_id = t.id'

        if (type) {
            const lowerCaseType = type.toLowerCase()
            query += ' WHERE LOWER(t.name) = ?'
            const [result] = await connection.query(query, [lowerCaseType])
            return result
        }

        const [result] = await connection.query(query)
        return result
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
        const { name, title, price, image, description } = input

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

    static async delete({ id }) {
        try {
            const [result] = await connection.query('DELETE FROM products WHERE id = UUID_TO_BIN(?);', [id])

            if (result.affectedRows === 0) {
                return false
            }
            return true
        } catch (error) {
            console.log(error)
        }
    }

    static async update({ id, input }) {
        const { title, price, image, description } = input

        try {
            const [result] = await connection.query(
                'UPDATE products SET title = ?, price = ?, image = ?, description = ? WHERE id = UUID_TO_BIN(?)',
                [title, price, image, description, id]
            )

            // Chequea si la actualizacion fue exitosa
            if (result.affectedRows === 0) {
                return false // Ninguna fila fue actualizada lo que significa que no existe comida con esa id
            }

            const [updatedFood] = await connection.query(
                'SELECT name, title, price, image, description, BIN_TO_UUID(id) id FROM products WHERE id = UUID_TO_BIN(?)',
                id
            )

            return updatedFood[0]
        } catch (error) {
            console.error('Error updating food:', error)
            throw new Error('Error updating food')
        }
    }
}
