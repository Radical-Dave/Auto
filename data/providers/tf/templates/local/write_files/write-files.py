#!/usr/bin/env python

import errno
import json
import os
import sys
from os.path import exists

for name, value in json.load(sys.stdin).items():

    # Skip if the file already exists with this value.
    try:
        with open(name) as open_file:
            if open_file.read() == value:
                continue
    except Exception as error:
        if error.errno != errno.ENOENT:
            raise
    
    if exists(name):
        os.remove(name);
    

    # Create the file only if it doesn't already exist.
    try:
        fd = os.open(name, os.O_WRONLY | os.O_CREAT | os.O_EXCL)
    except OSError as error:
        if error.errno == errno.EEXIST:
            sys.stderr.write('{} already exists\n'.format(name))
            sys.exit(1)
        else:
            raise
    try:
        f = os.fdopen(fd, 'w')
        f.write(value)
    finally:
        f.close()

sys.stdout.write('{}')