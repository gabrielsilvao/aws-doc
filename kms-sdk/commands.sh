# install aws encryption sdk kms
pip install aws-encryption-sdk-cli

# show version
aws-encryption-cli --version

# set the arn of kms key
key="arn:..."

# create a file to be encrypted
echo "encryption test" > file.txt

# encrypt the file
aws-encryption-cli --encrypt --input file.txt --master-keys key=$key --metadata-output metadata --output output/

# view the metadatas
cat metadata | jq

# the encrypted file is on output/

# to decrypt the file
aws-encryption-cli --decrypt --input output/file.txt.encrypted --metadata-output metadata --output decrypted