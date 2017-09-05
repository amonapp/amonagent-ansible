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


Example
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:


    - hosts: all
      roles:
        - {role: amonagent, api_key: '', amon_instance: 'https://youramoninstance.amon.cx'}

License
-------

MIT

Author Information
------------------

Martin Rusev (https://amon.cx)
