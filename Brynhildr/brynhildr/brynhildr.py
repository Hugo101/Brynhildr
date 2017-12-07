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
from flask_cors import CORS
from itsdangerous import TimedJSONWebSignatureSerializer as JWT
from flask_httpauth import HTTPTokenAuth

app = Flask(__name__) #
app.config.from_object('config') #
mysql = MySQL(app)
api = Api(app)
cors = CORS(app, resources={r"/api/*": {"origins": "http://localhost:8000"}})
jwt = JWT(app.config['SECRET_KEY'], expires_in=7200)
auth = HTTPTokenAuth('Iceland')


from . import views
app.add_url_rule('/', view_func=views.main)
from . import resources

# get client by id
api.add_resource(resources.Client , '/api/client', endpoint='client')
# get user by id
api.add_resource(resources.User , '/api/user', endpoint='user')
# get transactions
api.add_resource(resources.Transactions , '/api/transactions', endpoint='transactions')
# cancel transactions
api.add_resource(resources.Transaction , '/api/transaction', endpoint='transaction')
# login
api.add_resource(resources.Login , '/api/login', endpoint='login')
# all clients api
api.add_resource(resources.Clients , '/api/clients', endpoint='clients')
api.add_resource(resources.Agg , '/api/agg', endpoint='agg')
