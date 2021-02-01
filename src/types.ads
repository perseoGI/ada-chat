with Ada.Strings.Bounded;
with Ada.Text_IO;
with Interfaces;
package Types is

    type U64 is mod 2 ** 64;

    package Unsigned_64_IO is new Ada.Text_IO.modular_io(U64);

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

   -- Subtype-renaming.
   Subtype Byte is Interfaces.Unsigned_8;
   -- General type for conversion to a collection of bytes.
   Type Byte_Array is Array (Positive Range <>) of Byte;
   -- Speciffic collection of bytes from The_Record.
   -- TODO
   Subtype Crypto_Payload_Bytes is Byte_Array(1..Crypto_Payload'Size/Byte'Size);

   function Crypto_Payload_To_Bytes(Input: Crypto_Payload) return Byte_Array;
   -- Converting bytes to record... in Ada 2012!
   Function Bytes_To_Crypto_Payload( Input : Crypto_Payload_Bytes ) return Crypto_Payload;

   Procedure Print_Crypto_Payload (Crypto : in Crypto_Payload);

end Types;
