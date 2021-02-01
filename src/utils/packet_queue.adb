with Ada.Containers.Unbounded_Synchronized_Queues;
with Types;

package body Packet_Queue is
    use Types;

    procedure Enqueue_Packet (This : in out Packets_Queue; New_Packet : in Packet) is
    begin
        This.Queue.Enqueue(New_Item => New_Packet);
    end Enqueue_Packet;

    function Dequeue_Packet (This : in out Packets_Queue) return Packet is
        Item: Packet;
    begin
        This.Queue.Dequeue (Element => Item);
        return Item;
    end Dequeue_Packet;

end Packet_Queue;
