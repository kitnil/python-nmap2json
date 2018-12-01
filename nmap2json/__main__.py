#!/usr/bin/env python

import json
import subprocess
import sys
import xmltodict

lookup = lambda hosts, ports: subprocess.run(["nmap", "-oX", "-", "-Pn", "--open", "-n", "-p", ports, hosts]
                                        , stdout=subprocess.PIPE).stdout.decode("utf-8")

port_to_json = lambda port: {"{#PORT}": port["@portid"],
                        "{#NAME}": port["service"]["@name"]}

main = lambda: json.dumps({"data": list(map(port_to_json, xmltodict.parse(lookup(sys.argv[1], sys.argv[2]))["nmaprun"]["host"]["ports"]["port"]))})

if __name__ == '__main__':
    print(main())
