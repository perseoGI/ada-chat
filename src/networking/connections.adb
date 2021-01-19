package body Connections is

   ----------
   -- Init --
   ----------

   procedure Init
     (This : in out Object; Addr_Dst : String; Port_Dst : Port; Port_Org : Port)
   is
	   --Declaraciones
      task Cliente is
         entry Initialized;
      end Cliente;

      task Server is
         entry Initialized;
      end Server;

      --Implementaciones
	   task body Cliente is
         accept Initialized;
         Create_Socket(Socket => This.Client);

         Connect_Socket(Socket => This.Client,
                        Family => Family_Inet,
                        Addr => Inet_Addr(Addr_Dst),
                        Port => Port_Dst);
      end cliente;

      task body Server is
         accept Initialized;
         Create_Socket(Socket => This.Server);
         Bind_Socket(Socket  => This.Server,
                     Address => Family_Inet);
         Listen_Socket(Socket => This.Server,
                       Length => 1);
      end Server;
   --main
   begin
      Initialize;
      Cliente.Initialized;
      Server.Initialized;
   end Init;

   ------------
   -- Finish --
   ------------

   procedure Finish (This : in out Object) is
   begin
      Close_Socket(This.Client);
      Close_Socket(This.Server);
      Finalize;
   end Finish;

   ----------
   -- Send --
   ----------

   procedure Send (This : in out Object; Msg : String) is
   begin
      String'Write(Stream(This.Client),Msg);
   end Send;

   ----------
   -- Read --
   ----------

   procedure Read (This : in out Object; Msg : out String) is
   Offset : Ada.Streams.Stream_Element_Count;
   Data   : Ada.Streams.Stream_Element_Array (1 .. 256);
   begin
      loop
         Ada.Streams.Read (Stream(Server).All, Data, Offset);
         exit when Offset = 0;
         for I in 1 .. Offset loop
            Ada.Text_IO.Put (Character'Val (Data (I)));
         end loop;
      end loop;
   end Read;

end Connections;
