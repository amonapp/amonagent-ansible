# Amonagent

[![Build Status](https://travis-ci.org/amonapp/amonagent-ansible.svg?branch=master)](https://travis-ci.org/amonapp/amonagent-ansible)

This role installs `amonagent` on RHEL, Debian and Ubuntu.

## Requirements

This role requires Ansible 2.2 or higher.

## Role Variables

The variables that can be passed to this role are as follows:

```
  amon_api_key: '' # The API key for your Amon Instance
  amonagent_amon_instance: "https://subdomain.amon.cx" # The URL pointing to your Amon Instance
```

## Installation

To install this role run the following command:

```
ansible-galaxy install amonapp.amonagent
```

## Example

```
  - hosts: all
    roles:
      - amonapp.amonagent

    vars:
      amonagent_api_key: 'test'
      amonagent_amon_instance: 'https://subdomain.amon.cx'
```

## License

MIT

## Author Information

Martin Rusev (https://amon.cx)
