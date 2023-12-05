import mysql from "mysql2/promise";

const config = {
  host: "localhost",
  user: "root",
  password: "wew03327",
  database: "products",
};

const connection = await mysql.createConnection(config);

export class FoodModel {
  static async getAll({ type }) {
    let query =
      "SELECT " +
      "   p.title, p.price, p.image, p.description, " +
      "   t.name as type, " +
      "   BIN_TO_UUID(p.id) as id " +
      "FROM " +
      "   products p " +
      "JOIN " +
      "   products_type pt ON p.id = pt.products_id " +
      "JOIN " +
      "   type t ON pt.type_id = t.id";

    if (type) {
      const lowerCaseType = type.toLowerCase();
      query += " WHERE LOWER(t.name) = ?";
      const [result] = await connection.query(query, [lowerCaseType]);
      return result;
    }

    const [result] = await connection.query(query);
    return result;
  }

  static async getById({ id }) {
    const [foods] = await connection.query(
      "select name, title, price, image, description, BIN_TO_UUID(id) as id from products WHERE id = UUID_TO_BIN(?);",
      [id]
    );
    if (foods.length === 0) return null;

    return foods[0];
  }

  static async create({ input }) {
    console.log(input);
    const { title, name, price, image, description, type } = input;

    const result = await connection.query(
      `
        INSERT INTO products (title, name, price, image, description) 
        VALUES (?,?,?,?,?)`,
      [title, name, price, image, description]
    );
    for (const typ of type) {
      console.log(typ);
      await connection.query(
        `
              INSERT INTO products_type (products_id, type_id)
              SELECT p.id, t.id
              FROM products p
              JOIN type t ON p.name = ?
              WHERE t.name = ? AND NOT EXISTS (
                SELECT 1
                FROM products_type pt
                WHERE pt.products_id = p.id AND pt.type_id = t.id
              )`,
        [name, typ]
      );
    }

    if (result === null) {
      return false;
    }

    console.log(result);
    return result;
  }

  static async delete({ id }) {
    try {
      const [result] = await connection.query(
        "DELETE FROM products WHERE id = UUID_TO_BIN(?);",
        [id]
      );

      if (result.affectedRows === 0) {
        return false;
      }
      return true;
    } catch (error) {
      console.log(error);
    }
  }

  static async update({ id, input }) {
    const { title, price, image, description } = input;

    try {
      const [result] = await connection.query(
        "UPDATE products SET title = ?, price = ?, image = ?, description = ? WHERE id = UUID_TO_BIN(?)",
        [title, price, image, description, id]
      );

      // Chequea si la actualizacion fue exitosa
      if (result.affectedRows === 0) {
        return false; // Ninguna fila fue actualizada lo que significa que no existe comida con esa id
      }

      const [updatedFood] = await connection.query(
        "SELECT name, title, price, image, description, BIN_TO_UUID(id) id FROM products WHERE id = UUID_TO_BIN(?)",
        id
      );

      return updatedFood[0];
    } catch (error) {
      console.error("Error updating food:", error);
      throw new Error("Error updating food");
    }
  }
}