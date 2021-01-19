with Ada.Streams;

package body Connections is
    use Ada.Streams;

    ----------
    -- Init --
    ----------

    procedure Init
        (This : in out Object; Addr_Dst : String; Port_Dst : Port; Port_Org : Port)
    is
        --Declaraciones
        task Client_Task is
            entry Initialized;
        end Client_Task;

        task Server_Task is
            entry Initialized;
        end Server_Task;

        --Implementaciones
        task body Client_Task is
            Address: Sock_Addr_Type;
        begin
            Address.Addr := Inet_Addr(Addr_Dst);
            Address.Port := Port_Type(Port_Dst);

            accept Initialized;
            Create_Socket(Socket => This.Client);
            Put_Line("C: After create");

            Connect_Socket(
                Server => Address,
                Socket => This.Client);
            Put_Line("C: After connect");
            end client_Task;


        task body Server_Task is
            Address: Sock_Addr_Type;
        begin
            Address.Addr := Inet_Addr("127.0.0.1");
            Address.Port := Port_Type(Port_Org);

            accept Initialized;
            Create_Socket(Socket => This.Server);
            Put_Line("After Created");
            Bind_Socket(Socket  => This.Server,
            Address => Address);
            Put_Line("After Binded");
            Listen_Socket(Socket => This.Server,
                        Length => 1);
            Put_Line("After Listen");

            Accept_Socket(This.Server, This.Server, Address);
            Put_Line("After Accept");

        end Server_Task;
        --main
    begin
        Initialize;
        Client_Task.Initialized;
        Server_Task.Initialized;
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
        --task Run;
        --task body Run is
        begin
                --String'Write(Stream(This.Client), Msg);
                String'Output(Stream(This.Client), Msg);
        --end Run;
    --begin
        Put_Line("Sending message...");

    end Send;

    ----------
    -- Read --
    ----------

    procedure Read (This : in out Object) is
        --Offset : Ada.Streams.Stream_Element_Count;
        --Data   : Ada.Streams.Stream_Element_Array (1 .. 256);
        task Run;
        task body Run is
            Message : String := String'Input(Stream(This.Server));
        begin
            Put_Line("AAa");
        end Run;
    begin
        Put_Line("In read before read");

        --Ada.Streams.Read(Stream(This.Server).All, Data, Offset);
        Put_Line("In read after read");
        --loop
            --Ada.Streams.Read (Stream(This.Server).All, Data, Offset);
            --exit when Offset = 0;
            --for I in 1 .. Offset loop
                --Ada.Text_IO.Put (Character'Val (Data (I)));
                --Put_Line ("");
            --end loop;
        --end loop;
    end Read;

end Connections;
