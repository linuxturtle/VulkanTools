# Example watch control file for uscan
# Rename this file to "watch" and then you can run the "uscan" command
# to check for upstream updates and more.
# See uscan(1) for format

# Compulsory line, this is a version 4 file
version=4

# PGP signature mangle, so foo.tar.gz has foo.tar.gz.sig
#opts="pgpsigurlmangle=s%$%.sig%"

# HTTP site (basic)
#http://example.com/downloads.html \
#  files/vulkan-tools-([\d\.]+)\.tar\.gz debian uupdate

# Uncommment to examine a FTP server
#ftp://ftp.example.com/pub/vulkan-tools-(.*)\.tar\.gz debian uupdate

# SourceForge hosted projects
# http://sf.net/vulkan-tools/ vulkan-tools-(.*)\.tar\.gz debian uupdate

# GitHub hosted projects
#opts="filenamemangle="s%(?:.*?)?v?(\d[\d.]*)\.tar\.gz%<project>-$1.tar.gz%" \
#   https://github.com/<user>/vulkan-tools/tags \
#   (?:.*?/)?v?(\d[\d.]*)\.tar\.gz debian uupdate

# PyPI
# https://pypi.python.org/packages/source/<initial>/vulkan-tools/ \
#   vulkan-tools-(.+)\.tar\.gz debian uupdate

# Direct Git
# opts="mode=git" http://git.example.com/vulkan-tools.git \
#   refs/tags/v([\d\.]+) debian uupdate




# Uncomment to find new files on GooglePages
# http://example.googlepages.com/foo.html vulkan-tools-(.*)\.tar\.gz
