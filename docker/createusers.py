#!/usr/bin/env python

import subprocess
import re
import os
import glob

for user_list_file in glob.glob('/etc/users.*'):
  with open(user_list_file, 'r') as f:
    for line in f:
        line = line.strip()
        if (not line) or line.startswith("#"):
            continue

        try:
            (uid, user, pw) = re.split(r'\s+', line, 2)
            home = '/home/%s' % user
            subprocess.run(["createuser.sh", uid, user, pw])
            if os.path.exists(home):
                subprocess.run([
                    "chown", "-R", "%s:%s" % (user, user), home
                ])
        except Exception as e:
            print("Error:", e)
            break
