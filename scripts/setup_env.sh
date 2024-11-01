export DO_TOKEN=$(</home/efm/hmm/DO_TOKEN)
export SSH_KEY_ID=$(</home/efm/.ssh/id_rsa.pub | grep -oP '(?<=^fingerprint).*')
