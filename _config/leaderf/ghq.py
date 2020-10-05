"""
./leaderf/ghq.py
"""
from functools import wraps

from ghqExpl import GhqExplManager
from leaderf.utils import lfCmd


def command(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        return func(*args, **kwargs)

    setattr(GhqExplManager, func.__name__, func)
    return wrapper


@command
def open_browser(self, *args, **kwargs):
    instance = self._getInstance()
    line = instance.currentLine
    url = "https://github.com/" + line.split(" ", 1)[0]
    lfCmd(f'call openbrowser#open("{url}")')


@command
def packget(self, *args, **kwargs):
    """
    :PackGet
    """
    instance = self._getInstance()
    line = instance.currentLine
    name = line.split(" ", 1)[0]
    lfCmd(f'PackGet {name}')
