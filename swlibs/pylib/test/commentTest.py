#! /usr/bin/env python3

import sys;
sys.path.append('../');
import comment;

cnts = [
	'this is line1\n',
	'md of line 2\n',
	'a comment // is here',
	'// start of a comment',
	'/*multi comment',
	'next line',
	'comment */ end',
	'in one /* TODO */ comment'
];


sifted = comment.sift(cnts,'//');
print(sifted);

sifted = comment.sift(cnts,'\/\*','\*\/');
print(sifted);
