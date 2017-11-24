# resources for Brynhildr
from flask import g
from flask_restful import reqparse, abort, Resource
from .models import Client as mClient
from .models import Transaction as mTransaction
from .models import User as mUser
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
        parser.add_argument('uid', type=int)
        args = parser.parse_args(strict=True)
        if args['uid'] != g.id:
            args['tr_id'] = g.id
        return json.dumps(mTransaction.fetch(args))

    @auth.login_required
    def put(self):
        parser = reqparse.RequestParser()
        parser.add_argument('amount', type=int)
        parser.add_argument('comm_type', type=int)
        parser.add_argument('t_type', type=int)
        parser.add_argument('c_id', type=int)
        args = parser.parse_args(strict=True)
        if args['comm_type'] == -1:
            args['comm_type'] = None
        args['uid'] = g.id
        return json.dumps(mTransaction.new(args))



class Clients(Resource):
    '''test resource, get all clients'''
    @auth.login_required
    def get(self):
        return json.dumps(mClient.fetchall())


class Client(Resource):
    @auth.login_required
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('uid', type=int)
        args = parser.parse_args(strict=True)
        app.logger.debug(g.id)
        if args['uid'] is None:
            args['uid'] = g.id
        return json.dumps(mClient.fetch(args))


class User(Resource):
    @auth.login_required
    def get(self):
        parser = reqparse.RequestParser()
        args = parser.parse_args(strict=True)
        app.logger.debug(g.id)
        args['uid'] = g.id
        result = mUser.fetch(args)
        for u in result:
            u.pop('pw')
        return json.dumps(result)


class Login(Resource):
    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('email', type=str)
        parser.add_argument('password', type=str)
        args = parser.parse_args(strict=True)
        user = mUser.fetch({'email': args['email']})
        app.logger.debug(user)
        if len(user) == 0:
            return json.dumps(errors['user_not_exists'])
        g.user = mUser(user[0])
        if g.user.verify_password(args['password']):
            token = generate_token(g.user.attributes['uid'])
            app.logger.debug(token)
            return json.dumps({'token': token.decode(), 'uid': g.user.attributes['uid'], 'type': g.user.attributes['type']})
        else:
            return json.dumps(errors['authentication_failed'])
