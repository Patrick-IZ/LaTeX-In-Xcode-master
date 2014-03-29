#!/bin/bash

#  Created by Alex Karahalios on 6/12/11
#  Edited by Brian Reinhart on 08/02/2012 .
#
#  Edited by Patrick Iglesias-Zemmour on 12/15/2013.
#  Updated for Xcode to support TeX/LaTeX language for editing
#  Last edited by PIZ - March 15, 2014

#  Distributed under CC Atribution.

# Path were this script is located
#
SCRIPT_PATH="$(dirname "$BASH_SOURCE")"

# Set up path for PlistBuddy helper application which can add elements to Plist files
#
PLISTBUDDY=/usr/libexec/PlistBuddy

# Filename path private framework we need to modify
#
#DVTFOUNDATION_PATH="/Developer/Library/PrivateFrameworks/DVTFoundation.framework/Versions/A/Resources/"
#DVTFOUNDATION_PATH="/XCode4.3/Library/PrivateFrameworks/DVTFoundation.framework/Versions/A/Resources/"

# This framework is found withing the Xcode.app package and is used when Xcode is a monolithic
# install (all contained in Xcode.app)
#
DVTFOUNDATION_PATH="/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/"

# Create Plist file of additional languages to add to 'DVTFoundation.xcplugindata'
#
cat >AdditionalLanguages.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Xcode.SourceCodeLanguage.LaTeX</key>
	<dict>
		<key>languageSpecification</key>
		<string>tex.lang.latex</string>
		<key>fileDataType</key>
		<array>
			<dict>
				<key>identifier</key>
				<string>com.apple.xcode.LaTeX-source</string>
			</dict>
		</array>
		<key>id</key>
		<string>Xcode.SourceCodeLanguage.LaTeX</string>
		<key>point</key>
		<string>Xcode.SourceCodeLanguage</string>
		<key>languageName</key>
		<string>LaTeX</string>
		<key>version</key>
		<string>1.0</string>
		<key>conformsTo</key>
		<array>
			<dict>
				<key>identifier</key>
				<string>Xcode.SourceCodeLanguage.Generic</string>
			</dict>
		</array>
		<key>name</key>
		<string>LaTeX Language</string>
	</dict>
</dict>
</plist>
EOF

# Now merge in the additonal languages to DVTFoundation.xcplugindata
#
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Merge AdditionalLanguages.plist plug-in:extensions'

# Get rid of the AdditionalLanguages.plist since it was just temporary
#
rm -f AdditionalLanguages.plist

# Copy in the xclangspecs for the languages (assumes in same directory as this shell script)
#
cp "$SCRIPT_PATH/LaTeX.xclangspec" "$DVTFOUNDATION_PATH"

# Create Plist file of additional languages to add to 'DVTFoundation.xcplugindata'
#
cat >AdditionalLanguages.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Xcode.SourceCodeLanguage.BibTeX</key>
	<dict>
		<key>languageSpecification</key>
		<string>tex.lang.bibtex</string>
		<key>fileDataType</key>
		<array>
			<dict>
				<key>identifier</key>
				<string>com.apple.xcode.BibTeX-source</string>
			</dict>
		</array>
		<key>id</key>
		<string>Xcode.SourceCodeLanguage.BibTeX</string>
		<key>point</key>
		<string>Xcode.SourceCodeLanguage</string>
		<key>languageName</key>
		<string>BibTeX</string>
		<key>version</key>
		<string>1.0</string>
		<key>conformsTo</key>
		<array>
			<dict>
				<key>identifier</key>
				<string>Xcode.SourceCodeLanguage.Generic</string>
			</dict>
		</array>
		<key>name</key>
		<string>LaTeX Language</string>
	</dict>
</dict>
</plist>
EOF

# Now merge in the additonal languages to DVTFoundation.xcplugindata
#
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Merge AdditionalLanguages.plist plug-in:extensions'

# Get rid of the AdditionalLanguages.plist since it was just temporary
#
rm -f AdditionalLanguages.plist

# Copy in the xclangspecs for the languages (assumes in same directory as this shell script)
#
cp "$SCRIPT_PATH/BibTeX.xclangspec" "$DVTFOUNDATION_PATH"

# Copy in the xcsynspec for LaTeX (assumes in same directory as this shell script)
#
cp "$SCRIPT_PATH/LaTeX.xcsynspec" "$DVTFOUNDATION_PATH"

# Copy in the Sunset LaTeX.dvtcolortheme to its place (assumes in same directory as this shell script) 
# creates missing directories if necessary
#
mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
cp "$SCRIPT_PATH/Sunset LaTeX.dvtcolortheme" ~/Library/Developer/Xcode/UserData/FontAndColorThemes/

# Copy in two snippets to their places (assumes they are in same directory as this shell script, as it must be)
# creates missing directories if necessary
#
mkdir -p ~/Library/Developer/Xcode/UserData/CodeSnippets/
cp "$SCRIPT_PATH/CodeSnippets/equation.codesnippet" ~/Library/Developer/Xcode/UserData/CodeSnippets/equation.codesnippet
cp "$SCRIPT_PATH/CodeSnippets/typeset-script.codesnippet" ~/Library/Developer/Xcode/UserData/CodeSnippets/typeset-script.codesnippet


mkdir -p ~/Library/Developer/Xcode/Templates/"Project Templates"/TeX
cp -rf "$SCRIPT_PATH/LaTeX.xctemplate" ~/Library/Developer/Xcode/Templates/"Project Templates"/TeX

# Remove any cached Xcode plugins
#
rm -f -r /private/var/folders/*/*/*/com.apple.DeveloperTools/*/Xcode/PlugInCache.xcplugincache
