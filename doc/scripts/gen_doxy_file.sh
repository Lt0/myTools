#!/bin/bash

WORK_DIR=$PWD

CONF="../doc.conf"
. $CONF

#show_help(){
#echo "Usage: $0 [project1, projects2....]
#
#Example:
#	$0 ffe ffemgr	Generating doxygen documents for ffe and ffemgr that config in ../projects/ffe and ../projects/ffemgr
#	$0		Generating doxygen documents for all projects config in ../projects
#"
#}

modify_doxygen_config(){
	PROJECT=$1
#	OUTPUT=$DOC_PATH/$pro
	echo cur project: $PROJECT
	echo project name: $PRO_NAME
	echo INPUT: $INPUT
	echo OUTPUT: $OUTPUT
	

	sed -i "s|^PROJECT_NAME           =.*|PROJECT_NAME           = $PRO_NAME|g" $PROJECT
	sed -i "s|^OUTPUT_DIRECTORY       =.*|OUTPUT_DIRECTORY       = $OUTPUT|g" $PROJECT
	sed -i "s|^INPUT                  =.*|INPUT                  = $INPUT|g" $PROJECT
	sed -i "s|^EXTRACT_ALL            = NO|EXTRACT_ALL            = YES|g" $PROJECT
	sed -i "s|^RECURSIVE              = NO|RECURSIVE              = YES|g" $PROJECT
	sed -i "s|^EXTRACT_PRIVATE        = NO|EXTRACT_PRIVATE        = YES|g" $PROJECT
	sed -i "s|^EXTRACT_PACKAGE        = NO|EXTRACT_PACKAGE        = YES|g" $PROJECT
	sed -i "s|^EXTRACT_STATIC         = NO|EXTRACT_STATIC         = YES|g" $PROJECT
	sed -i "s|^EXTRACT_LOCAL_METHODS  = NO|EXTRACT_LOCAL_METHODS  = YES|g" $PROJECT
#	sed -i "s|^CASE_SENSE_NAMES       = YES|CASE_SENSE_NAMES       = NO|g" $PROJECT
	sed -i "s|^HIDE_SCOPE_NAMES       = NO|HIDE_SCOPE_NAMES       = YES|g" $PROJECT
	sed -i "s|^EXAMPLE_RECURSIVE      = NO|EXAMPLE_RECURSIVE      = YES|g" $PROJECT
	sed -i "s|^SOURCE_BROWSER         = NO|SOURCE_BROWSER         = YES|g" $PROJECT

# GENERATE_HTMLHELP option will cause search engine to be disable
#	sed -i "s|^GENERATE_HTMLHELP      = NO|GENERATE_HTMLHELP      = YES|g" $PROJECT

	sed -i "s|^HAVE_DOT               = NO|HAVE_DOT               = YES|g" $PROJECT
	sed -i "s|^CALL_GRAPH             = NO|CALL_GRAPH             = YES|g" $PROJECT
	sed -i "s|^CALLER_GRAPH           = NO|CALLER_GRAPH           = YES|g" $PROJECT

	sed -i "s|^OUTPUT_LANGUAGE        =.*|OUTPUT_LANGUAGE        = Chinese|g" $PROJECT

# test options
	sed -i "s|^HTML_DYNAMIC_SECTIONS  =.*|HTML_DYNAMIC_SECTIONS  = YES|g" $PROJECT
	sed -i "s|^HTML_TIMESTAMP         =.*|HTML_TIMESTAMP         = YES|g" $PROJECT
	#sed -i "s|^DISABLE_INDEX          =.*|DISABLE_INDEX          = YES|g" $PROJECT
	sed -i "s|^GENERATE_TREEVIEW      =.*|GENERATE_TREEVIEW      = YES|g" $PROJECT

#	sed -i "s|^INTERACTIVE_SVG        =.*|INTERACTIVE_SVG        = YES|g" $PROJECT
#	sed -i "s|^DOT_IMAGE_FORMAT       =.*|DOT_IMAGE_FORMAT       = svg|g" $PROJECT

	sed -i "s|^GENERATE_LATEX         =.*|GENERATE_LATEX         = NO|g" $PROJECT

# color
#	sed -i "s|^HTML_COLORSTYLE_HUE    =.*|HTML_COLORSTYLE_HUE    = 0|g" $PROJECT
#	sed -i "s|^HTML_COLORSTYLE_SAT    =.*|HTML_COLORSTYLE_SAT    = 0|g" $PROJECT
#	sed -i "s|^HTML_COLORSTYLE_GAMMA  =.*|HTML_COLORSTYLE_GAMMA  = 40|g" $PROJECT

	if [ -n "$EXCLUDE" ];then
		sed -i "s|^EXCLUDE                =.*|EXCLUDE                = $EXCLUDE|g" $PROJECT
	fi

	if [ "$MACRO_EXPANSION" == "YES" ]; then
		sed -i "s|^MACRO_EXPANSION        =.*|MACRO_EXPANSION        = YES|g" $PROJECT
	fi

# Only for C language
	echo checking LANGUAGE
	if [ "$CODE_LANGUAGE" == "C" ]; then
		echo OPTIMIZE_OUTPUT_FOR_C
		sed -i "s|^OPTIMIZE_OUTPUT_FOR_C  =.*|OPTIMIZE_OUTPUT_FOR_C  = YES|g" $PROJECT
	fi
}


if [ -z "$DOC_PATH" ]; then
	echo "DOC_PATH was not set, exit..."
	exit 1
else
	mkdir -p $DOC_PATH
fi

PROJECT_LIST=""
get_project_list(){
	if [ $# -gt "0" ]; then
		PROJECT_LIST="$*"
		echo $PROJECT_LIST
	else
		echo Generate doxygen documents for all config in projects
		PROJECT_LIST=$(ls ../projects)
	fi
}

get_project_list $*
for pro in $PROJECT_LIST
do
	echo 
	echo gennerate doxyfile for project $pro
	. ../projects/$pro

	cd ../doxygen_config
	doxygen -g $pro &>/dev/null
	OUTPUT=$DOC_PATH/$pro
	modify_doxygen_config $pro $OUTPUT
	rm -rvf ./$pro.bak

	doxygen $pro
	mkdir -p /var/www/html/doc/code
	ln -s $OUTPUT /var/www/html/doc/code/$pro
	cd $WORK_DIR
done

