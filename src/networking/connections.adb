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

         Connect_Socket (Server => Address, Socket => This.Client);
         accept Join;
      end Client_Task;

      task body Server_Task is
         Address : Sock_Addr_Type;
      begin
         Address.Addr := Inet_Addr ("127.0.0.1");
         Address.Port := Port_Type (Port_Org);

         accept Initialized;
         Create_Socket (Socket => This.Server);
         Bind_Socket (Socket => This.Server, Address => Address);
         Listen_Socket (Socket => This.Server, Length => 1);
         Accept_Socket (This.Server, This.Server, Address);
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
      Msg  : Unbounded_String;
   begin
      loop
         select
            accept What (This_p : in out Object; Msg_a : in String) do
               This := This_p;
               Msg  := To_Unbounded_String (Msg_a);
            end What;
         or
            terminate;
         end select;
         String'Output (Stream (This.Client), To_String (Msg));
         accept Join;
      end loop;
   end Connection_Send;

----------
-- Read --
----------
--call asyncrounoysly
   task body Connection_Read is
      This : Object;
   begin
      loop
         select
            accept Start (This_p : in out Object) do
               This := This_p;
            end Start;
         or
            terminate;
         end select;
         Put_Line (String'Input (Stream (This.Server)));
         accept Join;
      end loop;
   end Connection_Read;

end Connections;
