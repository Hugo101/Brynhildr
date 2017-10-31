# Application main file
from flask import Flask
from flask import request
from flask import session
from flask import g
from flask import redirect
from flask import url_for
from flask import abort
from flask import render_template
from flask import flash
from flask_mysqldb import MySQL
from flask_restful import Api

app = Flask(__name__) #
app.config.from_object('config') #
mysql = MySQL(app)
api = Api(app)

from . import views
app.add_url_rule('/', view_func=views.main)
from . import resources
api.add_resource(resources.Clients , '/clients', endpoint='clients')
