with GNAT.Sockets; use GNAT.Sockets;
with Ada.Text_IO; use Ada.Text_IO;

package Connections is
   --typedefs
   type Port is mod 65536;

   --datos
   type Object is tagged record
      Port_Dst, Port_Org : Port := 0;
      Client, Server : Socket_Type;
   end record;

   --metodos
   procedure Init(This: in out Object;
                  Addr_Dst: String;
                  Port_Dst: Port;
                  Port_Org: Port);
   procedure Finish(This: in out Object);
   procedure Send (This: in out Object; Msg: String);
   procedure Read (This : in out Object);
end Connections;
