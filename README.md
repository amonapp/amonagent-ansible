Amonagent
=========

The role install amonagent on RHEL, Debian and Ubuntu. 

Requirements
------------

This role requires Ansible 2.3 or higher.

Role Variables
--------------

The variables that can be passed to this role are as follows:

    api_key: ''  # The API key for your Amon Instance
    amon_instance: "http://youramoninstance.amon.cx"    # The URL pointing to your Amon Instance


Installation
----------------

To install the role run the following command:

```
ansible-galaxy install amonapp.amonagent
```


Example
----------------

    - hosts: all
      roles:
        - {role: amonagent, api_key: '', amon_instance: 'https://youramoninstance.amon.cx'}

License
-------

MIT

Author Information
------------------

Martin Rusev (https://amon.cx)
