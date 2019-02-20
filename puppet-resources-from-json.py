import json

def get_params(parameters):
    params = ''
    for k, v in parameters.items():
        if k == 'require':
            p = ''
        else:
            p = '  ' + k + ' => ' + str(json.dumps(v)) + ",\n"
        params += p
    return params

with open('groups.json') as group_data:
    group_json = json.load(group_data)
    for group in group_json:
        r = "group {'" + group['title'] + "':\n"
        r += get_params(group['parameters'])
        r += '}'
        print r

with open('users.json') as user_data:
    user_json = json.load(user_data)
    for user in user_json:
        r = "user {'" + user['title'] + "':\n"
        r += get_params(user['parameters'])
        r += '}'
        print r

with open('keys.json') as key_data:
    key_json = json.load(key_data)
    for key in key_json:
        r = "ssh_authorized_key {'" + key['title'] + "':\n"
        r += get_params(key['parameters'])
        r += '}'
        print r

