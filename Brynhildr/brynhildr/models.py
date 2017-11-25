# models in Brynhildr
from .query import Queries
from .brynhildr import mysql, app
from datetime import date, datetime
from flask import g
from .utils import parse_emailaddr, parse_int, parse_datetime
from decimal import Decimal

class User(object):
    '''model for User'''
    relation = 'Users'
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
        cur = mysql.connection.cursor()
        results = None
        for attr in args:
            if attr == 'email':
                # check email is a valid email addr without ';', sql injection prevention
                emailaddr = parse_emailaddr(args['email'])
                if emailaddr is not None:
                    sql = Queries.query_user_by_email
                    app.logger.debug(sql)
                    cur.execute(sql, (emailaddr, ))
                    results = cur.fetchall()
            if attr == 'uid':
                # check uid is a valid integer
                uid = parse_int(args['uid'])
                if uid is not None:
                    sql = Queries.query_user_by_uid
                    app.logger.debug(sql)
                    cur.execute(sql, (uid, ))
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
    relation = 'Clients'
    attributes = {}
    attributes['uid']= None
    attributes['first_name'] = None
    attributes['last_name'] = None
    attributes['phone_num'] = None
    attributes['cellph_num'] = None
    attributes['state'] = None
    attributes['city'] = None
    attributes['street'] = None
    attributes['zip_code'] = None
    attributes['level'] = None
    attributes['cash_balan'] = None
    attributes['oil_balan'] = None
    def __init__(self, args):
        '''construct function'''
        self.attributes['uid']= args['uid']
        self.attributes['first_name'] = args['first_name']
        self.attributes['last_name'] = args['last_name']
        self.attributes['phone_num'] = args['phone_num']
        self.attributes['cellph_num'] = args['cellph_num']
        self.attributes['state'] = args['state']
        self.attributes['city'] = args['state']
        self.attributes['street'] = args['state']
        self.attributes['zip_code'] = args['zip_code']
        self.attributes['level'] = args['level']
        self.attributes['cash_balan'] = args['cash_balan']
        self.attributes['oil_balan'] = args['oil_balan']

    @staticmethod
    def fetchall():
        cur = mysql.connection.cursor()
        ret = 0
        cur.callproc('searchtrader',(g.id, ret,))
        cur.execute('select @_searchtrader_1;')
        ret = cur.fetchall()[0][0]
        # only trader could request all clients information
        if ret != 0:
            cur.execute(Queries.query_client_all)
            results = cur.fetchall()
            json = []
            for row in results:
                row = list(row)
                dict1 = {}
                i = 0
                for attr in Client.attributes:
                    if isinstance(row[i], Decimal):
                        row[i] = float(row[i])
                    dict1[attr] = row[i]
                    i = i + 1
                json.append(dict1)
            return json
        else:
            return {'error': 'Insufficient authority'}

    @staticmethod
    def fetch(args):
        app.logger.debug(args)
        sql = None
        for attr in args:
            if attr == 'uid':
                # check uid is a valid Integer, sql injection prevention
                uid = parse_int(args['uid'])
                if uid is not None:
                    sql = Queries.query_client_by_uid
        cur = mysql.connection.cursor()
        app.logger.debug(sql)
        if sql is None:
            return None
        cur.execute(sql, (uid, ))
        results = cur.fetchall()
        json = []
        for row in results:
            row = list(row)
            dict1 = {}
            i = 0
            for attr in Client.attributes:
                if isinstance(row[i], Decimal):
                    row[i] = float(row[i])
                dict1[attr] = row[i]
                i = i + 1
            json.append(dict1)
        return json


class Transaction(object):
    ''' model for Client'''
    attributes = {}
    relation = 'clients_trans'
    attributes['t_id']= None
    attributes['t_date'] = None
    attributes['c_id']= None
    attributes['tr_id']= None

    @staticmethod
    def fetch(args):
        for attr in args:
            if attr == 'uid':
                # check uid is a valid Integer, sql injection prevention
                uid = parse_int(args['uid'])
                if uid is not None:
                    tr_id = args.get('tr_id')
                    if tr_id is not None:
                        cur = mysql.connection.cursor()
                        ret = 0
                        cur.callproc('searchtrader',(g.id, ret,))
                        cur.execute('select @_searchtrader_1;')
                        ret = cur.fetchall()[0][0]
                        if ret == 0:
                            return {'error': 'Insufficient authority'}
                    users = User.fetch(args)
                    if users is not None:
                        g.user = User(users[0])
                        json1 = OilTransaction.fetch(args)
                        json2 = Payments.fetch(args)
        json = json1 + json2
        json.sort(key=lambda x:x['t_id'], reverse=True)
        return json

    @staticmethod
    def new(args):
        amount = parse_int(args['amount'])
        comm_type = parse_int(args['comm_type'])
        t_type = parse_int(args['t_type'])
        c_id = parse_int(args['c_id'])
        tr_id = parse_int(args['uid'])
        if amount is None or t_type is None or c_id is None or tr_id is None:
            return {'error': 'Incorrect Arguments'}
        if comm_type is None and t_type != 2:
            return {'error': 'Incorrect Arguments'}
        if tr_id == c_id:
            tr_id = None
        cur = mysql.connection.cursor()
        ret = 0
        if t_type == 0:
            # call buyoilproc procedure to add new oil transaction
            ret = cur.callproc('buyoilproc', (amount, c_id, tr_id, comm_type, ret))
            cur.execute('select @_buyoilproc_4;')
            ret = cur.fetchall()[0][0]
        elif t_type == 1:
            # call buyoilproc procedure to add new oil transaction
            ret = cur.callproc('selloilproc', (amount, c_id, tr_id, comm_type, ret))
            cur.execute('select @_selloilproc_4;')
            ret = cur.fetchall()[0][0]
        else:
            ret = cur.callproc('paymentproc', (amount, c_id, tr_id, ret))
            cur.execute('select @_paymentproc_3;')
            ret = cur.fetchall()[0][0]
        app.logger.debug(ret)
        mysql.connection.commit()
        if ret >=0:
            return {'t_id': ret}
        elif ret == -1:
            return {'error': 'Insufficient Authority'}
        elif ret == -2:
            return {'error': 'Not enough oil balance'}
        else:
            return {'error': 'Falied to create new transaction, contact Admin'}


class OilTransaction(object):
    ''' model for Client'''
    attributes = {}
    relation = 'oil_transactions'
    attributes['t_id']= None
    attributes['t_date'] = None
    attributes['c_id']= None
    attributes['tr_id']= None
    attributes['t_type']= None
    attributes['comm_oil']= None
    attributes['comm_cash']= None
    attributes['oil_balan']= None
    attributes['cash_balan']= None
    attributes['comm_rate']= None
    attributes['price']= None
    attributes['amount']= None


    @staticmethod
    def fetch(args):
        sql = None
        cur = mysql.connection.cursor()
        results = None
        for attr in args:
            if attr == 'uid':
                # check uid is a valid Integer, sql injection prevention
                uid = parse_int(args['uid'])
                if uid is not None :
                    if g.user.attributes['type'] == 0:
                        sql = Queries.query_oil_transactions_by_cid
                        cur.execute(sql, (uid,))
                        results = cur.fetchall()
        json = []
        for row in results:
            row = list(row)
            dict1 = {}
            i = 0
            for attr in OilTransaction.attributes:
                if isinstance(row[i], datetime):
                    row[i] = row[i].isoformat()
                if isinstance(row[i], Decimal):
                    row[i] = float(row[i])
                dict1[attr] = row[i]
                i = i + 1
            json.append(dict1)
        return json


class Payments(object):
    ''' model for Client'''
    attributes = {}
    relation = 'payments'
    attributes['t_id']= None
    attributes['t_date'] = None
    attributes['c_id']= None
    attributes['tr_id']= None
    attributes['cash_balan']= None
    attributes['amount']= None


    @staticmethod
    def fetch(args):
        sql = None
        cur = mysql.connection.cursor()
        results = None
        for attr in args:
            if attr == 'uid':
                # check uid is a valid Integer, sql injection prevention
                uid = parse_int(args['uid'])
                if uid is not None :
                    if g.user.attributes['type'] == 0:
                        sql = Queries.query_payments_by_cid
                        cur.execute(sql, (uid,))
                        results = cur.fetchall()
        json = []
        for row in results:
            row = list(row)
            dict1 = {}
            i = 0
            for attr in Payments.attributes:
                if isinstance(row[i], datetime):
                    row[i] = row[i].isoformat()
                if isinstance(row[i], Decimal):
                    row[i] = float(row[i])
                dict1[attr] = row[i]
                i = i + 1
            dict1['t_type'] = 2
            json.append(dict1)
        return json


class Aggregation(object):
    '''model for aggregation information retrieval for manager'''
    attributes = {}
    relation = 'payments'
    attributes['buy'] = None
    attributes['sell'] = None
    attributes['total_oil'] = None
    attributes['total_cash'] = None
    attributes['total_comm_oil'] = None
    attributes['total_comm_cash'] = None
    attributes['total_payment'] = None

    @staticmethod
    def fetch(args):
        cur = mysql.connection.cursor()
        ret = 0
        cur.callproc('searchmanager',(g.id, ret,))
        cur.execute('select @_searchmanager_1;')
        ret = cur.fetchall()[0][0]
        if ret == 0:
            return {'error': 'Insufficient Authority'}
        dat1 = parse_datetime(args['dat1'])
        dat2 = parse_datetime(args['dat2'])
        cur.callproc('aggproc',(dat1,dat2,ret,ret,ret,ret,ret,ret,ret,))
        cur.execute('select @_aggproc_2,@_aggproc_3,@_aggproc_4,@_aggproc_5,@_aggproc_6,@_aggproc_7,@_aggproc_8;')
        row = cur.fetchall()[0]
        json = []
        row = list(row)
        dict1 = {}
        i = 0
        for attr in Aggregation.attributes:
            if isinstance(row[i], Decimal):
                row[i] = float(row[i])
            dict1[attr] = row[i]
            i = i + 1
        json.append(dict1)
        return json
