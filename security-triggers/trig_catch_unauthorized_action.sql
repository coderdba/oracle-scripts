create trigger trig_catch_unauthorized_action before create or insert or drop or grant on database
declare
begin

case ora_sysevent
 when 'INSERT' then <<some action / output >>
 when 'GRANT' then <<some action / output>>
 else
 null;
end case;

end;
