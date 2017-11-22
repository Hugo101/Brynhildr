# models in Brynhildr
from .query import Queries
from .brynhildr import mysql, app
from datetime import date
from .utils import parse_emailaddr

class User(object):
    '''model for User'''
    attributes = {}
    attributes['uid']= None
    attributes['email'] = None
    attributes['pw'] = None
    attributes['type'] = None # Type 0:client, 1:trader, 2:manager
    def __init__(self, args):
        '''construct function'''
        self.attributes['uid']= args['uid']
        self.attributes['pw'] = args['pw']
        self.attributes['email'] = args['email']
        self.attributes['type'] = args['type']

    def verify_password(self, password):
        '''verify password'''
        return self.attributes['pw'] == password

    @staticmethod
    def fetch(args):
        '''fetch user by given args'''
        app.logger.debug(args)
        sql = None
        for attr in args:
            if attr == 'email':
                emailaddr = parse_emailaddr(args['email'])
                if emailaddr is not None:
                    sql = Queries.query_user_by_email
        cur = mysql.connection.cursor()
        app.logger.debug(sql)
        if sql is None:
            return None
        cur.execute(sql, (emailaddr, ))
        results = cur.fetchall()
        app.logger.debug(results)
        json = []
        for row in results:
            dict1 = {}
            i = 0
            for attr in User.attributes:
                dict1[attr] = row[i]
                i = i + 1
            json.append(dict1)
        return json


class Client(object):
    ''' model for Client'''
    attributes = {}
    relation = 'Clients'
    attributes['c_id']= None
    attributes['pw'] = None
    attributes['first_name'] = None
    attributes['last_name'] = None
    attributes['p_num'] = None
    attributes['cp_num'] = None
    attributes['email'] = None
    attributes['zipcode'] = None
    attributes['state'] = None
    attributes['city'] = None
    attributes['street'] = None
    def __init__(self, args):
        '''construct function'''
        self.attributes['c_id']= args['c_id']
        self.attributes['pw'] = args['pw']
        self.attributes['first_name'] = args['first_name']
        self.attributes['last_name'] = args['last_name']
        self.attributes['p_num'] = args['p_num']
        self.attributes['cp_num'] = args['cp_num']
        self.attributes['email'] = args['email']
        self.attributes['zipcode'] = args['zipcode']
        self.attributes['state'] = args['state']
        self.attributes['city'] = args['state']
        self.attributes['street'] = args['state']

    @staticmethod
    def fetchall():
        q = Query('SELECT', 'Clients')
        cur = mysql.connection.cursor()
        app.logger.debug(q.sql)
        cur.execute(q.sql)
        results = cur.fetchall()
        json = []
        for row in results:
            dict1 = {}
            i = 0
            for attr in Client.attributes:
                dict1[attr] = row[i]
                i = i + 1
            json.append(dict1)
        return json

    @staticmethod
    def fetch(args):
        conditions = []
        app.logger.debug(args)
        for attr in args:
            if type(args[attr]) is str:
                conditions.append("{}='{}'".format(attr, args[attr]))
            elif args[attr] is not None and args[attr] != '':
                conditions.append("{}={}".format(attr, args[attr]))
        conditions = " AND ".join(conditions)
        q = Query('SELECT', 'Clients', None, conditions)
        cur = mysql.connection.cursor()
        app.logger.debug(q.sql)
        cur.execute(q.sql)
        results = cur.fetchall()
        json = []
        for row in results:
            dict1 = {}
            i = 0
            for attr in Client.attributes:
                dict1[attr] = row[i]
                i = i + 1
            json.append(dict1)
        return json

    def verify_password(self, password):
        return self.attributes['pw'] == password

class Transaction(object):
    ''' model for Client'''
    attributes = {}
    relation = 'Clients'
    attributes['t_id']= None
    attributes['c_id']= None
    attributes['value'] = None
    attributes['t_date'] = None
    attributes['commission'] = None
    attributes['balance_oil'] = None
    attributes['balance'] = None

    @staticmethod
    def fetch(args):
        conditions = []
        app.logger.debug(args)
        for attr in args:
            if type(args[attr]) is str:
                conditions.append("{}='{}'".format(attr, args[attr]))
            elif args[attr] is not None and args[attr] != '':
                conditions.append("{}={}".format(attr, args[attr]))
        conditions = " AND ".join(conditions)
        targets = [a for a in Transaction.attributes]
        q = Query('SELECT', 'Clients_trans', targets, conditions)
        cur = mysql.connection.cursor()
        app.logger.debug(q.sql)
        cur.execute(q.sql)
        results = cur.fetchall()
        json = []
        for row in results:
            row = list(row)
            dict1 = {}
            i = 0
            for attr in Transaction.attributes:
                if isinstance(row[i], date):
                    row[i] = row[i].isoformat()
                dict1[attr] = row[i]
                i = i + 1
            json.append(dict1)
        return json
