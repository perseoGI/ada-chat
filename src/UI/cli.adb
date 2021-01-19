with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Strings.Unbounded, Ada.Text_IO.Unbounded_IO;
with Types;

package body Cli is
    use Ada.Text_IO;
    use Ada.Strings.Unbounded;
    use Ada.Text_IO.Unbounded_IO;
    use Types;

    procedure Read_Input is
        S : Unbounded_String;
        Packet: Application_Payload;
    begin
        Put("> ");
        S := To_Unbounded_String(Get_Line);
        Put_Line(To_String(S));
        Unbounded_IO.Put_Line(S);
        --Packet.Content := S;

    end Read_Input;

    procedure Print_Menu is
    begin
        Put_Line("");
        Put_Line(" ----- Ada Chat -----");
        Put_Line("1. Close conection");
        Put_Line("2. Regenerate cipher keys");
        Put_Line("3. More options TBD");

    end Print_Menu;

    procedure User_Interface_Controller is
    begin
        while True loop
            Read_Input;
        end loop;

    end User_Interface_Controller;


end Cli;
