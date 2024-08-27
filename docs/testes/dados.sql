use oss;
insert into os(descricao,colaborador,executor,abertura,encerramento) values
("Instalação de lâmpada de emergência no corredor","201","203",date_sub(now(),interval 1 hour),now()),
("Instalação de tomada 220v na administração","202","205",date_sub(now(),interval 480 hour),date_sub(now(),interval 367 hour)),
("Pintura do poste da garagem","203","202",date_sub(now(),interval 475 hour),date_sub(now(),interval 366 hour)),
("Instalação de refletores no estacionamento","204","205",date_sub(now(),interval 464 hour),date_sub(now(),interval 365 hour)),
("Construção de uma porta adicional na sala da diretoria","201","202",date_sub(now(),interval 462 hour),date_sub(now(),interval 364 hour)),
("Instalação de tomadas na sala de descanso","209","205",date_sub(now(),interval 461 hour),date_sub(now(),interval 363 hour)),
("Troca da torneira da pia do refeitório","200","206",date_sub(now(),interval 460 hour),date_sub(now(),interval 362 hour)),
("Instalação do batente da porta da cozinha","200","205",date_sub(now(),interval 450 hour),date_sub(now(),interval 361 hour)),
("Instalação do batente da porta do banheiro feminino","201","205",date_sub(now(),interval 448 hour),date_sub(now(),interval 360 hour)),
("Troca da torneira da pia do banheiro feminino","201","206",date_sub(now(),interval 447 hour),date_sub(now(),interval 355 hour)),
("Instalação de lâmpada de emergência na recepção","200","206",date_sub(now(),interval 445 hour),date_sub(now(),interval 350 hour)),
("Instalação de lâmpada de emergência no corredor","201","203",date_sub(now(),interval 444 hour),date_sub(now(),interval 340 hour)),
("Instalação de tomada 220v na administração","201","205",date_sub(now(),interval 420 hour),date_sub(now(),interval 330 hour)),
("Limpeza pós obra na sala de reuniões","204","208",date_sub(now(),interval 415 hour),date_sub(now(),interval 320 hour)),
("Pintura do poste da garagem externa","200","202",date_sub(now(),interval 410 hour),date_sub(now(),interval 310 hour)),
("Instalação de refletores no estacionamento","201","205",date_sub(now(),interval 380 hour),date_sub(now(),interval 360 hour)),
("Construção de uma porta adicional na sala da contabilidade","209","202",date_sub(now(),interval 370 hour),date_sub(now(),interval 260 hour)),
("Instalação de tomadas na sala de reunição","209","205",date_sub(now(),interval 360 hour),date_sub(now(),interval 250 hour)),
("Troca da torneira da pia da cozinha","200","206",date_sub(now(),interval 359 hour),date_sub(now(),interval 240 hour)),
("Instalação do batente da porta do banheiro masculino","201","205",date_sub(now(),interval 358 hour),date_sub(now(),interval 230 hour)),
("Instalação do batente da porta do banheiro feminino","201","205",date_sub(now(),interval 357 hour),date_sub(now(),interval 220 hour)),
("Troca da torneira da pia do banheiro masculino","207","206",date_sub(now(),interval 356 hour),date_sub(now(),interval 219 hour)),
("Instalação de lâmpada de emergência na recepção","207","203",date_sub(now(),interval 355 hour),date_sub(now(),interval 218 hour)),
("Instalação de lâmpada de emergência no corredor","207","203",date_sub(now(),interval 351 hour),date_sub(now(),interval 216 hour)),
("Instalação de tomada 220v na administração","209","205",date_sub(now(),interval 350 hour),date_sub(now(),interval 215 hour)),
("Pintura das faixas da garagem","209","202",date_sub(now(),interval 340 hour),date_sub(now(),interval 214 hour)),
("Pintura do poste da garagem","204","202",date_sub(now(),interval 330 hour),date_sub(now(),interval 213 hour)),
("Instalação de refletores no estacionamento","207","205",date_sub(now(),interval 320 hour),date_sub(now(),interval 210 hour)),
("Construção de uma porta adicional na sala da diretoria","209","202",date_sub(now(),interval 310 hour),date_sub(now(),interval 209 hour)),
("Instalação de tomadas na sala de descanso","209","205",date_sub(now(),interval 300 hour),date_sub(now(),interval 208 hour)),
("Troca da torneira da pia do refeitório","201","206",date_sub(now(),interval 280 hour),date_sub(now(),interval 120 hour)),
("Instalação do batente da porta da cozinha","204","205",date_sub(now(),interval 240 hour),date_sub(now(),interval 160 hour)),
("Instalação do batente da porta do banheiro feminino","200","205",date_sub(now(),interval 200 hour),date_sub(now(),interval 115 hour)),
("Troca da torneira da pia do banheiro feminino","200","202",date_sub(now(),interval 180 hour),date_sub(now(),interval 110 hour)),
("Instalação de lâmpada de emergência na recepção","201","205",date_sub(now(),interval 160 hour),date_sub(now(),interval 100 hour)),
("Instalação de lâmpada de emergência no corredor","201","203",date_sub(now(),interval 150 hour),date_sub(now(),interval 90 hour)),
("Porta da recepção está rangendo","200","203",date_sub(now(),interval 130 hour),date_sub(now(),interval 80 hour)),
("Porta da recepção quebrada","201","202",date_sub(now(),interval 95 hour),date_sub(now(),interval 60 hour)),
("Torneira do banheiro feminino com grande vazamento","200","202",date_sub(now(),interval 90 hour),date_sub(now(),interval 55 hour)),
("Troca da torneira da pia do banheiro feminino","201","206",date_sub(now(),interval 73 hour),date_sub(now(),interval 48 hour)),
("Instalação de lâmpada de emergência na recepção","200","206",date_sub(now(),interval 68 hour),date_sub(now(),interval 32 hour)),
("Instalação de lâmpada de emergência no corredor","201","203",date_sub(now(),interval 59 hour),date_sub(now(),interval 18 hour)),
("Instalação de tomada 220v na administração","201","205",date_sub(now(),interval 52 hour),null),
("Limpeza pós obra na sala de reuniões","204","208",date_sub(now(),interval 48 hour),null),
("Pintura do poste da garagem externa","200","202",date_sub(now(),interval 42 hour),null),
("Instalação de refletores no estacionamento","201",null,date_sub(now(),interval 33 hour),null),
("Construção de uma porta adicional na sala da contabilidade","209",null,date_sub(now(),interval 28 hour),null),
("Instalação de tomadas na sala de reunição","209",null,date_sub(now(),interval 17 hour),null);

drop procedure if exists add_comentario;
delimiter $
create procedure add_comentario()
begin
declare v_i INT DEFAULT 11;
declare v_colaborador varchar(8);
declare v_data datetime;
declare v_data2 datetime;
looping: LOOP
    set v_colaborador = (select executor from os where id = v_i);
    set v_data = date_add((select abertura from os where id = v_i),interval 1 hour);
    set v_data2 = (select encerramento from os where id = v_i);
    insert into comentario(os, colaborador, data, comentario) values (v_i, v_colaborador, v_data,"Verificando OS");
    insert into comentario(os, colaborador, data, comentario) values (v_i, v_colaborador, v_data2,"OS concluída com sucesso");
    set v_i = v_i + 1;
    IF v_i >= 52 THEN
        LEAVE looping;
    END IF;
END LOOP looping;
end $
delimiter ;

call add_comentario();

select * from comentario;