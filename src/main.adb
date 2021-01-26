with Ada.Text_IO;
with RC4;
with Diffie_Hellman;
with File_Parser;
with Exceptions;
with Ada.Exceptions;
with Types;
with Cli;
with Connections;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with GNAT;
with GNAT.Formatted_String;
with Interfaces;

with Ada.Streams;
with Ada.Streams.Stream_IO;

procedure Main is
   use Ada.Text_IO;
   use Ada.Exceptions;
   use Exceptions;
   use File_Parser;
   use Types;
   use Connections;
   use Ada.Streams;
   use Ada.Streams.Stream_IO;
   -- 1. Read and parse configuration file 2. Open server and client socket and
   -- wait until connection is stablished 3. Generate cipher keys
   --  3.1. Diffie Hellman secret generation 3.2. Interchange Modulus, Base and
   --  public secret 3.3. Initiate RC4 cipher on both sides
   -- 4. Start up User Interface 5. Wait for incoming and outcoming messages
   -- cipher messages

   Ip_Dest : IPv4.Bounded_String;
   Port_Dest, Port_Src: Positive; --  TODO make Port type
   Diffie_Hellman_Secret: U64;
   Source_Crypto_Payload: Crypto_Payload;
   Dest_Crypto_Payload: Crypto_Payload;
   Connection : Connections.Object;



   Crypto_Payload_Bytes_Var: Crypto_Payload_Bytes;
   Test: Crypto_Payload;

begin
   -- 1. Read and parse configuration file
   Parse_Config_File
      (Ip_Dest => Ip_Dest, Port_Dest => Port_Dest, Port_Src => Port_Src);
   -- TODO no se como llamar a To_Sring (Ip_Dest) desde aqui

   -- 2. Open server and client socket and wait until connection is stablished
   -- TODO
   --Connection.Init(Addr_Dst => To_String(Ip_Dest), Port_Dst => Port_Dest, Port_Org => Port_Src);
   Connection.Init
      (Addr_Dst => "127.0.0.1", Port_Dst => Port (Port_Dest),
   Port_Org => Port (Port_Src));

   --Connections.Connection_Read.Start(Connection);
   --Connections.Connection_Send.What(Connection,"BBBBBBBBBBB");
   --Connections.Connection_Read.Join;
   --Connections.Connection_Send.Join;
   --Connections.Connection_Read.Start(Connection);
   --Connections.Connection_Send.What(Connection,"BBBBBBBBBBB");
   --Connections.Connection_Read.Join;
   --Connections.Connection_Send.Join;
   --Connection.Finish;

   -- 3. Generate cipher keys
   --  3.1. Diffie Hellman secret generation
   Source_Crypto_Payload := Diffie_Hellman.Create_Crypto_Payload(Secret => Diffie_Hellman_Secret);

   --Connection.Inerchange_Cryptos(Packet => Source_Crypto_Payload);

   Crypto_Payload_Bytes_Var := Crypto_Payload_To_Bytes(Source_Crypto_Payload);
   --Put_Line(Byte'Image(Crypto_Payload_Bytes));

   -- Print the Array As Bytes
   for I in Crypto_Payload_Bytes_Var'Range loop
      Ada.Text_Io.Put (Byte'Image (Crypto_Payload_Bytes_Var(I)));
   end loop;


   Test := Bytes_To_Crypto_Payload(Crypto_Payload_Bytes_Var);
   Put("Secret generated for Diffie-Hellman: "); Unsigned_64_IO.Put(Test.Base); Put_Line("");

   Put_Line("TEST =============");
   Connections.Connection_Read_Bytes.Start(Connection);
   Connections.Connection_Send_Bytes.What(Connection, Crypto_Payload_Bytes_Var);
   Connections.Connection_Read_Bytes.Join;
   Connections.Connection_Send_Bytes.Join;
   Connection.Finish;


   --  3.2. Interchange Modulus, Base and public secret
   --  TODO
   --  3.3. Initiate RC4 cipher on both sides
   --  TODO

   --Cli.User_Interface_Controller;
exception
   when E: Others =>
      Put_Line(Exception_Message(E));
      return;


end Main;
