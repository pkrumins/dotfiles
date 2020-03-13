import ranger.api
import ranger.core.linemode
from datetime import datetime

@ranger.api.register_linemode
class CtimeLinemode(ranger.core.linemode.LinemodeBase):
    name = "ctime"

    def filetitle(self, fobj, metadata):
        return fobj.relative_path

    def infostring(self, fobj, metadata):
        if fobj.stat is None:
            return '?'
        return datetime.fromtimestamp(fobj.stat.st_ctime).strftime("%Y-%m-%d %H:%M")

