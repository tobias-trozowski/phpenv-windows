## phpenv-windows - PHP multi-version installation and management for Windows PowerShell.

### Key features:

 * Inspired by the totally awesome [phpenv](https://github.com/phpenv/phpenv) for *nix
 * Install php directly from the php archive, saves you time
 * Easily customizable configuration options, gives you freedom
 * Includes Apache apxs support and switching versions, as you wish
 * Installs pear and pyrus for each installation (where supported), as you prefer
 * Developed by humans for humans, just like you

## How It Works

As phpenv for Linux phpenv-windows operates on the per-user directory `~/.phpenv`. Version names in
phpenv correspond to subdirectories of `~/.phpenv/versions`. For
example, you might have `~/.phpenv/versions/5.3.8` and
`~/.phpenv/versions/5.4.0`.

Each version is a working tree with its own binaries, like
`~/.phpenv/versions/5.4.0/bin/php`. phpenv-windows makes _shim binaries_
for every such binary across all installed versions of PHP.

These shims are simple wrapper scripts that live in `~/.phpenv/shims`
and detect which PHP version you want to use. They insert the
directory for the selected version at the beginning of your `$PATH`
and then execute the corresponding binary.

Because of the simplicity of the shim approach, all you need to use
phpenv is `~/.phpenv/shims` in your `$PATH` which will do the version
switching automagically.

## Installation

### Basic GitHub Checkout

This will get you going with the latest version of phpenv and make it
easy to fork and contribute any changes back upstream.

1. Check out phpenv into `$HOME\Documents\WindowsPowershell\Modules\phpenv` (This path should be found in your `$env:PSModulePath` variable).

        $ cd
        $ git clone git://github.com/tobias-trozowski/phpenv-windows.git $HOME\Documents\WindowsPowershell\Modules\phpenv

2. Add `~/.phpenv/bin` to your `$PATH` for access to the `phpenv` command-line utility.

In `$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1` add:
```powershell
if ([System.IO.File]::Exists((Get-Module -ListAvailable phpenv).path)) {
    Import-Module (Get-Module -ListAvailable phpenv).path 3>$null
}
```

3. Restart your shell so the path changes take effect. You can now
   begin using phpenv.

5. Rebuild the shim binaries. You should do this any time you install
   a new PHP binary.

        $ phpenv rehash

### Upgrading

If you've installed phpenv using the instructions above, you can
upgrade your installation at any time using git.

To upgrade to the latest development version of phpenv, use `git pull`:

    $ cd $HOME\Documents\WindowsPowershell\Modules\phpenv
    $ git pull

### Apache Setup

    Not yet supported.

## Usage

### Install-PhpenvVersion

You can list the available PHP releases by running:

    Not yet supported.

To install one of the listed releases run:

    $ Install-PhpenvVersion 5.3.20

This command will checkout a branch to install that release to
its own subdirectory in ~/.phpenv/versions/

### Get-PhpenvVersion -Global, Set-PhpenvVersion -Global 

Works the same way `phpenv global` and `phpenv local` does.

Sets the global version of PHP to be used in all shells by writing
the version name to the `~/.phpenv/version` file. This version can be
overridden by a per-project `.phpenv-version` file, or by setting the
`PHPENV_VERSION` environment variable.

    $ Set-PhpenvVersion -Global 5.4.0

The special version name `system` tells phpenv to use the system PHP
(detected by searching your `$PATH`).

`Get-PhpenvVersion -Global` reports the currently configured global version.

### Get-PhpenvVersion -Local, Set-PhpenvVersion -Local

Sets a local per-project PHP version by writing the version name to
a `.phpenv-version` file in the current directory. This version
overrides the global, and can be overridden itself by setting the
`PHPENV_VERSION` environment variable.

    $ Set-PhpenvVersion -Local 5.3.8

`Get-PhpenvVersion -Local` reports the currently configured local version. You can also unset the local version:

    $ Clear-PhpenvVersion -Local

### List-PhpenvVersions

Lists all PHP versions known to phpenv, and shows an asterisk next to
the currently active version.

    $ List-PhpenvVersions
      5.2.8
      5.3.13
    * 5.4.0 (set by /YOUR-USERNAME/.phpenv/global)

### Get-PhpenvVersion

Displays the currently active PHP version, along with information on
how it was set.

    $ phpenv version
    5.4.0 (set by /YOUR-USERNAME/.phpenv/version)

### License

(The MIT license)

Copyright (c) 2018 Tobias Trozowski

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.