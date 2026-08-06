from flask import Flask, render_template, request, redirect
import sqlite3

designated_donut = Flask(__name__)
designated_donut.secret_key = "your_secret_key"

DATABASE = "/Users/aman/practice sql/Designated Donut/Designated_Donut.db"


@designated_donut.route("/", methods=["GET", "POST"])
def login_page():

    if request.method == "POST":

        email = request.form["email"]
        password = request.form["password"]

        conn = sqlite3.connect(DATABASE)
        c = conn.cursor()

        user = c.execute("""
            SELECT * FROM Users
            WHERE email = ? AND password_hash = ?
        """, (email, password)).fetchone()

        conn.close()

        if user:
            return redirect("/home")

        else:
            return render_template(
                "login.html",
                error="Account does not exist. Please create one."
            )

    return render_template("login.html")


@designated_donut.route("/home")
def home_page():
    return render_template("index.html")


@designated_donut.route("/about")
def about_page():
    return render_template("about.html")


if __name__ == "__main__":
    designated_donut.run(debug=True)