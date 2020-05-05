#!/bin/bash

# Start VM (headless)
VBoxManage startvm "Lex Debian 8.7.1" --type headless

# Wait until VM guest OS can accept ssh connections
ssh -q tony@lexvm exit

if [ $? ];
then
    # mount SSHFS directory
    sshfs tony@lexvm:/home/tony /Users/tony/lexvm/ -o defer_permissions,volname=lexvm

    # forward localhost:6543 to VM and then tunnel into macduff
    ssh -t tony@lexvm -o ExitOnForwardFailure=yes -L 6543:localhost:6543 'bash -l -c "./tunnel-me-macduff.sh"'
else
    echo "Unable to connect to ssh server. Return code: ${$?}"
fi

