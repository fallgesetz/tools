#!/usr/bin/env python
import subprocess
import sys
import json
import argparse

def testrpccall(jsonArgs):
    print jsonArgs
    return subprocess.call(["curl","-X", "POST", '--data', jsonArgs, 'localhost:8545'])

def argsToJson(method, params, nid):
    d = {"jsonrpc": 2.0, "method": method, "params": params, "id": nid}
    return json.dumps(d)

def main():
    parser = argparse.ArgumentParser("query testrpc for you")
    parser.add_argument('method', metavar='M', nargs=1)
    parser.add_argument('id', metavar='I',nargs="?",default=1)
    parser.add_argument('params', metavar='P', nargs='*', default=[])
    cmd_dict= parser.parse_args().__dict__
    testrpccall(argsToJson(''.join(cmd_dict['method']),cmd_dict['params'], 1))

if __name__ == '__main__':
    main()


