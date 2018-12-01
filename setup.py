#!/usr/bin/env python

from distutils.core import setup

setup(name='nmap2json',
      version='0.1',
      description='Nmap scan host ports and print as JSON',
      author='Oleg Pykhalov',
      author_email='go.wigust@gmail.com',
      url='https://gitlab.com/wigust/nmap2json',
      packages=['nmap2json'],
      entry_points={'console_scripts': ['nmap2json = nmap2json.__main__:main']},
      install_requires=[
          'xmltodict'
      ]
)
