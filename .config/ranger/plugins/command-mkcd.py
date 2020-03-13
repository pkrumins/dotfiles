from ranger.api.commands import Command
from os.path import join, expanduser, lexists
from os import makedirs

class mkcd(Command):
    def execute(self):
        dirname = join(self.fm.thisdir.path, expanduser(self.rest(1)))
        if lexists(dirname):
            self.fm.notify("file/directory exists!", bad=True)
            return

        makedirs(dirname)
        self.fm.cd(dirname)

