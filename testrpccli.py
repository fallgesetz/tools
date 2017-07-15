#!/usr/bin/env python
import subprocess
import sys
import json
import argparse
import pprint

def testrpccall(jsonArgs):
    return subprocess.check_output(["curl","-X", "POST", '--data', jsonArgs, 'localhost:8545'])

def argsToJson(method, params, nid):
    d = {"jsonrpc": 2.0, "method": method, "params": params, "id": nid}
    print d
    return json.dumps(d)

def main():
    parser = argparse.ArgumentParser("query testrpc for you")
    parser.add_argument('method', metavar='M', nargs=1)
    parser.add_argument('id', metavar='I',nargs="?",default=1)
    parser.add_argument('params', metavar='P', nargs='*', default=[])
    cmd_dict= parser.parse_args().__dict__
    output = ""
    if (cmd_dict['method'] == 'send_transaction'):
        print cmd_dict['params']
    else:
        output = testrpccall(argsToJson(''.join(cmd_dict['method']),cmd_dict['params'], 1))
    pprint.pprint(json.loads(output))

if __name__ == '__main__':
    main()


