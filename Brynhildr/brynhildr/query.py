# Class Query for Brynhildr
from .brynhildr import mysql

users_table_name = 'users'
clients_table_name = 'clients'
clients_trans_table_name = 'clients_trans'
oil_transactions_table_name = 'oil_transactions'
payments_table_name = 'payments'

class Queries(object):
    '''pre define queries'''
    query_user_by_email = 'select uid, email, password, type from ' + users_table_name + ' where email = %s' # fetch specific user information, for auth ...
    query_user_by_uid = 'select uid, email, password, type from ' + users_table_name + ' where uid = %s' # fetch specific user information, for auth ...
    query_client_by_uid = 'select uid, first_name, last_name, phone_num, cellph_num, state, city, street, zip_code, level, cash_balan, oil_balan from ' + clients_table_name + ' where uid = %s' # fetch specific client information by uid
    query_client_all = 'select uid, first_name, last_name, phone_num, cellph_num, state, city, street, zip_code, level, cash_balan, oil_balan from ' + clients_table_name # fetch all clients
    query_oil_transactions_by_cid = 'select t1.t_id, t1.t_date, t1.c_id, t1.tr_id, t2.comm_oil, t2.comm_cash, t2.oil_balan, t2.cash_balan, t2.comm_rate, t2.price, t2.amount from ' + clients_trans_table_name + ' t1,' + oil_transactions_table_name + ' t2 where t1.c_id = %s and t1.t_id = t2.t_id' # fetch specific client's oil transactions information by cid
    query_payments_by_cid = 'select t1.t_id, t1.t_date, t1.c_id, t1.tr_id, t2.cash_balan, t2.amount_pay from ' + clients_trans_table_name + ' t1,' + payments_table_name + ' t2 where t1.c_id = %s and t1.t_id = t2.t_id' # fetch specific client's payments information by cid
