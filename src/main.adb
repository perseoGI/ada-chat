with Ada.Text_IO;
with RC4;
with DiffieHellman;
with File_Parser;
with Exceptions;
with Ada.Exceptions;
with Types;
with Cli;
with Connections;

procedure Main is
    use Ada.Text_IO;
    use Ada.Exceptions;
    use Exceptions;
    use File_Parser;
    use Types;
    use Connections;

    -- 1. Read and parse configuration file
    -- 2. Open server and client socket and wait until connection is stablished
    -- 3. Generate cipher keys
    --  3.1. Diffie Hellman secret generation
    --  3.2. Interchange Modulus, Base and public secret
    --  3.3. Initiate RC4 cipher on both sides
    -- 4. Start up User Interface
    -- 5. Wait for incoming and outcoming messages cipher messages

    Ip_Dest : IPv4.Bounded_String;
    Port_Dest, Port_Src: Positive; --  TODO make Port type
    Modulus: U64;
    Base: U64;
    Diffie_Hellman_Secret: U64;
    Diffie_Hellman_Public: U64;

    Connection: Connections.Object;
begin
    -- 1. Read and parse configuration file
    Parse_Config_File(Ip_Dest => Ip_Dest, Port_Dest => Port_Dest, Port_Src => Port_Src);
    -- TODO no se como llamar a To_Sring (Ip_Dest) desde aqui

    -- 2. Open server and client socket and wait until connection is stablished
    -- TODO
    --Connection.Init(Addr_Dst => To_String(Ip_Dest), Port_Dst => Port_Dest, Port_Org => Port_Src);
    Connection.Init(Addr_Dst => "127.0.0.1",
                    Port_Dst => Port(Port_Dest),
                    Port_Org => Port(Port_Src));


    Put_Line("Antes DH");
    -- 3. Generate cipher keys
    --  3.1. Diffie Hellman secret generation
    DiffieHellman.Generate_Modulus_And_Base(Modulus => Modulus, Base => Base);
    Diffie_Hellman_Secret := DiffieHellman.Generate_Secret;
    Diffie_Hellman_Public := DiffieHellman.Compute(Base => Base, Exp => Diffie_Hellman_Secret, Modulus => Modulus);



    Put_Line("Before read");
    Connection.Read;
    Put_Line("After read");
    Put_Line("Antes send");
    Connection.Send("Hola");
    Put_Line("After Sended");

    Connection.Finish;

    --  3.2. Interchange Modulus, Base and public secret
    --  TODO
    --  3.3. Initiate RC4 cipher on both sides
    --  TODO

    --Cli.User_Interface_Controller;
exception
    when E: File_Parser_Exception =>
        Put_Line(Exception_Message(E));
        return;


end Main;
