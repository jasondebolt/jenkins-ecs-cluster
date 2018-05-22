"""Converts a short version of a parameters file to the format that CloudFormation expects.

USAGE:
  python parameters_generator.py template.json > template-out.json
"""

__author__ = "Jason DeBolt (jasondebolt@gmail.com)"

import sys, os, json

def convert_parameters_file(obj):
    params = obj['Parameters']
    cloudformation_obj = []
    for param_key in params:
        value = params[param_key]
        cloudformation_obj.append({'ParameterKey': param_key, 'ParameterValue': value})
    return json.dumps(cloudformation_obj or codepipeline_obj, indent=4)

def _parse_json(path):
    result = open(os.path.join(sys.path[0], path), 'rb').read()
    try:
        return json.loads(result)
    except json.decoder.JSONDecodeError as e:
        print('\nYour JSON is not valid! Did you check trailing commas??\n')
        raise(e)

def main(args):
    if len(args) != 1:
        raise SystemExit('Invalid arguments!')
    params_file = args[0]
    json_result = _parse_json(params_file)
    print(convert_parameters_file(json_result))

if __name__ == '__main__':
    main(sys.argv[1:])
