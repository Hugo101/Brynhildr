# Class Query for Brynhildr
from .brynhildr import mysql

users_table_name = 'users'

class Queries(object):
    '''pre define queries'''
    query_user_by_email = 'select uid, email, password, type from ' + users_table_name + ' where email = %s'
