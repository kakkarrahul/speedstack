#!/usr/bin/env python

import os
import json
from os import path
from mutagen.mp3 import MP3

music_dir = '/Users/tushar/Music/iTunes'
ext = '.mp3'

output_file = path.abspath('.') + '/public/js/songs.json'

tags_to_read = ['TCOP', 'TPOS', 'TENC', 'TDRC', 'TALB', 'TRCK', 'TPE2', 'TPE1', 'TIT2', 'TCON']
tagMap = {
	'TDRC': 'year',
	'TIT2': 'title',
	'TRCK': 'track',
	'TPE2': 'artist',
	'TALB': 'album',
	'TPE1': 'album_artist',
	'TCON': 'genre'
}

def find_all(dir_path, ext):
	for root, dirs, files in os.walk(dir_path):
		for filename in files:
			if filename[0] != '.' and os.path.splitext(filename)[1] == ext:
				yield os.path.join(root, filename)

# Returns aliased name from tagMap
def getTagName(tag):
	return (tagMap[tag] if tagMap.has_key(tag) else tag)	


def extract_tags(filepath):
	try:
		mp3 = MP3(filepath)
		dict = {}
		for tag in tags_to_read:
			if mp3.has_key(tag):
				dict[ getTagName(tag) ] = str( mp3[tag] )

		dict['path'] = filepath
		return dict
	except Exception: 
		print "Skipping: %s" % (filepath)
		pass


def buildlib(list):
	tags = [extract_tags(x) for x in list]
	
	data_out = {}
	data_out['music_dir'] = music_dir
	data_out['entries'] = tags
	
	f = open(output_file, 'w')
	f.write(json.dumps(data_out, indent=2))
	f.close()


# Run
print "Scanning for mp3s in %s" % music_dir
mp3list = [ x for x in find_all(music_dir, ext) ] 
print "Found %d %s files" % (len(mp3list), ext)

buildlib(mp3list)
print "Exported to ./public/js/songs.json"