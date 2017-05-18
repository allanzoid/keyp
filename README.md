# keyp
multi-user public key encryption setup for sharing encrypted files,
such as a password escrow.

# Introduction
keyp is designed to help a group of people share a set of password
escrow files encrypted with each of the group members' gpg public
keys.  Each user can decrypt with their own gpg private key and
passphrase.

This avoids a common/shared decryption passphrase and the
need to change it should some of the users no longer have
permission/access.  Change the escrow contents and run make
to re-encrypt with the new list of users (less the removed
user gpg public keys).

The make utility is used to manage changes and encryption.  The
Makefile is set up to notice when the password file needs
to be re-encrypted due to changes in the contents or the list
of users that are authorized to decrypt.

The whole directory of files can be stored in a version control
system (e.g., git, svn, etc.) and shared with the members for which
the password file is encrypted.

For each gpg public key in the pub_key_list file, the resulting
encrypted form of the (ASCII armored) password file can be decrypted
with that users' private key and passphrase.

In order to encrypt and decrypt the password file properly, each
user needs to have all the other users' public keys and their
own private key set up in gpg first.  See the make getkeys section
of the Makefile.

Setting up the gpg keys is important and needs to happen before you
can use the encryption.  All keys used to encrypt the file must be
set up in your local gpg keyring.

# Caveat Emptor
This may or may not be more secure than storing password escrows
in plain files.  It feels more secure to me and has been used
in production to help keep sensitive information more secure.
YMMV.
