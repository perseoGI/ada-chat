with GNAT.Sockets; use GNAT.Sockets;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

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

   --tareas
   task Connection_Send is
      entry What (This_p : in out Object; Msg_a : in String);
      entry Join;
   end Connection_Send;

   task Connection_Read is
      entry Start(This_p : in out Object);
      entry Join;
   end Connection_Read;
end Connections;
