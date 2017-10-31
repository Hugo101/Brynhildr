# Class Query for Brynhildr

class Query(object):
    def __init__(self, operation, relation, attributes=None,
                 conditions=None):
        self.operation = operation
        self.relation = relation
        self.attributes = ','.join(["{}.{}".format(
            self.relation,
            attr) for attr in attributes]) if attributes is not None else '*'
        self.conditions = ('WHERE ' + conditions) if conditions is not None and conditions != '' else ''
        self.sql = '''{} {} FROM {} {};'''.format(
            self.operation,
            self.attributes,
            self.relation,
            self.conditions
        )

    def set_query(self, sql):
        self.sql = sql
