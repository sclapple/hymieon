function shhf --wraps=sshfs --description 'alias shhf=sshfs'
    sshfs damieon@192.168.1.225:/ ~/server-media/ $argv
end
