#!/usr/bin/python3
# generates a .tgz archive from the contents of the web_static folder
from fabric.api import local
from datetime import datetime

def do_pack():
    """Creates archive from web_static directory"""
    local("mkdir -p versions")
    file = 'versions/web_static_{}.tgz'\
            .format(datetime.strftime(datetime.now(), "%Y%m%d%I%M%S"))
    comp = 'tar -cvzf {} web_static'.format(file)
    tar_file = local(comp)
    if tar_file.failed:
        return None
    return file
