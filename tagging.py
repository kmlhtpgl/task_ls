import boto3
def get_roles_with_specific_tags(application_id, owner):
    client = boto3.client('iam')
    paginator = client.get_paginator('list_roles')
    specific_roles = []
    for page in paginator.paginate():
        for role in page['Roles']:
            role_name = role['RoleName']
            tags = client.list_role_tags(RoleName=role_name)['Tags']
            has_application_id = False
            for tag in tags:
                if tag['Key'] == 'mnd-application' and tag['Value'] == application_id:
                    has_application_id_tag = True
                if tag['Key'] == 'mnd-owner' and tag['Value'] == owner:
                    has_owner_tag = True
            if has_application_id_tag and has_owner_tag:
                specific_roles.append(role_name)
    return specific_roles

def tag_roles(role_names, tags):
    client = boto3.client('iam')
    
    for role_name in role_names:
        response = client.tag_role(
            RoleName=role_name,
            Tags=tags
        )
        print(f"Tagged role {role_name} with new tags: {response}")

if __name__ == "__main__":
    #Taggs tobe added
    tags_to_add = [
        {'Key': 'mnd-applicationname', 'Value' : 'xxxxxxxx'}
    ]
    application_id = 'xxxxxx'
    owner = 'xxxx'
    specific_roles = get_roles_with_specific_tags(application_id, owner)
    tag_roles(specific_roles, tags_to_add)
