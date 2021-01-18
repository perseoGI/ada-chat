with Ada.Text_IO; use Ada.Text_IO;

with Utils;

procedure Main is
   ConfigFile: File_Type;
	Assert: Boolean;
begin
    begin
    --Opening of the file and error handling
    Open(   File => ConfigFile,
            Mode => In_File,
            Name => "adachat.cfg");
    exception
        when others =>
            Put_Line("No se ha encontrado adachat.cfg");
            return;
    end;

    --Main loop of reading
    while not End_Of_File(ConfigFile) loop
        declare
            Line : String := Get_Line(ConfigFile);
        begin
            Assert := utils.Is_String_IpV4(Line);
            Put_Line(Line);
        end;
    end loop;

    --Ending
    Close(ConfigFile);
exception
    when others =>
        if Is_Open(ConfigFile) then
            Close (ConfigFile);
        end if;
end Main;
