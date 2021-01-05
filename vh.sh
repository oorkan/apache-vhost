#!/bin/sh
# POSIX

# Reset all variables that might be set
servername=
path=

show_help()
{
    printf -- '\n Usage: ./vh.sh [OPTION] [VALUE] ...\n'
    printf -- ' Generates Apache VirtualHost configuration file.\n\n'
    printf -- ' -s, --servername    Provide a name for the server | ex: mysite.my\n'
    printf -- ' -p, --path          Provide a path/directory for the server | ex: /home/johndoe/dir/\n'
    printf -- ' -h, --help          Show help\n\n'
    printf -- ' Argument mixing (-abc) is not allowed!\n\n'

    return 1
}

while :; do
    case $1 in
        -h|-\?|--help)   # Call a "show_help" function to display a synopsis, then exit.
            show_help
            exit
            ;;
        -s|--servername)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                servername=$2
                shift
            else
                printf 'ERROR: "--servername" requires a non-empty option argument.\n' >&2
                exit 1
            fi
            ;;
        -p|--path)       # Takes an option argument, ensuring it has been specified.
            if [ -n "$2" ]; then
                path=$2
                shift
            else
                printf 'ERROR: "--path" requires a non-empty option argument.\n' >&2
                exit 1
            fi
            ;;
        --servername=?*)
            servername=${1#*=} # Delete everything up to "=" and assign the remainder.
            ;;
        --servername=)         # Handle the case of an empty --servername=
            printf 'ERROR: "--servername" requires a non-empty option argument.\n' >&2
            exit 1
            ;;
        --)              # End of all options.
            shift
            break
            ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *)               # Default case: If no more options then break out of the loop.
            break
    esac

    shift
done

# if --servername was provided, open it and write, else print the error
if [ -n "$servername" ]; then
	if [ -n "$path" ]; then
    	touch "$servername.conf"
    	> "$servername.conf"
    	cat <<EOT >> $servername.conf
<VirtualHost *:80>
    ServerAdmin admin@$servername.conf
    ServerName $servername
    ServerAlias www.$servername
    DocumentRoot $path
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOT
	sudo cp /etc/hosts /etc/hosts.backup
	sudo sed -i "1s/^/127.0.0.1 $servername\n/" /etc/hosts
	sudo cp "$servername.conf" "/etc/apache2/sites-available/$servername.conf"
	sudo mkdir "$path"
	sudo chown $USER:$USER "$path"
	sudo a2ensite "$servername.conf"
	sudo service apache2 restart
	else
		printf 'ERROR: "--path" provided in a wrong way or does not exist.\n' >&2
	fi
else
   printf 'ERROR: "--servername" provided in a wrong way or does not exist.\n' >&2
fi