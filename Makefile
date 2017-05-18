#
# HOWTO:
#
# set target to be encrypted key/escrow file e.g., passwords.asc
# set key_file to filename containing list of public keys for those allowed
#   to read the target file, e.g., pub_keys.  See example pub_key_list for
#   file format
#

target := passwords.asc
key_file := pub_key_list

# object is the file w/o the .asc file extension from gpg
object := $(subst .asc,,$(target))

# this will be used to create a backup copy of the current $(target), just in case...
old := $(target).old

# keys are from key_file and used to encrypt flie
keys := $(shell egrep -v '^\#' $(key_file) )

# portion of command line built from keys
recipients := $(foreach key, $(keys), --recipient $(key))

crypt_keys := $(foreach key, $(keys), $(key))

# command to encrypt escrow with multiple public keys
gpg_crypt := gpg --encrypt --armor $(recipients) $(object)

# command to grab keys from keyserver
gpg_getkeys := gpg --search-keys $(keys)



#
# default command is to create the .asc file, it should be rebuilt
# if the key_file is newer
#
$(target): $(key_file)
	make $(object)
	mv -f $(target) $(old)
	$(gpg_crypt)
	make forceclean
	@echo "don't forget to check in your changes..."


#
# how to make the object if key_file changes
# best to use gpg-agent here...
#
$(object): $(key_file)
	gpg $(target)


#
# view the unencrypted file
#
less: 
	gpg -d $(target) | less
	clear

#
# assumes the $(object) exists already...
#
encrypt:
	mv -f $(target) $(old)
	$(gpg_crypt)
	make forceclean
	@echo "don't forget to check in your changes..."

#
# shorthand for creating the $(object) file
#
decrypt: $(object)


#
# force encryption, assumes $(object) does NOT already exist
#
force:	$(object)
	make encrypt	



#
# decrypts file for editing, auto-re-encrypts
#
edit: $(object)
	if [ "x$${EDITOR}" = "x" ]; \
	then \
		vi $(object); \
	else \
		$$EDITOR $(object); \
	fi
	make encrypt


#
# alias for the edit command...
#
vi: edit


#
# removes the unecrypted file for cleanliness
#
clean:
	rm -i $(object)

forceclean:
	rm -f $(object)

#
# stuffs keys before you encrypt
#
getkeys:
	for K in $(keys); \
	do \
		gpg --search-keys $$K; \
	done
