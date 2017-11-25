# utils for Brynhildr
from email.utils import parseaddr
from .brynhildr import app
import re

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

def parse_datetime(i):
    try:
        r = i.split(' ')
        if len(r) != 2:
            return None
        r1 = r[0].split('-')
        if len(r1) != 3:
            return None
        r2 = r[1].split(':')
        if len(r2) != 3:
            return None
        for e in r1:
            x = int(e)
        for e in r2:
            x = int(e)
    except Exception:
        r = None
    return i
