with Ada.Strings.Bounded;
package Types is
    type U64 is mod 2 ** 64;

    type Message_Size is range 1..512;

    package Content_String is new Ada.Strings.Bounded.Generic_Bounded_Length(512); use Content_String;
    type Packet_Payload_Type is (Crypto, Application);

    type Crypto_Payload is record
        Base: U64;
        Modulus: U64;
        Public: U64;
    end record;

    type Application_Payload is record
        Content: Content_String.Bounded_String;
    end record;

	type Packet is record
        Packet_Type: Packet_Payload_Type;
        Content_Size: Message_Size;
        --Date_Send:  TODO
		Content: Content_String.Bounded_String;
	end record;


end Types;
