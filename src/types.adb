with Ada.Text_IO;

package body Types is
   function Crypto_Payload_To_Bytes(Input: Crypto_Payload) return Byte_Array is
      Result : Constant Crypto_Payload_Bytes;
      For Result'Address use Input'Address;
      Pragma Import( Convention => Ada, Entity => Result );
   begin
      Return Result;

   end Crypto_Payload_To_Bytes;

   -- Converting bytes to record... in Ada 2012!
   Function Bytes_To_Crypto_Payload( Input : Crypto_Payload_Bytes ) return Crypto_Payload is
      Result : Crypto_Payload with
      Import, Convention => Ada, Address => Input'Address;
   begin
      Return Result;
   end Bytes_To_Crypto_Payload;

   procedure Print_Crypto_Payload (Crypto : in Crypto_Payload) is
      use Ada.Text_IO;
   begin
      Put("Base generated for Diffie-Hellman: "); Unsigned_64_IO.Put(Crypto.Base); Put_Line("");
      Put("Modululs generated for Diffie-Hellman: "); Unsigned_64_IO.Put(Crypto.Modulus); Put_Line("");
      Put("Public generated for Diffie-Hellman: "); Unsigned_64_IO.Put(Crypto.Public); Put_Line("");
   end;

end Types;
