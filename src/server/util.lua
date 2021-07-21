function DecToHex(IN)
    local B,K,OUT,I,D=16,"0123456789ABCDEF","",0
    while IN>0 do
        I=I+1
        IN,D=math.floor(IN/B),math.fmod(IN,B)+1
        OUT=string.sub(K,D,D)..OUT
    end
    return OUT
end