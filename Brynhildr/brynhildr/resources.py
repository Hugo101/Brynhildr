# resources for Brynhildr
from flask import g
from flask_restful import reqparse, abort, Resource
from .models import Client, Transaction, User
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
        args['uid'] = g.id
        return json.dumps(Transaction.fetch(args))

class Clients(Resource):
    @auth.login_required
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('uid', type=int)
        args = parser.parse_args(strict=True)
        app.logger.debug(g.id)
        args['uid'] = g.id
        return json.dumps(Client.fetch(args))

class Login(Resource):
    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('email', type=str)
        parser.add_argument('password', type=str)
        args = parser.parse_args(strict=True)
        user = User.fetch({'email': args['email']})
        app.logger.debug(user)
        if len(user) == 0:
            return json.dumps(errors['user_not_exists'])
        g.user = User(user[0])
        if g.user.verify_password(args['password']):
            token = generate_token(g.user.attributes['uid'])
            app.logger.debug(token)
            return json.dumps({'token': token.decode(), 'uid': g.user.attributes['uid'], 'type': g.user.attributes['type']})
        else:
            return json.dumps(errors['authentication_failed'])
