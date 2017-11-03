# resources for Brynhildr
from flask import g
from flask_restful import reqparse, abort, Resource
from .models import Client, Transaction
from .brynhildr import api, app, auth
from .auth import generate_token
import json, jsonify

errors = {
    'authentication_failed' : {
        'message': 'Authentication failed.',
        'status': 535,
    },
    'user_not_exists' : {
        'message': 'User not exists.',
        'status': 409,
    },
}

class Transactions(Resource):
    @auth.login_required
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('t_id', type=int)
        args = parser.parse_args(strict=True)
        args['c_id'] = g.id
        return json.dumps(Transaction.fetch(args))

class Clients(Resource):
    @auth.login_required
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('c_id', type=int)
        parser.add_argument('c_id>', type=int)
        parser.add_argument('last_name', type=str)
        parser.add_argument('first_name', type=str)
        parser.add_argument('p_num', type=str)
        parser.add_argument('cp_num', type=str)
        parser.add_argument('email', type=str)
        parser.add_argument('zipcode', type=str)
        parser.add_argument('state', type=str)
        args = parser.parse_args(strict=True)
        app.logger.debug(g.id)
        args['c_id'] = g.id
        return json.dumps(Client.fetch(args))

class Login(Resource):
    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('email', type=str)
        parser.add_argument('password', type=str)
        args = parser.parse_args(strict=True)
        client = Client.fetch({'email': args['email']})
        app.logger.debug(client)
        if len(client) == 0:
            return json.dumps(errors['user_not_exists'])
        g.user = Client(client[0])
        if g.user.verify_password(args['password']):
            token = generate_token(g.user.attributes['c_id'])
            app.logger.debug(token)
            return json.dumps({'token': token.decode(), 'c_id': g.user.attributes['c_id']})
        else:
            return json.dumps(errors['authentication_failed'])
