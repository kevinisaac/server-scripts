# Shortcut for Systemctl commands
function sstart
    sudo systemctl start $argv
end

function sstop
    sudo systemctl stop $argv
end

function senable
    sudo systemctl enable $argv
end

function sdisable
    sudo systemctl disable $argv
end

function sstatus
    sudo systemctl status $argv
end

function srestart
    sudo systemctl restart $argv
end
