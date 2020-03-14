from ranger.api.commands import Command
from os.path import join, expanduser, lexists
import os

class touch(Command):
    def execute(self):
        if (len(self.args) == 1):
            # touch the file under the cursor
            fname = join(self.fm.thisdir.path, expanduser(self.fm.thisfile.path))
        else:
            # touch the given file
            fname = join(self.fm.thisdir.path, expanduser(self.rest(1)))
        self.fm.notify(fname)

        if not lexists(fname):
            open(fname, 'a').close()
        else:
            os.utime(fname, None)

        self.fm.reload_cwd()

    def tab(self, tabnum):
        return self._tab_directory_content()

