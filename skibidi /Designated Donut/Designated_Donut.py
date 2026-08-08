from flask import Flask, render_template, request, redirect, url_for, flash, session
from werkzeug.security import generate_password_hash, check_password_hash
import sqlite3


designated_donut = Flask(__name__)
designated_donut.secret_key = 'your_secret_key'  # Added quotes
DATABASE = "/Users/aman/practice odheihdeihde/Designated Donut/Designated_Donut.db"  # Added quotes


@designated_donut.route("/", methods=["GET", "POST"])
def login_page():

    if request.method == "POST":

        email = request.form.get("email")
        password = request.form.get("password")

        conn = sqlite3.connect(DATABASE)
        c = conn.cursor()

        user = c.execute("""
            SELECT * FROM Users
            WHERE email = ?
        """, (email,)).fetchone()

        if user:
            if user[3].startswith("scrypt:"):
                password_correct = check_password_hash(user[3], password)
            else:
                password_correct = (user[3] == password)

            if password_correct:
                session["user_id"] = user[0]
                print("Logged in as user:", session["user_id"])
                conn.close()
                return redirect(url_for("home_page"))
            
        conn.close()
        return render_template(
            "login.html",
            error="Account not found. Please create one."
        )

    return render_template("login.html")


@designated_donut.route('/signup', methods=['POST'])
def signup():

    conn = sqlite3.connect(DATABASE)
    c = conn.cursor()

    name = request.form.get('name')
    email = request.form.get('email')
    password = request.form.get('password')
    confirm_password = request.form.get('confirm_password')

    if password != confirm_password:
        conn.close()
        return render_template(
            "login.html",
            error="Passwords do not match."
        )

    existing_user = c.execute("""
        SELECT * FROM Users
        WHERE email = ?
    """, (email,)).fetchone()

    if existing_user:
        conn.close()
        return render_template(
            "login.html",
            error="Account already exists. Please sign in."
        )

    last_user = c.execute("""
        SELECT MAX(user_id) FROM Users
    """).fetchone()

    if last_user[0] is None:
        new_user_id = 1
    else:
        new_user_id = last_user[0] + 1

    hashed_password = generate_password_hash(password)

    c.execute("""
        INSERT INTO Users
        (user_id, name, email, password_hash)
        VALUES (?, ?, ?, ?)
    """, (new_user_id, name, email, hashed_password))

    conn.commit()
    conn.close()

    return redirect(url_for('login_page'))


@designated_donut.route("/logout")
def logout():

    session.clear()

    return redirect(url_for("login_page"))


@designated_donut.route("/cart")
def cart_page():

    conn = sqlite3.connect(DATABASE)
    c = conn.cursor()

    cart_items = c.execute("""
        SELECT
            Products.product_id,
            Products.product_name,
            Products.price * Cart_Items.quantity AS total_price,
            Cart_Items.quantity
        FROM Cart_Items
        JOIN Products
        ON Cart_Items.product_id = Products.product_id
        WHERE Cart_Items.user_id = ?
    """, (session["user_id"],)).fetchall()

    conn.close()

    return render_template("cart.html", cart_items=cart_items)


@designated_donut.route("/add_to_cart", methods=["POST"])
def add_to_cart():

    product_id = request.form.get("product_id")
    user_id = session["user_id"]

    conn = sqlite3.connect(DATABASE)
    c = conn.cursor()

    # Check if the product is already in the user's cart
    existing = c.execute("""
        SELECT quantity
        FROM Cart_Items
        WHERE user_id = ? AND product_id = ?
    """, (user_id, product_id)).fetchone()

    if existing:
        # Increase the quantity by 1
        c.execute("""
            UPDATE Cart_Items
            SET quantity = quantity + 1
            WHERE user_id = ? AND product_id = ?
        """, (user_id, product_id))
    else:
        # Add the product for the first time
        c.execute("""
            INSERT INTO Cart_Items
            (user_id, product_id, quantity)
            VALUES (?, ?, ?)
        """, (user_id, product_id, 1))

    conn.commit()
    conn.close()

    return redirect(url_for("cart_page"))


@designated_donut.route('/home')
def home_page():
    return render_template('index.html')


@designated_donut.route('/about')
def about_page():
    return render_template('about.html')


@designated_donut.route('/order')
def order_page():

    conn = sqlite3.connect(DATABASE)
    c = conn.cursor()

    products = c.execute("""
        SELECT * FROM Products
    """).fetchall()

    conn.close()

    return render_template("order.html", products=products)


@designated_donut.route("/add_review", methods=["POST"])
def add_review():

    user_id = session["user_id"]
    review_text = request.form.get("review_text")
    rating = request.form.get("rating")
    review_date = request.form.get("review_date")

    conn = sqlite3.connect(DATABASE)
    c = conn.cursor()

    last_review = c.execute("""
        SELECT MAX(review_id)
        FROM Reviews
    """).fetchone()

    if last_review[0] is None:
        new_review_id = 10001
    else:
        new_review_id = last_review[0] + 1

    c.execute("""
        INSERT INTO Reviews
        (review_id, user_id, review_text, rating, review_date)
        VALUES (?, ?, ?, ?, ?)
    """, (
        new_review_id,
        user_id,
        review_text,
        rating,
        review_date
    ))

    conn.commit()
    conn.close()

    return redirect(url_for("review_page"))


@designated_donut.route('/review')
def review_page():

    conn = sqlite3.connect(DATABASE)
    c = conn.cursor()

    reviews = c.execute("""
        SELECT
            Users.name,
            Reviews.review_text,
            Reviews.rating,
            Reviews.review_date
        FROM Reviews
        JOIN Users
        ON Reviews.user_id = Users.user_id
        ORDER BY Reviews.review_date DESC
    """).fetchall()

    conn.close()

    return render_template(
        "review.html",
        reviews=reviews
    )


@designated_donut.route('/feedback')
def feedback_page():
    return render_template('feedback.html')


if __name__ == '__main__':
    designated_donut.run(debug=True, port=8000)