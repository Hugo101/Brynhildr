# utils for Brynhildr
from email.utils import parseaddr
from .brynhildr import app

def parse_emailaddr(addr):
    r = parseaddr(addr)
    app.logger.debug(r)
    if '@' in r[1]:
        app.logger.debug(r[1])
        return r[1]
    else:
        return None
