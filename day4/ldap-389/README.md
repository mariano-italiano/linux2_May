# LDAP

## Instalacja LDAP

```sh
dnf install -y 389-ds-base openldap-clients python3-lib389
```

Nastepnie implementacja pliku `ds-setup.inf`:

```sh
ds-create from-file ds-setup.inf
```

### Jak wygenerowac haslo do usera LDAP w pliku LDIF

```sh
LDIF_USER_PASS="{CRYPT}$(openssl passwd -6 'mojetajnehaslotutaj')"
```

## Konfiguracja klient serwera do LDAP auth

### Instalacja

```sh
dnf install -y sssd sssd-ldap oddjob-mkhomedir openldap-clients
```

### Konfiguracja sssd

```sh
# /etc/sssd/sssd.conf
[sssd]
domains = lab.local
config_file_version = 2
services = nss, pam

[domain/lab.local]
id_provider = ldap
auth_provider = ldap
ldap_uri = ldap://localhost
ldap_search_base = dc=lab,dc=local
ldap_default_bind_dn = cn=Directory Manager
ldap_default_authtok = AdminPass123
ldap_id_use_start_tls = false
ldap_tls_reqcert = never
cache_credentials = true
enumerate = true

[nss]
default_shell = /bin/bash
homedir_substring = /home

[pam]
offline_credentials_expiration = 60
```

Pamietać o prawach dla pliku `/etc/sssd/sssd.conf`

```sh
chmod 600 /etc/sssd/sssd.conf
```

Po wystartowaniu sssd pamietac o skonfigurowaniu oddjobd.

```sh
systemctl enable --now oddjobd
```
