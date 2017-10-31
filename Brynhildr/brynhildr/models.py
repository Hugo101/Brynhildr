# models in Brynhildr
from .query import Query
from .brynhildr import mysql, app

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
    def __init__(self, c_id=None, pw=None, first_name=None, last_name=None,
                 p_num=None, cp_num=None, email=None, zipcode=None):
        '''construct function'''
        self.attributes['c_id']= c_id
        self.attributes['pw'] = pw
        self.attributes['first_name'] = first_name
        self.attributes['last_name'] = last_name
        self.attributes['p_num'] = p_num
        self.attributes['cp_num'] = cp_num
        self.attributes['email'] = email
        self.attributes['zipcode'] = zipcode
        self.attributes['state'] = state

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
