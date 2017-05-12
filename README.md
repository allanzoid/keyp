# keyp
multi-user public key encryption setup for sharing encrypted files, such as a password escrow

# Introduction
keyp is designed to help a group of people share a set of
password escrow files encrypted with each of the group members'
gpg public keys.

The make utility is used to manage changes and encryption.

The whole directory of files can be stored in a version control
system (e.g., git) and shared with the members for which the
password file is encrypted.  

For each gpg public key in the pub_key_list file, the resulting
encrypted form of the (ASCII armored) password file can be decrypted
with that users' private key and passphrase.

In order to encrypt and decrypt the password file properly, each
user needs to have all the other users' public keys and their
own private key set up in gpg first.

A simple python script is provided to search the password file, if
the password file is configured in YAML.  The YAML format is:

> tag:
  login:password

where tag could be the name of a server or any other meaningful
reference.  login and password would be printed out in order to
filter out other entries of the password file.  Another way to do
this would be to just edit or use the 'make less' command to
pipe the decrypted contents to the pager program less and search
for it there.

# Caveat Emptor
This may or may not be more secure than storing password escrows
in plain files.  It feels more secure to me and has been used
in production to help keep sensitive information more secure.
YMMV.
