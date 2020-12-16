begin
    for contador in 1..500000
        loop
            insert into pedidos values(contador,'06/01/2015',10.0,'C'||contador,' ');
        end loop;
end;