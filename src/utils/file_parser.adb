with Ada.Text_IO;
with Ip_Parser;
with Ada.Exceptions;
with Exceptions;

package body File_Parser is
    use Ada.Text_IO, Ada.Exceptions, Exceptions;


    procedure Parse_Config_File(Ip_Dest: out IPv4.Bounded_String; Port_Dest: out Positive; Port_Src: out Positive) is
        Config_File: File_Type;
        Assert: Boolean;
    begin
        begin
            --Opening of the file and error handling
            Open(   File => Config_File,
            Mode => In_File,
            Name => "adachat.cfg");
        exception
            --when others =>
            when Name_Error =>
                Put_Line("adachat.cfg does not exist");
                raise File_Parser_Exception;
        end;

        --Main loop of reading
        --while not End_Of_File(Config_File) loop
        for I in 1..3 loop
            declare
                Line : String := Get_Line(Config_File);
            begin
                case I is
                    when 1 =>
                        Assert := Ip_Parser.Is_String_IpV4(Line);
                        if Assert = True then
                            Ip_Dest := To_Bounded_String(Line);
                        else
                            raise File_Parser_Exception with "Destination IP: " & Line & " is invalid";
                        end if;

                    when 2 =>
                        begin
                            Port_Dest := Integer'Value(Line);
                        exception
                            when Constraint_Error =>
                                raise File_Parser_Exception with "Destination port: " & Line & " is invalid";
                            end;
                    when 3 =>
                        begin
                            Port_Src := Integer'Value(Line);
                        exception
                            when Constraint_Error =>
                                raise File_Parser_Exception with "Source port: " & Line & " is invalid";
                            end;

                end case;

                if End_Of_File(Config_File) then
                    exit;
                end if;
            end;
        end loop;

        Put_Line ("Destination IP: " & To_String(Ip_Dest) & ASCII.LF & "Destination port: " & Integer'Image(Port_Dest) & ASCII.LF & "Source port: " & Integer'Image(Port_Src));
        --Ending
        Close(Config_File);
    exception
        when E: File_Parser_Exception =>
        --when others =>
            if Is_Open(Config_File) then
                Close (Config_File);
            end if;
            raise;

    end Parse_Config_File;

end File_Parser;
