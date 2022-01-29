#!/bin/bash

# Script to create new React application and start the project in 
# an Intellij IDEA window. 
# 
# 1. clone into your local system
# 2. run chmod +x startidea-react.sh in directory where script lives
# 3. (Optional) - move script to /usr/local/bin this way you can use
#    this script across your system without prefixes the command with
#    the annoying './' characters. This would allow you to create 
#    projects in your working directory across your system.
#
# Script takes AT MOST 1 arguement with following flags:
# 
# (Mandatory)-p : describes the project name
#
# (Optional) -i : describes the project install type 
#                 default action searches for the latest 
#                 Intellij installation in applications
#                 
#                 optional arguments: 
#                 1) snap - intellij was installed via snap
#
# Example: ./startidea-react.sh -p myProject -i snap 
#
#          launches a snap based intellij instance for your new project 
#          named myProject.
#
# author: Wali Morris<walimmorris@gmail.com>


# search for flags 
while getopts p:i: flag
do
    case "${flag}" in 
        p) PROJECT_NAME=${OPTARG};;
	i) INSTALL_TYPE=${OPTARG};;
    esac
done    

# current dir
CURRENT_DIR=$(pwd)

# project dir
PROJECT_DIR="${CURRENT_DIR}/$PROJECT_NAME"

# can use this command if intellij was downloaded via Snap
IDEA_ULTIMATE=intellij-idea-ultimate

# Output project information to user
echo "Creating new React project named: " $PROJECT_NAME
echo "Directory: " $PROJECT_DIR

# Create project, navigate to directory and run yarn
npx create-react-app $PROJECT_NAME
cd $PROJECT_NAME
yarn start

if [ "${INSTALL_TYPE}" = "snap" ]; then
    
    # open project in intellij-idea(snap)
    $IDEA_ULTIMATE $PROJECT_DIR

else 
    
    # establish where IDEA is installed
    IDEA_DEFAULT=`ls -1d /Applications/IntelliJ\ * | tail -n1`
    
    # open project in intellij-(default)
    $IDEA_DEFAULT $PROJECT_DIR
fi    
