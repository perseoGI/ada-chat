with Ada.Streams;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Connections is
   use Ada.Streams;

   ----------
   -- Init --
   ----------

   procedure Init
     (This     : in out Object; Addr_Dst : String; Port_Dst : Port;
      Port_Org :        Port)
   is
      --Declaraciones
      task Client_Task is
         entry Initialized;
         entry Join;
      end Client_Task;

      task Server_Task is
         entry Initialized;
         entry Join;
      end Server_Task;

      --Implementaciones
      task body Client_Task is
         Address : Sock_Addr_Type;
      begin
         Address.Addr := Inet_Addr (Addr_Dst);
         Address.Port := Port_Type (Port_Dst);

         accept Initialized;
         Create_Socket (Socket => This.Client);
         Put_Line ("C: After create");

         Connect_Socket (Server => Address, Socket => This.Client);
         Put_Line ("C: After connect");
         accept Join;
      end Client_Task;

      task body Server_Task is
         Address : Sock_Addr_Type;
      begin
         Address.Addr := Inet_Addr ("127.0.0.1");
         Address.Port := Port_Type (Port_Org);

         accept Initialized;
         Create_Socket (Socket => This.Server);
         Put_Line ("After Created");
         Bind_Socket (Socket => This.Server, Address => Address);
         Put_Line ("After Binded");
         Listen_Socket (Socket => This.Server, Length => 1);
         Put_Line ("After Listen");

         Accept_Socket (This.Server, This.Server, Address);
         Put_Line ("After Accept");
         accept Join;
      end Server_Task;
      --main
   begin
      Initialize;
      Client_Task.Initialized;
      Server_Task.Initialized;
      Client_Task.Join;
      Server_Task.Join;
   end Init;

   ------------
   -- Finish --
   ------------

   procedure Finish (This : in out Object) is
   begin
      Close_Socket (This.Client);
      Close_Socket (This.Server);
      Finalize;
   end Finish;

   ----------
   -- Send --
   ----------
   --call asyncrounoysly
   task body Connection_Send is
   --task Run;
   --task body Run is
      This : Object;
      Msg : Unbounded_String;
   begin
      accept What (This_p : in out Object; Msg_a : in String) do
         This := This_p;
         Msg := To_Unbounded_String(Msg_a);
      end What;
      String'Output (Stream (This.Client), To_String(Msg));
      accept Join;
   end Connection_Send;

   ----------
   -- Read --
   ----------
   --call asyncrounoysly
   task body Connection_Read is
      This: Object;
   begin
      accept Start (This_p : in out Object) do
         This := This_p;
      end Start;
      Put_Line (String'Input (Stream (This.Server)));
      accept Join;
   end Connection_Read;

end Connections;
