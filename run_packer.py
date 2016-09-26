"""
Script for building a VirtualBox image with Packer
"""

import argparse
import os
import subprocess
import sys

AUTOUNATTEND_TEMPLATE = './answerfiles/windows10/Autounattend.xml.template'
AUTOUNATTEND_XML = './answerfiles/windows10/Autounattend.xml'

def run_packer(username, password, skip_window_updates):
    write_autounattend_file(username, password)
    os.environ['WINRM_USERNAME'] = username
    os.environ['WINRM_PASSWORD'] = password
    os.environ['SKIP_WINDOWS_UPDATES'] = str(skip_window_updates)
    os.environ['PACKER_LOG'] = '1'
    os.environ['PACKER_LOG_PATH'] = 'packer.log'
    subprocess.check_call(['/opt/packer/packer', 'build', '-var-file=variables.json', 'windows_10.json'])

def write_autounattend_file(username, password):
    template = open(AUTOUNATTEND_TEMPLATE).read()
    autounattend_content = template.replace('${username}', username)
    autounattend_content = autounattend_content.replace('${password}', password)
    autounattend_file = open(AUTOUNATTEND_XML, 'w')
    autounattend_file.write(autounattend_content)
    autounattend_file.close()

def main():
    parser = argparse.ArgumentParser(
        description=('Script for building a VirtualBox image with Packer'))
    parser.set_defaults(skip_window_updates=False)
    parser.add_argument('-u', '--username',
                        dest='username',
                        action='store',
                        required=True,
                        help='The name of the user in the VirtualBox image')
    parser.add_argument('-p', '--password',
                        dest='password',
                        action='store',
                        required=True,
                        help='The users password')
    parser.add_argument('-n', '--no-updates',
                        dest='skip_window_updates',
                        action='store_true',
                        required=False,
                        help='Skip installing Windows updates')

    args = parser.parse_args()
    run_packer(args.username,
               args.password,
               args.skip_window_updates)

if __name__ == '__main__':
    main()
