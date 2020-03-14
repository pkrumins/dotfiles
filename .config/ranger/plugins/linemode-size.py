import ranger.api
import ranger.core.linemode
from ranger.ext.human_readable import human_readable
from datetime import datetime

@ranger.api.register_linemode
class SizeCtimeLinemode(ranger.core.linemode.LinemodeBase):
    name = "size"

    def filetitle(self, fobj, metadata):
        return fobj.relative_path

    def infostring(self, fobj, metadata):
        if fobj.stat is None:
            return '?'
        humanSize = human_readable(fobj.size)
        return "%s" % humanSize

