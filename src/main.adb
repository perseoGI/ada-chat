with Ada.Text_IO; use Ada.Text_IO;
with RC4;
with Utils;
with Ada.Strings.Unbounded, Ada.Strings.Unbounded.Text_IO;

use Ada.Strings.Unbounded, Ada.Strings.Unbounded.Text_IO;

procedure Main is
    Config_File: File_Type;
    Assert: Boolean;
    Ip_Dest : unbounded_string;
    Port_Dest: Positive;
    Port_Src: Positive;
    --Utils.Is_String_IpV4_Test;
begin
    begin
        --Opening of the file and error handling
        Open(   File => Config_File,
        Mode => In_File,
        Name => "adachat.cfg");
    exception
        when others =>
            Put_Line("adachat.cfg does not exist");
            return;
    end;

    --Main loop of reading
    --while not End_Of_File(Config_File) loop
    for I in 1..3 loop
        declare
            Line : String := Get_Line(Config_File);
        begin
            if End_Of_File(Config_File) then
                exit;
            end if;
            case I is
                when 1 =>
                    Assert := utils.Is_String_IpV4(Line);
                    if Assert = True then
                        Ip_Dest := To_Unbounded_String(Line);
                    else
                        Put_Line("Destination IP: " & Line & " is invalid");
                        exit;
                    end if;

                -- TODO check possible type conversion exceptions
                when 2 =>
                    Port_Dest := Integer'Value(Line);
                when 3 =>
                    Port_Src := Integer'Value(Line);

                end case;
            end;
    end loop;
    Put_Line ("Destination IP: " & To_String(Ip_Dest) & ASCII.LF & "Destination port: " & Integer'Image(Port_Dest) & ASCII.LF & "Source port: " & Integer'Image(Port_Src));

    --Ending
    Close(Config_File);
exception
    when others =>
        if Is_Open(Config_File) then
            Close (Config_File);
        end if;

    -- 1. Read and parse configuration file
    -- 2. Open server and client socket and wait until connection is stablished
    -- 3. Generate cipher keys
        --  3.1. Diffie Hellman secret generation
        --  3.2. Interchange Modulus, Base and public secret
        --  3.3. Initiate RC4 cipher on both sides
    -- 4. Start up User Interface
    -- 5. Wait for incoming and outcoming messages cipher messages


end Main;
