from ghqExpl import ghqExplManager
from leaderf.utils import lfCmd


def open_browser():
    instance = ghqExplManager._getInstance()
    line = instance.currentLine
    url = "https://github.com/" + line.split(" ", 1)[0]
    lfCmd(f'call openbrowser#open("{url}")')


def packget():
    """
    :PackGet
    """
    instance = ghqExplManager._getInstance()
    line = instance.currentLine
    name = line.split(" ", 1)[0]
    lfCmd(f'PackGet {name}')
