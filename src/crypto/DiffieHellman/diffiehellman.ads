with Ada.Text_IO;
with Types;
package DiffieHellman is
    use Types;

    package Unsigned_64_IO is new Ada.Text_IO.modular_io(U64);
    function Create_Crypto_Payload (Secret: out U64) return Crypto_Payload;

    procedure Test;
    -- Private
    --function Compute (Base, Exp, Modulus : U64) return U64;
    --procedure Generate_Modulus_And_Base (Modulus: out U64; Base: out U64);
    --function Generate_Secret return U64;

end DiffieHellman;
