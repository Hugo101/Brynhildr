# resources for Brynhildr
from flask_restful import reqparse, abort, Resource
from .models import Client
from .brynhildr import api

class Clients(Resource):
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
        return Client.fetch(args)
