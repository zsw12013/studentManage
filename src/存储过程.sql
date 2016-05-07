-- 添加节点
-- 学院、专业、班级
drop PROCEDURE if exists addnode;
create PROCEDURE addnode(in a VARCHAR(30),in b VARCHAR(30))   -- a pid ; b 节点名
BEGIN
	declare c VARCHAR(30);                                      -- c 新的节点id 
	select count(*) into c from classes where pid = a;
	if CHAR_LENGTH(c)=1 then 
		set c = concat(a,"0",c+1);
	end if;
	if CHAR_LENGTH(c)=2 then
		set c = concat(a,c+1);
	end if;
	if CHAR_LENGTH(a)=5 then  --  添加班级
	insert into classes values(c,b,a,'',1);
	end if;
	if CHAR_LENGTH(a)!=5 then 
	insert into classes values(c,b,a,'closed',1);
	end if;
	select c;
END;
call addnode('0102','网络112班');