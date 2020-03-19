REPLACE WITH SAME INDENT REGISTER
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

Replacing existing lines with the contents of a register is a very common task
during editing. Often, one wants to adapt the indent of the pasted lines to
the current indent, e.g. when replacing a nested conditional from a yank that
originated at a different nesting level.

This plugin combines the replacement functionality of the
ReplaceWithRegister.vim plugin with the indent-adjustment done by the
built-in ]p command. With a simple mapping, you can replace line(s) with the
contents of a register while adjusting the indent to that of the first
replaced line.

### SEE ALSO

- ReplaceWithRegister.vim ([vimscript #2703](http://www.vim.org/scripts/script.php?script_id=2703)) implements the general case of
  replacing text including the indent (also with a {motion} mapping for
  arbitrary text, not just lines).

USAGE
------------------------------------------------------------------------------

    [count]["x]grR          Replace [count] lines with the contents of register x
                            and adjust the indent to the first replaced line (like
                            pasting with ]p).
    {Visual}["x]gR          Replace the selection with the contents of register x
                            and adjust the indent to the first selected line.
                            As the replacement is always entire lines, this only
                            works with linewise selections (V).

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at
    https://github.com/inkarkat/vim-ReplaceWithSameIndentRegister
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim ReplaceWithSameIndentRegister*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.
- Requires the ingo-library.vim plugin ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)), version 1.000 or
  higher.
- repeat.vim ([vimscript #2136](http://www.vim.org/scripts/script.php?script_id=2136)) plugin (optional)
  To support repetition with a register other than the default register, you
  need version 1.1 or later.
- visualrepeat.vim ([vimscript #3848](http://www.vim.org/scripts/script.php?script_id=3848)) plugin (version 2.00 or higher; optional)

CONFIGURATION
------------------------------------------------------------------------------

If you want to use different mappings, map your keys to the
&lt;Plug&gt;ReplaceWithSameIndentRegister... mapping targets _before_ sourcing the
script (e.g. in your vimrc):

    nmap <Leader>R  <Plug>ReplaceWithSameIndentRegisterLine
    xmap <Leader>R  <Plug>ReplaceWithSameIndentRegisterVisual

CONTRIBUTING
------------------------------------------------------------------------------

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-ReplaceWithSameIndentRegister/issues or email
(address below).

HISTORY
------------------------------------------------------------------------------

##### 1.01    19-Nov-2019
- BUG: {count}grR does not repeat the count.
- BUG: Starting with v\_gR, repeating in normal mode with {count}., repeating
  again uses the original number of selected lines, not the overridden
  {count}.
- Suppress "--No lines in buffer--" message when replacing the entire buffer,
  and combine "Deleted N lines" / "Added M lines" into a single message that
  is given when either previous or new amount of lines reaches 'report'.

##### 1.00    29-Oct-2014
- First published version.

##### 0.01    21-Mar-2013
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2013-2019 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat &lt;ingo@karkat.de&gt;
