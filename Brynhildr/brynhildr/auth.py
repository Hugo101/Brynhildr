from flask import g
#from .models import Client
from .brynhildr import auth, jwt, app

def generate_token(uid):
    '''generate token for an legal user'''
    token = jwt.dumps({'uid': uid})
    return token

@auth.verify_token
def verify_token(token):
    app.logger.debug(token)
    g.id = None
    try:
        tokens = jwt.loads(str(token))
    except Exception:
        return False
    if 'uid' in tokens:
        g.id = tokens['uid']
        return True
    return False
