with Ada.Containers.Synchronized_Queue_Interfaces;
with Ada.Containers.Unbounded_Synchronized_Queues;
with Types; use Types;

package Packet_Queue is

    package Packet_Item_Queue_Interface is
        new Ada.Containers.Synchronized_Queue_Interfaces (Element_Type => Packet);

    package Packet_Item_Queues is
        new Ada.Containers.Unbounded_Synchronized_Queues
            (Queue_Interfaces => Packet_Item_Queue_Interface);

    type Packet_Pointer is
     access Packet_Item_Queues.Implementation.List_Type;

    type Packets_Queue is tagged record
    --type Packets_Queue is record
        --Queue : Packet_Item_Queues.Queue;
        Queue : Packet_Pointer;
    end record;

    --procedure Create_Packet_Queue;
    procedure Enqueue_Packet (This : in out Packets_Queue; New_Packet : in Packet);
    function Dequeue_Packet (This : in out Packets_Queue) return Packet;

end Packet_Queue;
