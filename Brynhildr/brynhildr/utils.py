# utils for Brynhildr
from email.utils import parseaddr
from .brynhildr import app

def parse_emailaddr(addr):
    r = parseaddr(addr)
    app.logger.debug(r)
    if '@' in r[1]:
        return r[1]
    else:
        return None


def parse_int(i):
    try:
        r = int(i)
    except Exception:
        r = None
    return r
