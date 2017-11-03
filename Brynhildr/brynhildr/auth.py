from flask import g
#from .models import Client
from .brynhildr import auth, jwt, app

def generate_token(c_id):
    token = jwt.dumps({'cid': c_id})
    return token

@auth.verify_token
def verify_token(token):
    app.logger.debug(token)
    g.id = None
    try:
        tokens = jwt.loads(str(token))
    except Exception:
        return False
    if 'cid' in tokens:
        g.id = tokens['cid']
        return True
    return False
