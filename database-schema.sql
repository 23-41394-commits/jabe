-- Users table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('customer', 'staff', 'admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Menu items table
CREATE TABLE IF NOT EXISTS menu_items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    image_url TEXT,
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Orders table
CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    customer_name VARCHAR(100) NOT NULL,
    status VARCHAR(20) DEFAULT 'Preparing' CHECK (status IN ('Preparing', 'Out for Delivery', 'Delivered')),
    total_amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Order items table
CREATE TABLE IF NOT EXISTS order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(id),
    menu_item_id INTEGER REFERENCES menu_items(id),
    quantity INTEGER NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- Insert sample data
INSERT INTO users (username, password, role) VALUES 
('customer1', 'pass123', 'customer'),
('staff1', 'pass123', 'staff'),
('admin', 'admin123', 'admin');

INSERT INTO menu_items (name, price, image_url) VALUES 
('1-pc Chickenjoy w/ Rice', 82, 'https://images.unsplash.com/photo-1562967914-608f82629710?w=200&h=200&fit=crop'),
('2-pc Burger Steak', 105, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=200&h=200&fit=crop'),
('Jolly Spaghetti', 65, 'https://images.unsplash.com/photo-1598866594230-a7c12756260f?w=200&h=200&fit=crop'),
('Yumburger', 45, 'https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?w=200&h=200&fit=crop');