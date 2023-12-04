/* MYSQL
Creacion de tabla */
drop schema if exists products;
create schema if not exists products;
use products;

/* Tabla de Type */

CREATE TABLE IF NOT EXISTS type (
  id INT PRIMARY KEY auto_increment,
  name TEXT
);

Introduccion de Tipos de Productos

INSERT INTO type (name) values
('cake'),
('lunch'),
('drink'),
('coffee');

/* Tabla de Products */

CREATE TABLE IF NOT EXISTS products (
  id BINARY(16) PRIMARY KEY DEFAULT (UNHEX(REPLACE(uuid(),'-',''))),
  title VARCHAR(128) NOT NULL,
  name VARCHAR(128) NOT NULL,
  price INT NOT NULL CHECK (price >= 100 AND price <= 10000),
  image TEXT NOT NULL,
  description TEXT,
  type_id INT,
  FOREIGN KEY (type_id) REFERENCES type(id)
);

/* Tabla Products_type */

CREATE TABLE IF NOT EXISTS products_type (
  products_id BINARY(16),
  type_id INT,
  PRIMARY KEY (products_id, type_id),
  FOREIGN KEY (products_id) REFERENCES products(id),
  FOREIGN KEY (type_id) REFERENCES type(id)
);

/* Introduccion de Productos */
INSERT INTO products (image, name, price, title, description)
VALUES 
('https://i.pinimg.com/564x/78/5f/df/785fdf57bd6ca140b4fd09c3239c577e.jpg', 'Tiramisu', '800', 'Tiramisu', 'Un postre italiano que combina delicados bizcochos de soletilla mojados en café con una suave crema de mascarpone. Este postre es conocido por su equilibrio entre el amargor del café y la dulzura de la crema, creando una experiencia indulgente y adictiva para el paladar.'),
('https://i.pinimg.com/564x/2c/da/3f/2cda3f135cb613ccd1492d9bf4f602db.jpg', 'Torta de Frutilla', '950', 'Torta Frutilla', 'Un postre delicado que consta de varias capas de bizcocho esponjoso intercaladas con rellenos de crema batida y rodajas de frutillas maduras. El contraste entre la suavidad del bizcocho y la frescura y dulzura de las frutillas crea una experiencia gustativa excepcional.'),
('https://i.pinimg.com/564x/23/1f/31/231f318c54cb5a16ca517dcf0c51a889.jpg', 'Torta de Chocolate', '950', 'Torta Chocolate', 'Un deleite irresistible con capas de esponjoso bizcocho de chocolate y un generoso glaseado de chocolate. Un placer indulgente que hace las delicias de los amantes del cacao.'),
('https://i.pinimg.com/564x/33/e3/e8/33e3e8877543346107a9af5db7876819.jpg', 'Red Velvet', '950', 'Red Velvet', 'Un postre irresistible con su característico color rojo intenso, textura suave y un sutil sabor a cacao, complementado con un glaseado de queso crema. Un placer indulgente para los amantes del dulce.'),
('https://i.pinimg.com/564x/c5/5b/f4/c55bf40c72e2a8cf2c595175306e110e.jpg', 'Cheesecake de Frutos Rojos', '800', 'Cheesecake Rojo', 'Un equilibrio perfecto entre la suavidad del queso y la explosión de sabores de los frutos rojos. Un postre irresistible que cautiva los paladares.'),
('https://i.pinimg.com/564x/83/84/31/838431a3683cae9c1c3f37e41167377d.jpg', 'Cheesecake de Dulce de Leche', '900', 'Cheesecake Dulce', 'Una deliciosa combinación de suavidad y dulzura, donde el cremoso queso se une al dulce caramelo del dulce de leche. Un postre que seduce con cada bocado, equilibrando la riqueza y la indulgencia en cada porción.'),
('https://i.pinimg.com/564x/cf/bc/18/cfbc18ab76e1a7b51d6271c7e3b496be.jpg', 'Pizza Napolitana', '1200', 'Pizza Napolitana', 'Una obra maestra de la gastronomía italiana, conocida por su masa fina y aireada, perfectamente fermentada. Su sabor se realza con tomate fresco, mozzarella de búfala y fragantes hojas de albahaca. La cocción en horno de leña le da un borde ligeramente quemado y un toque ahumado, haciendo que esta pizza sea una experiencia culinaria inigualable.'),
('https://i.pinimg.com/564x/34/70/60/34706053725014d3aecae6996dac9d26.jpg', 'Papas con Cheddar', '900', 'Papas Cheddar', 'Delicioso manjar que consiste en papas doradas y crujientes cubiertas con queso cheddar derretido. La combinación de la textura crujiente de las papas y la cremosidad del queso cheddar crea un contraste perfecto de sabores y texturas.'),
('https://i.pinimg.com/564x/4a/37/0d/4a370de60a37be54e067765f94713e0f.jpg', 'Hamburguesa Simple', '900', 'Hamburgesa Simple', 'Una jugosa hamburguesa con carne a la parrilla, lechuga crujiente y rodajas de tomate fresco, todo en un suave pan. Una combinación fresca y sabrosa en cada bocado.'),
('https://i.pinimg.com/564x/bd/27/27/bd2727dcfa65dab41471e9d6fcfa83f3.jpg', 'Doble Melt', '3000', 'Doble Melt', 'Una explosión de sabor con dos jugosas carnes a la parrilla, abundante queso derretido, crujiente lechuga y nuestra especial salsa secreta, todo entre dos panes tostados. Un festín irresistible para los amantes de las hamburguesas y el queso.'),
('https://i.pinimg.com/564x/2c/e8/f5/2ce8f5f86c8adcd4b9112a4c885fe61e.jpg', 'Tiple Melt', '3600', 'Triple Melt', 'Hamburguesa Triple Melt: Un festín de sabor con tres carnes a la parrilla, queso fundido y una mezcla irresistible de ingredientes. Es una explosión de sabores que te cautiva desde el primer bocado.'),
('https://i.pinimg.com/564x/fc/62/e2/fc62e28dc420e87d0f309e8012cbda95.jpg', 'Triple Bacon', '1950', 'Triple Bacon', 'Una deliciosa explosión de sabor que combina tres jugosas hamburguesas con abundante bacon crujiente y queso derretido en un pan tierno. La elección perfecta para los amantes de la carne y el bacon.'),
('https://i.pinimg.com/564x/17/5f/7d/175f7d30da96e2e05cc068b8d02b9ae2.jpg', 'Mimosa', '850', 'Mimosa', 'Un refrescante cóctel que combina jugo de naranja recién exprimido con champagne o vino espumoso. Su color dorado y burbujeante lo hace perfecto para brindar en ocasiones especiales o disfrutar en un brunch relajado.'),
('https://i.pinimg.com/564x/34/b7/eb/34b7eb5b61fe0b55a590b4900b7fc51d.jpg', 'Piña Colada', '900', 'Piña Colada', 'Un icónico cóctel tropical que combina jugo de piña fresca, crema de coco y ron blanco. Su sabor es una deliciosa fusión de dulzura y cremosidad, con un toque de ron que le añade un suave toque alcohólico. Es una opción refrescante y perfecta para relajarse en un entorno tropical o para disfrutar como un refresco veraniego.'),
('https://i.pinimg.com/736x/48/68/6f/48686ffd357be25be4b553fd3de20dc0.jpg', 'Margarita', '800', 'Margarita', 'Un cóctel clásico y refrescante que combina tequila, licor de naranja y jugo de limón, servido en un vaso con borde de sal. Con su equilibrio entre lo dulce y lo ácido, es el acompañante perfecto para relajarse y disfrutar del momento.'),
('https://i.pinimg.com/564x/bb/59/1d/bb591dc8cdbc24d301e45f44dcebaf9b.jpg', 'Mojito', '950', 'Mojito', 'Un cóctel refrescante que combina el sabor cítrico de la lima con la frescura de la menta, mezclado con ron y soda, creando una bebida equilibrada y deliciosamente revitalizante. Perfecta para relajarse en cualquier ocasión.'),
('https://i.pinimg.com/564x/38/e5/6f/38e56fd5947584395ebf2fe5d075598a.jpg', 'Fernet', '900', 'Fernet', 'Un amargo licor italiano con una mezcla única de hierbas y especias que crea un sabor intenso y complejo. Ideal como aperitivo o digestivo.'),
('https://i.pinimg.com/564x/33/91/c2/3391c26924a46b3c23fde2bb0977d8aa.jpg', 'Cosmopolitan', '950', 'Cosmopolitan', 'Un cóctel elegante y refrescante, mezcla vodka con jugo de arándano, licor de naranja y un toque de jugo de lima. Su color rosado brillante y sabor equilibrado lo convierten en una bebida icónica y sofisticada.'),
('https://i.pinimg.com/564x/6d/9e/aa/6d9eaaee432f94605d9ddb20a8bd5745.jpg', 'Frapuccino de Crema y Limón', '900', 'Frapuccino de Crema y Limón', 'Una bebida refrescante que combina limón cítrico con crema suave y café o leche, con una capa de crema montada encima para un toque indulgente. Un equilibrio perfecto entre lo dulce y lo ácido.'),
('https://i.pinimg.com/564x/ce/bc/22/cebc22b0e61a207fa53e756b966f0a45.jpg', 'Café Espresso con Crema', '850', 'Café Espresso con Crema', 'Una bebida de café que combina la intensidad del espresso con la suavidad y la textura cremosa de la crema. Se obtiene al extraer un espresso de gran calidad y luego coronarlo con una capa de crema espesa que se forma naturalmente durante la preparación. Esta crema aporta un contraste perfecto a la intensidad del café, creando una experiencia indulgente para los amantes del café que buscan un equilibrio entre el sabor fuerte y la suavidad aterciopelada en cada sorbo.'),
('https://i.pinimg.com/564x/1b/89/3b/1b893b4abfc5e377467575aa178d7ac9.jpg', 'Café Canela y Cacao', '800', 'Café Canela', 'Mezcla que combina la robustez del café con la calidez especiada de la canela y la indulgencia del cacao. Una experiencia de sabor reconfortante y deliciosamente equilibrada en cada sorbo.'),
('https://i.pinimg.com/564x/94/4d/19/944d19f4e38dca4fa7af9da179aa866f.jpg', 'Café Matcha', '950', 'Café Matcha', 'Una vibrante y saludable bebida verde, elaborada con finas hojas de té matcha molido, que ofrece un sabor fresco, terroso y lleno de energía. Un estimulante natural que fusiona la tradición japonesa con un toque contemporáneo.'),
('https://i.pinimg.com/564x/44/a2/87/44a2879014d5a910b1d759aa7b126e63.jpg', 'Café Crema y Cacao', '900', 'Café Crema', 'Una deliciosa fusión que combina la intensidad del café con la suavidad de la crema y el toque seductor del cacao. Una experiencia indulgente que equilibra sabores y te envuelve en un abrazo de sabor y textura.'),
('https://i.pinimg.com/564x/f1/c0/35/f1c0359943c32bb15f497fb20ba76538.jpg', 'Café Caramelo', '950', 'Café Caramelo', ' Un elixir dulce y reconfortante, donde el aroma y sabor del café se mezcla armoniosamente con notas suaves y ricas de caramelo. Una indulgencia líquida que deleita los sentidos.');

/* Conexion de Tipos y Productos */
-- Cake
INSERT INTO products_type (products_id, type_id)
SELECT p.id, t.id
FROM products p
JOIN type t ON p.title IN ('Tiramisu', 'Torta Frutilla', 'Torta Chocolate', 'Red Velvet', 'Cheesecake Rojo', 'Cheesecake Dulce') AND t.name = 'cake';

-- Lunch
INSERT INTO products_type (products_id, type_id)
SELECT p.id, t.id
FROM products p
JOIN type t ON p.title IN ('Pizza Napolitana', 'Papas Cheddar', 'Hamburgesa Simple', 'Doble Melt', 'Triple Melt', 'Triple Bacon') AND t.name = 'lunch';

-- Drink
INSERT INTO products_type (products_id, type_id)
SELECT p.id, t.id
FROM products p
JOIN type t ON p.title IN ('Mimosa', 'Piña Colada', 'Margarita', 'Mojito', 'Fernet', 'Cosmopolitan') AND t.name = 'drink';

-- Coffee
INSERT INTO products_type (products_id, type_id)
SELECT p.id, t.id
FROM products p
JOIN type t ON p.title IN ('Frapuccino de Crema y Limón', 'Café Espresso con Crema', 'Café Canela', 'Café Matcha', 'Café Crema', 'Café Caramelo') AND t.name = 'coffee';


/* (Delet colum (solo usar si se quiere borrar Name))
alter table products drop column name 

(Select)
select BIN_TO_UUID(products_id) as 'Products ID', type_id as 'Type ID' from Products_type */