from flask import Flask, render_template
import mysql.connector

designated_donuts = Flask(__name__, template_folder = "templates")

con=mysql.connector.connect(
)


 


@designated_donuts.route("/")
def login_page():
    return render_template("login.html")

@designated_donuts.route("/home")
def home_page():
    return render_template("index.html")

@designated_donuts.route("/about")
def about_page():
    return render_template("about.html")

@designated_donuts.route("/order")
def order_page(): 
    return render_template("order.html")

@designated_donuts.route("/reviews")
def review_page():
    return render_template("review.html")

@designated_donuts.route("/feedback")
def feedback_page():
    return render_template("feedback.html")






if __name__ == "__main__":
    print("\n\033[1;94m-[LOADING WEBSITE...] -\033[0m\n")
    designated_donuts.run(debug=True, port=8000)