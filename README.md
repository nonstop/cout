# cout
Colorize Output

Author: Evgeny Ratnikov (ratnikov dot ev at gmail dot com)

![cout](https://user-images.githubusercontent.com/22714/147844367-d1557543-fc76-42cb-b4a9-d146d6fdc6b4.png)

## Description

~200 lines in python for highlighting different outputs.
Easy customisation via ini-files.

Out-of-the-box supports
- make/gcc
- svn
- diff


## Usage

```
cout config-file [args]
```

Where config-file describes executable to run and rules for highlighting.

I have the following script in my $HOME/bin:

```
/home/er> cat $HOME/bin/makec
#!/bin/sh
cout ~/.cout/make-gcc.cfg $@
```

## Colors customisation

There are two files where color escape sequences are defined:
*/usr/share/cout/colors* and *$HOME/.cout/colors*. These are simple INI-files.
Global colors-file is processed at first then local, so you can override
colors for your purposes and taste.

Format for all sections is common: name=value. Where name is color name
(eg red, blue) and value is escape sequence to set this color in terminal.

**default** contains only nocolor - describes escape sequence to turn off
highlighting.

**background** contains colors for background.

**normal** for normal colors.

**bold** for bold colors.


## Config-file format

Configutation files are in INI format.

### Section [default]

Describes the executable to run and default colors.

```
[default]
executable=/usr/bin/svn
fgcolor=grey
bgcolor=black
bold=False
```

### Section [line modifiers]

Describes several masks for the whole line. Any lines matching mask will
be highlighted due to rules in name section (see below).

Format: *mask-name*=*regular expression*

```
[line modifiers]
make=make\[?[0-9]*\]?:
error=^.*error:.*$
warning=^.*warning:.*$
```

### Section [word modifiers]

Describes several masks for words. Words are checked only (!) if no line-mask
was applied. Any words matching mask will be highlighted due to rules in name
section (see below).

Format: *mask-name*=*regular expression*

```
[word modifiers]
object=[-a-zA-Z0-9/_.+]*(\.o):*$
library=[-a-zA-Z0-9/_.+]*((\.a)|(\.la)|(\.so))$
linkedlibrary=-l[-a-zA-Z0-9/_.+]*$
```

### Highlighing rules

Describes rules for highlighting pattern (line or word).
Section name is *mask-name*.
Section content contains:

**fgcolor** - Any color name from normal or bold sections from colors-file.

**bgcolor** - Any color name from background section from colors-file.

**bold** - Can be only True or False - switches fgcolor.

```
[object]
fgcolor=yellow

[library]
fgcolor=red

[error]
fgcolor=red
bold=True

[warning]
fgcolor=yellow
bold=True

[make]
fgcolor=cyan
bold=True
```

## Examples

Execute this in source dir to see cout in action.

```
cout data/make-gcc.cfg -f Makefile.example
```
