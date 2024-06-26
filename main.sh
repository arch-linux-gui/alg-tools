#!/bin/bash

# Importing source files
source update_pkgbuild.sh
source get_pkgbuild.sh
source get_server.sh
source path_origin.sh
source cleanup.sh
source package_build.sh
source update_server.sh

# Define text formatting variables
bold=$(tput bold)
normal=$(tput sgr0)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
red=$(tput setaf 1)

# Function to display colored output
print_message1() {
    echo "${bold}${blue}$1${normal}"
}

print_message2() {
    echo "${bold}${green}$1${normal}"
}

print_message3() {
    echo "${bold}${yellow}$1${normal}"
}

print_message4() {
    echo "${bold}${red}$1${normal}"
}

# Running perform_cleanup when ctrl+c pressed
trap perform_cleanup SIGINT

print_message1 "Updated all/few/one packages? "
read -p "Enter choice (all/few/one): " ans

# Check if input is not "all", "few", or "one"
if [[ "$ans" != "all" && "$ans" != "few" && "$ans" != "one" ]]; then
    print_message4  "Invalid input. Exiting..."
    exit 0
fi

# Choose server repo
print_message1 "Choose which repo you want to clone and push"
print_message2 "1) alg_repo"
print_message2 "2) alg_repo_testing"
print_message2 "3) both"
print_message2 "4) alg_settings"

# Prompt the user for a choice
read -p "Enter the number of your choice: " server_choice

# Sign package 
# List of GPG keys
#gpg_keys=(""- "280178FA27665D44-Akash6222"  "BF4E1E687DD0A534-harshau007")

#print_message1 "Choose a GPG key:"
#for ((i=0; i<${#gpg_keys[@]}; i++)); do
#    echo "$((i+1)). ${gpg_keys[i]}"
#done

#read -p "Enter the number of your choice: " gpg_key_choice



if [ "$ans" == "all" ]; then
    for ((i=1; i<=16; i++)); do
        print_message1 "Updating package $i"
        # package_build $i

        # Call the get_pkgbuild function
        get_pkgbuild $package_name $i

        # Call the package_build
        package_build $package_name
        # Call the path_origin function
        path_origin

        # Map choices to http
        case $server_choice in
            1) server="alg_repo"
               get_server $server
               ;;
            2) server="alg_repo_testing"
               get_server $server
               ;;
            3) 
               server="alg_repo"
               get_server $server
               server="alg_repo_testing"
               get_server $server
               ;;

            4) server="alg_settings"
               get_server $server
               ;;
            *) print_message3 "Invalid choice"
                perform_cleanup ;;
        esac

    done

    # To Update Different Server
    if [ -d "alg_repo" ]; then
        print_message1 "Repository 'alg_repo' exists"
        server="alg_repo"        
        update_server $server
    fi
    if [ -d "alg_repo_testing" ]; then
        print_message1 "Repository 'alg_repo_testing' exists"
        server="alg_repo_testing"
        update_server $server
    fi
    if [ -d "alg_settings" ]; then
        print_message1 "Repository 'alg_settings' exists"
        server="alg_settings"
        update_server $server
    fi

    # Call the update_pkgbuild function
    update_pkgbuild $ans

    print_message1 "All packages updated successfully."

    perform_cleanup

elif [ "$ans" == "few" ]; then

   # Prompt the user for a package name
   print_message1 "Enter a directory name to search for: "
   print_message2 "1) alg-cinnamon-settings"
   print_message2 "2) alg-firefox-settings"
   print_message2 "3) alg-gnome-settings"
   print_message2 "4) alg-i3-settings"
   print_message2 "5) alg-livecd-desktop"
   print_message2 "6) alg-mate-settings"
   print_message2 "7) alg-office-settings"
   print_message2 "8) alg-plasma-settings"
   print_message2 "9) alg-xfce-settings"
   print_message2 "10) alg-net-cala-config"
   print_message2 "11) alg-pure-cala-config"
   print_message2 "12) alg-theme-cala-config"
   print_message2 "13) alg-wm-cala-config"
   print_message2 "14) alg-zen-cala-config"
   print_message2 "15) studio-cala-config"
   print_message2 "16) calamares-3.3.5"

    # Prompt the user to enter comma-separated values and read input
    read -rp "Enter comma-separated values: " input

    # Split the input into an array
    IFS=',' read -r -a values <<< "$input"

    # Loop through the values and assign 'a' at each iteration
    for val in "${values[@]}"; do
        i="$val"
        echo "Package number is: $i"

        print_message1 "Updating package $i"
       # package_build $i

        # Call the get_pkgbuild function
        get_pkgbuild $package_name $i

       # Call the package_build
       package_build $package_name
       # Call the path_origin function
       path_origin

        # Map choices to http
        case $server_choice in
            1) server="alg_repo"
               get_server $server
               ;;
            2) server="alg_repo_testing"
               get_server $server
               ;;
            3) 
               server="alg_repo"
               get_server $server
               server="alg_repo_testing"
               get_server $server
               ;;

            4) server="alg_settings"
               get_server $server
               ;;
            *) print_message3 "Invalid choice"
                perform_cleanup ;;
        esac

    done

    # To Update Different Server
    if [ -d "alg_repo" ]; then
        print_message1 "Repository 'alg_repo' exists"
        server="alg_repo"        
        update_server $server
    fi
    if [ -d "alg_repo_testing" ]; then
        print_message1 "Repository 'alg_repo_testing' exists"
        server="alg_repo_testing"
        update_server $server
    fi
    if [ -d "alg_settings" ]; then
        print_message1 "Repository 'alg_settings' exists"
        server="alg_settings"
        update_server $server
    fi

    # Call the update_pkgbuild function
    update_pkgbuild $ans

    print_message1 "All packages updated successfully."

    perform_cleanup 

elif [ "$ans" == "one" ]; then

        # Call the get_pkgbuild function
        get_pkgbuild $package_name

       # Call the package_build
       package_build $package_name
       # Call the path_origin function
       path_origin

        # Map choices to http
        case $server_choice in
            1) server="alg_repo"
               get_server $server
               ;;
            2) server="alg_repo_testing"
               get_server $server
               ;;
            3) 
               server="alg_repo"
               get_server $server
               server="alg_repo_testing"
               get_server $server
               ;;

            4) server="alg_settings"
               get_server $server
               ;;
            *) print_message3 "Invalid choice"
                perform_cleanup ;;
        esac

    # To Update Different Server
    if [ -d "alg_repo" ]; then
        print_message1 "Repository 'alg_repo' exists"
        server="alg_repo"        
        update_server $server
    fi
    if [ -d "alg_repo_testing" ]; then
        print_message1 "Repository 'alg_repo_testing' exists"
        server="alg_repo_testing"
        update_server $server
    fi
    if [ -d "alg_settings" ]; then
        print_message1 "Repository 'alg_settings' exists"
        server="alg_settings"
        update_server $server
    fi


    # Call the update_pkgbuild function
    update_pkgbuild $ans

    perform_cleanup

    #print_message1 "$package_name has been updated successfully."

else
    print_message4 "Invalid choice"
    perform_cleanup
fi
