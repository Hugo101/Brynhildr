from .brynhildr import app

@app.route("/")
def main():
    return "<p>An Oil Transactin System based on a RDBMS!</p>"
