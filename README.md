	                        _                   _               _   
	  __ _ _ __   __ _  ___| |__   ___   __   _| |__   ___  ___| |_ 
	 / _` | '_ \ / _` |/ __| '_ \ / _ \  \ \ / / '_ \ / _ \/ __| __|
	| (_| | |_) | (_| | (__| | | |  __/   \ V /| | | | (_) \__ \ |_ 
	 \__,_| .__/ \__,_|\___|_| |_|\___|    \_/ |_| |_|\___/|___/\__|
	      |_|


## Table of contents

- [Description](#description)
- [How to use?](#how-to-use)
- [Command arguments](#command-arguments)
- [Compatibility](#Compatibility)

&nbsp;

## Description

Apache-vhost automates the creation of Apache VirtualHost configuration files. It makes the required changes in `/etc/hosts` file and inserts corresponding configuration file inside `/etc/apache2/sites-available/` directory, and then, applies the changes for you.

## How to use?

- Place the `vh.sh` wherever you want
- Make it executable by running `chmod +x vh.sh`
- Run it: `./vh.sh <option> <value> ...` or `/bin/sh vh.sh <option> <value> ...`
- You don't need to run the script with sudo
- It will ask you to give a password when needed                                                             

## Command arguments

<pre>
-s, --servername    ⟶    Provide a name for the server. Example: mysite.my
-p, --path          ⟶    Provide a path/directory for the server. Example: /home/johndoe/dir/
-h, --help          ⟶    Show help
</pre>

**Important!** Argument mixing (-abc) is not allowed.

## Compatibility

The script is designed for Linux. It's compatible only with Debian and Debian-based operating systems. 
[https://distrowatch.com/search.php?basedon=Debian](https://distrowatch.com/search.php?basedon=Debian) 
